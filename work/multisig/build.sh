rm ./dist/*.*
rm ./temp/*.fif
func -AP -O0 -o ./dist/new-multisig-programm.fif ./lib/stdlib.fc ./src/multisig.fc
cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif > ./dist/new-multisig.fif
cp ./src/multisig-transaction.fif ./dist/multisig-transaction.fif
cp ./src/sign-message.fif ./dist/sign-message.fif

cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif ./test/init-c7.fif ./test/test-1_script.fif > ./temp/test-1.fif

cat ./dist/new-multisig-programm.fif ./src/new-multisig-wallet_script.fif ./test/init-c7.fif ./test/test-2_script.fif > ./temp/test-2.fif
sed -i 's/0 constant seq_no/3 constant seq_no/' ./temp/test-2.fif

cat ./dist/new-multisig-programm.fif ./dist/multisig-transaction.fif ./test/test-storage.fif ./test/init-c7.fif ./test/test-3_script.fif > ./temp/test-3.fif
sed -i 's/0 constant seq_no/1 constant seq_no/' ./temp/test-3.fif
sed -i 's/#!\/usr\/bin\/env fift -s/constant code/' ./temp/test-3.fif

cat ./dist/new-multisig-programm.fif ./dist/multisig-transaction.fif ./test/test-storage.fif ./test/init-c7.fif ./test/test-4_script.fif > ./temp/test-4.fif
sed -i 's/0 constant seq_no/1 constant seq_no/' ./temp/test-4.fif
sed -i 's/#!\/usr\/bin\/env fift -s/constant code/' ./temp/test-4.fif

cat ./dist/new-multisig-programm.fif ./dist/multisig-transaction.fif ./test/test-storage.fif ./test/init-c7.fif ./test/test-5_script.fif > ./temp/test-5.fif
sed -i 's/0 constant seq_no/1 constant seq_no/' ./temp/test-5.fif
sed -i 's/#!\/usr\/bin\/env fift -s/constant code/' ./temp/test-5.fif

cat ./dist/new-multisig-programm.fif ./dist/multisig-transaction.fif ./test/test-storage.fif ./test/init-c7.fif ./test/test-6_script.fif > ./temp/test-6.fif
sed -i 's/0 constant seq_no/1 constant seq_no/' ./temp/test-6.fif
sed -i 's/#!\/usr\/bin\/env fift -s/constant code/' ./temp/test-6.fif

mkdir -p temp
cd temp
fift -s ./../dist/new-multisig.fif 0 6 4 test-run
fift -s ./test-1.fif 0 6 4 test-run
fift -s ./test-2.fif 0 6 4 test-run
fift -s ./test-3.fif test-run 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 1 1 hello
fift -s ./test-4.fif test-run 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 1 1 hello
fift -s ./test-5.fif test-run 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 1 1 hello
fift -s ./test-6.fif test-run 3 0QCyt4ltzak71h6XkyK4ePfZCzJQDSVUNuvZ3VE7hP_Q-GTE 1 1 hello