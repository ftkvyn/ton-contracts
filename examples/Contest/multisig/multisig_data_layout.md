#Overview
This document contains info about structure of internal contract storage and all types of internal and external messages which are handled by multiowner contract.

As of now there are 4 types of external messages: `init`, `regitster_order`, `add_signature_to_order`, `update_contract_code`.

In round brackets type and size in **bits** are denoted. `b` stands for bits, `ui` for unsigned integers, `si` for signed integers, `xN` after type-size denote sequential array of `N` elements.

Variables, dictionaries and references of the cell are shown on separate lines with indentation (level of cell + 1). Types of keys and values of the dictionaries are denoted in curly brackets. After colons is shown the usual _variable name_ used in contract code.

# Used types
We use a few composite types in contract. Scheme of serialization is shown below:
### Message
```
root_cell: message_root
  mode(ui8)
  ref1_cell: message_body
    raw_message
```
### StoredOrder
Stored Order is partially signed order which may contain up to 127 message which should be set after signing.
```
root_cell: order_root
  per_order_seqno(ui16), unix_time_bound(ui32), min_signature_num(ui8), obtained_signatures_num(ui8)
  dict {pubkey(b256) -> (null_cell)} : obtained_signatures_dict
  dict {index(ui7) -> Message} : messages_dict
```

# Persistent storage alignment
Contract use persistant storage for antireplay variables, public keys and partially signed orders.

Each partially signed order contain information about `min_signature_num`, `per_order_seqno`, a dicitionary of messages which should be sent after order will be appropriately signed and array of send-`mode`s of those messages.
`N` is number of messages in one order, it must be less or equal to 124.

### Storage alignment
```
root_cell:
  seq_no(ui32), threshold_num(ui8)
  dict {pubkey(ui256) -> (null_cell)} : keys_dict
  dict(order_index(b32)-> StoredOrder) : stored_orders
```


#External message alignment

##init
`op_num` = `0x0`

```
root_cell:
  op_num(ui8)
```
## regitster_order
`op_num` = `0x1`
```
root_cell:
  op_num(ui8), seq_no(ui32), unix_time_bound(ui32), min_signature_num(ui8), uniq_token(ui64),  pubkey(ui256), signature(b512)
  dict {pubkey(ui256) -> signature(b512)} : provided_signatures
  dict {index(ui7) -> Message} : order_dict
```

signature is ed25519 signature over `cell_hash` of the
```
root_cell:
  op_num(ui8), seq_no(ui32), unix_time_bound(ui32), min_signature_num(ui8), uniq_token(ui64)
  dict {index(ui7) -> Message} : order_dict
```
## add_signature_to_order
`op_num` = `0x2`

Here `seq_no` is `order_id` of signed order.

```
root_cell:
  op_num(ui8), seq_no(ui32), uniq_token(ui64), pubkey(ui256), signature(b512), per_order_seqno(ui16)
  dict {pubkey(ui256) -> signature(b512)} : provided_signatures
```
signature is ed25519 signature over `cell_hash` of the
```
root_cell:
  op_num(ui8), seq_no(ui32), uniq_token(ui64), per_order_seqno(ui16)
```

