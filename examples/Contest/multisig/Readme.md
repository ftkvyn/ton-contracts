# Multisignature contract
Multisignature contract allows to share control over message sending between separate parties.
In particular it allows to send grams, other currencies or messages to other contracts if and only if at least N parties are agree and authorize this action by signing.

This contract may accept orders (request of sending message with money) which are already signed by required number of parties as well as partially signed orders. In the latter case partially signed order will be stored in the contract storage and will collect authorization signatures untill threshold is passed. Every order may carry up to 255 messages

Along with creating of new orders and signing partial orders, that contract also allows to update it's own code if all parties are agree.

This contract follows smart contract guidelines as well smart contract guideline proposals.

## Package
Files in this package:
0. `Readme.md` - this file
1. `multisig.fc` - funC code of contract
2. `multisig_state_init.fc` - funC code that generate init storage of contract
3. `multisig.fif` - automatically built fift code (`multisig.fc`)
4. `multisig_state_init.fif` - automatically built fift code (`multisig_state_init.fc`)
5. `generate-key-pair.fif` - generates and save to file keypair
6. `init-multisig.fif` - generate and save to file
6. `create-new-order.fif` - creates new order and save it to the file, signatures may be added to this file later
7. `sign-partial.fif` - creates new message which add signatures to partial order stored in contract steorage, saves message to the file. Signatures may be added to this file later
8. `add-signature.fif` - Add signtatures to order and partial orders files.
9. `merge-partials.fif` - Merge two files which add signatures to some partial order.
10. `build.sh` - builds funC code to fift scripts (some adjustment may be required)
11. `test.fif` - test contract
12. `multisig_data_layout.md` - Documentation: describe layout of persistent storage and messages.
13. `convert-address.fif` - convert address from int to raw and userfriendly
14. some standart funC and fift libraries

## Usage
Note that all provided script has help. It will be printed if `--help` flag will be passed to it.
### Multisignature contract creation
Parties should generate their own private and public keys separately using script `generate-key-pair.fif`.

After that public keys should be shared and one party need to generate contract init message using `init-multisig.fif`.

That party should deploy contract by sending small amount of money in non-bounce regime to the address generated on previpous step and then sending `multisig-init.boc` to the network:
```
lite-client -C PATH_TO_CONFIG.config.json -rc "sendfile PATH_TO_BOCS/multisig-init.boc"
```

After that party should share with others address of multisignature contract and every other party should check params of deployed contract. It can be made by running:
```
lite-client -C PATH_TO_CONFIG.config.json -rc "runmethod MULTISIG_ADDRESS show_general_info"
```
This comand will return tuple of `[N, K, [... keys ...]]`, where `N` is minimal number of signatures to authorize action, `K` is total number of keys and `[... keys ...]` is a tuple of public keys.

Every party should check `N`, `K` and that his public key is on the list. After that it should wait until every other party will confirm that checked params as well.

After that multisignature contract may be used.

### Multisignature usage
#### Create
To create order check current seqno of contract by
```
lite-client -C PATH_TO_CONFIG.config.json -rc "runmethod MULTISIG_ADDRESS seqno"
```
use `create-order.fif` and follow `--help` instruction.

Note used `seqno` become `order_id` (which should be used for further signing) if sent order is not fully signed.

Send obtained `boc`-file to the network or counterparties to co-sign it.
#### Sign pending
To sign pending order first check params of that order:
```
lite-client -C PATH_TO_CONFIG.config.json -rc "runmethod MULTISIG_ADDRESS show_order order_id"
```
It returns a tuple of tuple about messages which will be sent when after minimal amount of authorization signatures will be collected. Each child tuple contain information about one message in the following format: `[mode, workchain, destination_address, nanograms, bounce]`.
Pay special attention to all those values (note that `mode` higher than 128 means that all funds on contracts will be sent, no matter how much nanograms is specified). You may use `convert-address.fif` to convert tuple `[workchain , destination_address]` to raw/userfriendly format.

Check `order_seqno` by 
```
lite-client -C PATH_TO_CONFIG.config.json -rc "runmethod MULTISIG_ADDRESS order_seqno ORDER_ID"
```
Use `sign-partial.fif` and follow `--help` instruction.
Send obtained `boc`-file to the network or counterparties to co-sign it.

#### Update wallet
No scripts are yet developed. (Maybe developed in the future, smartcontract have ability to update)

#### List of suppodtred get methods
Some useful getmethods are listed below:
1. `seqno` - (no params) - return current seq_no number used for replay protection
2. `order_seqno` - (int `order_id`) - return current seq_no number for order used for replay protection
3. `all_pending_orders` - (no params) - return `Dictionary` with all pending orders
4. `all_pending_orders_unsigned_by_key` - (int `pubkey`) - return `Dictionary` with all pending orders unsigned by key
5. `all_pending_orders_signed_by_key`  - (int `pubkey`) - return `Dictionary` with all pending orders signed by key
6. `pending_orders` - (no params) - return `tuple` (viewable in lite-client response) with up to 255 pending orders
7. `pending_orders_unsigned_by_key`  - (int `pubkey`) - return `tuple` with up to 255 pending orders unsigned by key
8. `pending_orders_signed_by_key` - (int `pubkey`) - return `tuple` with up to 255 pending orders signed by key
9. `show_order` - (int `order_id`) - show basic order info `[mode, workchain, destination_address, nanograms, bounce]`
10. `show_general_info` - show basic multisignature contract info `[N, K, [... pubkeys ...]]`


## Build


