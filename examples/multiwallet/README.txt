 0. File description
~~~~~~~~~~~~~~~~~~~~~
"multiwallet-code.fc" - funC source code
"multiwallet-code.fif"

"public-keys.fif" - list of public keys for creating a wallet
"new-multiwallet.fif" - creates a message to initialize
"new-request.fif" - creates a new request for sending currency
"sign-request.fif" - adds a signature to the message

"private-to-public.fif" - gets public key from private
"get-signer-id.fif" - gets the public key serial number

"<filename-base>-keys.boc" - dictionary of public keys and their serial numbers

1. Creating a new multi-signature wallet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
to create a wallet with <n> signatures, file "public-keys.fif" must contain a list with <n-1> public keys
(the last key will be generated or loaded at creation)
after you need to run the script "new-multiwallet.fif" and pass it <workchain-id> <n> <k> [<output-filename>]" as arguments
<k> - is the required number of signatures to process the transfer order
script will create a message to initialize the smart contract "<output-filename>.boc",
print the address of the contract and save it in "<output-filename>.addr",
creates the last key and stores it in "<output-filename>.addr"
and creates a file "<output-filename>-keys.boc" that is necessary for other scripts to work

 2. Сreating a new wallet contract request
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"new-request.fif" - creates a new request to the smart contract using arguments:
<filename-base> <private-key-file> <dest-addr> <seqno> <amount> <timeout> [<savefile>]
"<filename-base>-keys.boc" - necessary for work
"<filename-base>.addr" - source wallet address
"<private-key-file>.pk" - private key for signing
<dest-addr> - currency recipient address
<amount> - amount of currency 
<timeout> - expiration Unix time, if the value is less 
than the current time, the current time will be added to it
message will be saved to "<savefile>.boc" ('wallet-query.boc' by default)

 3. Adding signatures to message
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
"sign-request.fif" - adds a signature to the message using arguments:
<request-file> <private-key-file> <filename-base>
"<request-file>.boc" - message file
"<private-key-file>.pk" - private key for signing
"<filename-base>-keys.boc" - necessary for work
the new message will be saved to "<request-file>.boc"

 4. Get methods
~~~~~~~~~~~~~~~~
seqno - returns current seqno value

get_orders_all - returns all pending (partially signed) orders
get_orders_signed_by( key_number ) - returns all pending orders signed by public key with serial number <key_number>
get_orders_unsigned_by( key_number ) - returns all pending orders not signed by public key with serial number <key_number>

return format:
[ <expiration Unix time> <signers bitmask> [ [ <workchain> <address> ] <nanograms amount> ] ] or [<expiration Unix time> <signers bitmask> (null) ]

<key_number> can be found using the script "get-signer-id.fif" for example:
$ fift -s .../get-signer-id.fif new-multi-wallet 09CA116968504DE6462BD3809FD47EC6016F9CC2EFD347AA86CC1452EF1D078B
...
You id: 7