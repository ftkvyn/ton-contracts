# DNS contracts
Each contract may resolve arbitrary level domains (full length <= 127 characters including delimiters) as well as delegate some sub-domains to other dns.

This way, for instance, contract may simultaneously resolve all domains `domain1.*[.*.*]` while delegating `domain2.*[.*.*]` to other dns contracts.

# Automatic DNS
This DNS contract allows to register, prolongate and update domains by sending internal messages. Renewal fees are charged for three things: `top-level` domain name (the shorter the name the higher the fee, see `calc_price_per_year`), each stored cell and each subdomain (see `get_price_for_storage`). At the same time domain update is not charged. 

If renewal fee was not paid at time, there is grace period of 1 month (see `garbage_collection`) to pay, after that all top-level domain data including all subdomains will be deleted. Special attention is paid to make garbage collection effective: only domains which should be deleted are checked.

## Usage
All scripts has `--help` menu.
### Create contract
Generate boc-file with `init-adns.fif` (see help).

### Use contract
Scripts listed below produce BOC files which should be sent to DNS contract using for instance `-B` interface of simple wallet.
 
To register domain use `adns-register-domain.fif` (check `-O` flag to be able to update domain in the future).
Fot instance:
```
./lite-client -C ton-lite-client-test1.config.json -rc "runmethod DNSADDRESS dnsresolve \"DOMAINNAME\" CATEGORY"
```

To update domain use `adns-update-domain.fif` (note: first domain records which passed as `added records` added (with replacement) then records which passed as `remove records` are removed).


To update domain use `adns-update-domain.fif` (note: first domain records which passed as `added records` added (with replacement) then records which passed as `remove records` are removed).

To add subdomain use `adns-create-subdomain.fif`. Subdomain addition, removal, dns records addition and removal may be done simultaneously but since CLI interface for such contract became cumbersome this script is not developed (instead more useful GUI wrapper should be used, something like valeriton.com (cryptography-on-client interface) ).

To check expiration info `get_expiration_info` method should be used. It requires passing of unixtimestamp for correct estimation of remaining balance
```
./lite-client -C ton-lite-client-test1.config.json -rc "runmethod DNSADDRESS get_expiration_info \"DOMAINNAME\" UNIXTIMESTAMP"
```
It returns  time to expiration, number of used cells, number of registered sub domains, remaining_balance.

