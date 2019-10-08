rm ./dist/*.*
func -AP -O 0 -o ./dist/new-multisig-programm.fif ./lib/stdlib.fc ./src/multisig.fc
cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif > ./dist/new-multisig.fif
fift -s ./dist/new-multisig.fif 0 6 4 test-run