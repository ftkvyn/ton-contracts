# DNS contracts
Each contract may resolve arbitrary level domains (full length <= 127 characters including delimiters) as well as delegate some sub-domains to other dns.

This way, for instance, contract may simultaneously resolve all domains `domain1.*[.*.*]` while delegating `domain2.*[.*.*]` to other dns contracts.

## Usage
All scripts has `--help` menu.
### Create contract
Generate boc-file with `init-mdns.fif` (see help).

### Use contract
Scripts listed below produce BOC files which should be sent to DNS contract using for instance `-B` interface of simple wallet.
 
To register domain use `mdns-register-domain.fif` (check `-O` flag to be able to update domain in the future).
Fot instance:
```
./lite-client -C ton-lite-client-test1.config.json -rc "runmethod DNSADDRESS dnsresolve \"DOMAINNAME\" CATEGORY"
```

To update domain use `mdns-update-domain.fif` (note: first domain records which passed as `added records` added (with replacement) then records which passed as `remove records` are removed).

To add subdomain use `mdns-create-subdomain.fif`. Subdomain addition, removal, dns records addition and removal may be done simultaneously but since CLI interface for such contract became cumbersome this script is not developed (instead more useful GUI wrapper should be used, something like valeriton.com (cryptography-on-client interface) ).

