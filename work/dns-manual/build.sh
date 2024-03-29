rm ./dist/*.*
rm ./temp/*.fif
func -AP -O0 -o ./dist/new-dns-manual-programm.fif ./lib/stdlib.fc ./src/dns-resolver.fc
cat ./dist/new-dns-manual-programm.fif ./src/new-resolver_script.fif > ./dist/new-resolver.fif
cp ./src/dns-resolver-key-update.fif ./dist/dns-resolver-key-update.fif
cp ./src/update-dns-entry.fif ./dist/update-dns-entry.fif

cat ./test/init-c7.fif ./test/test-storage.fif ./dist/new-dns-manual-programm.fif ./test/test-2_script.fif > ./temp/test-2.fif

cat ./test/init-c7.fif ./dist/new-resolver.fif ./test/test-3_script.fif > ./temp/test-3.fif

cat ./test/init-c7.fif ./dist/new-resolver.fif ./test/test-4_script.fif > ./temp/test-4.fif

cat ./test/init-c7.fif ./test/test-storage.fif ./dist/new-dns-manual-programm.fif ./test/test-5_script.fif > ./temp/test-5.fif

cat ./test/init-c7.fif ./test/test-storage.fif ./dist/new-resolver.fif ./test/test-6_script.fif > ./temp/test-6.fif

mkdir -p temp
cd temp
fift -s ./../dist/new-resolver.fif 0 test-run
fift -s ./test-2.fif
fift -s ./test-3.fif 0 test-run
fift -s ./test-4.fif 0 test-run
fift -s ./test-5.fif 0 test-run
fift -s ./test-6.fif 0 test-run