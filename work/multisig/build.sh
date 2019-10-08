rm ./dist/*.*
func -AP -O 0 -o ./dist/new-multisig-programm.fif ./lib/stdlib.fc ./src/multisig.fc
cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif > ./dist/new-multisig.fif
cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif ./test/test-1_script.fif > ./temp/test-1.fif
sed -i 's/recv_external/main/' ./temp/test-1.fif
sed -i 's/recv_internal/recv_internal_deleted/' ./temp/test-1.fif
cd temp
fift -s ./../dist/new-multisig.fif 0 6 4 test-run
fift -s ./test-1.fif 0 6 4 test-run
