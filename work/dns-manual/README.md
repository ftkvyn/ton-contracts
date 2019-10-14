The folder contains all the sources of manual DNS resolver.
To build contracts from source run: 

./build.sh

To create new resolver use:

fift -s ./dist/new-resolver.fif 0 resolver-name

To update resolvers stored public key use:

fift -s ./dist/dns-resolver-key-update.fif resolver-name old-key-file new-key-file

To create a