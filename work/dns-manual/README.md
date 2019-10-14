# Description

The folder contains all the sources of manual DNS resolver.
To build contracts from source run: 

```
./build.sh
```

To create new resolver use:

```
fift -s ./dist/new-resolver.fif 0 resolver-name
```

To update resolvers stored public key use:

```
fift -s ./dist/dns-resolver-key-update.fif resolver-name old-key-file new-key-file
```

To create new or update an existing dns entry use:

```
fift -s ./dist/update-dns-entry.fif resolver-name key-name 1 myhost 12 0 57738484939495943
```

# Get methods

* seqno (*85143*) - returns current stored seq_no for creating update requests.
* dnsresolve (*123660*) args: string_slice *lookup*, int(16) *category* - lookups host name as described in the contest conditions.
* dnsresolve_test (*94497*) args: string_slice *lookup*, int(16) *category* - same as **dnsresolve**, but assumes that each host name is terminated by space, not zero byte. Used for testing in lite-client.

