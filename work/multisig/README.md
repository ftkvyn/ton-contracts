The folder contains all the sources of multi-signature wallet.
To build contracts from source run: 

./build.sh

To create new contract use:

fift -s ./dist/new-multisig.fif 0 6 4 wallet-name

To create a new transaction use:

fift -s ./dist/multisig-transaction.fif wallet-name 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 5 1 hello