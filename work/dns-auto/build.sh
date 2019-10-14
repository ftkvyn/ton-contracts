rm ./dist/*.*
rm ./temp/*.fif
func -AP -O0 -o ./dist/new-dns-auto-programm.fif ./lib/stdlib.fc ./src/dns-resolver.fc
cat ./dist/new-dns-auto-programm.fif ./src/new-resolver_script.fif > ./dist/new-resolver.fif

mkdir -p temp
cd temp
fift -s ./../dist/new-resolver.fif 0 1 0.001 0.000001 test-run