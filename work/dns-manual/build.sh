rm ./dist/*.*
rm ./temp/*.fif
func -AP -O0 -o ./dist/new-dns-manual-programm.fif ./lib/stdlib.fc ./src/dns-resolver.fc
#cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif > ./dist/new-multisig.fif
#cp ./src/multisig-transaction.fif ./dist/multisig-transaction.fif

cat ./test/init-c7.fif ./test/test-storage.fif ./dist/new-dns-manual-programm.fif ./test/test-2_script.fif > ./temp/test-2.fif
#sed -i 's/0 constant seq_no/5 constant seq_no/' ./temp/test-3.fif
sed -i 's/#!\/usr\/bin\/env fift -s/constant code/' ./temp/test-2.fif

mkdir -p temp
cd temp
fift -s ./test-2.fif