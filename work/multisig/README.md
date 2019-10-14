The folder contains all the sources of multi-signature wallet.
To build contracts from source run: 

./build.sh

To create new contract use:

fift -s ./dist/new-multisig.fif 0 6 4 wallet-name

To create a new transaction use:

fift -s ./dist/multisig-transaction.fif wallet-name 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 5 1 hello

To sign previously created transaction use:

fift -s ./dist/sign-message.fif wallet-name 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 5 1 hello 1571070106

Following get-methods are avaliable:

* seqno (*85143*) - returns current stored seq_no for creating new transactions.
* pending_orders (*103571*) - returns the list of all partially signed orders. Each order here is a cell that has **order format** described below.
* signed_orders (*122190*), args: uint(256) *pubkey* - returns the list of all pending orders that are signed by given *public key*.
* not_signed_orders (*121650*), args: uint(256) *pubkey* - returns the list of all pending orders that are not yet signed by given *public key*.

**Order format**

Each order is a cell that consists of the following:

<b b{01} s, bounce 1 i, b{000100} s, dest_addr addr, amount Gram, 0 9 64 32 + + 1+ u, 
  body-cell <s 2dup s-fits? not rot over 1 i, -rot { drop body-cell ref, } { s, } cond
b>
<b seqno 32 u, now timeout + 32 u, send-mode 8 u, swap ref, b>

* uint(32) seqno - the number of the transaction in the wallet.
* uint(32) timeout - the moment of the expiration of the transaction.
* uint(8) send-mode - the mode of the message, by default b{11} - sender pays the fee and ignoring errors.
* cell reference - to the cell with the **inner message** to be sent by the contract when enough signs are collected.

**Inner message format**

* slice = b{01} 
* int(1) bounce - bounce flag.
* slice = b{000100}
* addr - addres of the destination wallet that will recieve the funds.
* Gram amount - amount to be sent.
* uint(106) = 0
* cell reference - to the body cell containing predefinded cell or uint(32) = 0 and a slice representing a string message.