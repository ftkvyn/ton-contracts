# Description

The folder contains all the sources of automatic DNS resolver.
To build contracts from source run: 

```
./build.sh
```

To create new resolver use:

```
fift -s ./dist/new-resolver.fif 0 resolver-name
```

# Get methods

* dnsresolve (*123660*) args: string_slice *lookup*, int(16) *category* - lookups host name as described in the contest conditions.
* dnsresolve_test (*94497*) args: string_slice *lookup*, int(16) *category* - same as **dnsresolve**, but assumes that each host name is terminated by dot, not zero byte. Used for testing in lite-client.

# DNS lookup results

*dnsresolve* method returns (int, cell) where int is the length of found subdomain and the cell contains the result address (addr, int(8) workchain_id and uint(256) destination addres in the workchain) in case if the full lookup string found, address of the next resolver (category == -1) if lookup consisted of several subdomains and the dictionary with all categories if the requested category was 0. Format of the dictionary is key - int(16) category id, value - cell with address (addr as described above).