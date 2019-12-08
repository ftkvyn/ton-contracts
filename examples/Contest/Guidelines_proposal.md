# Smart contract guideline proposals
## Replay protection proposal
### Per request `seq_no`
If some actions require (or may require) prolonged interaction offline, it is necessary to introduce per action `seq_no`. Lets consider example of multisignature contract: if one contigent `seq_no` is used for all actions, than if during offline signing of order by many parties a new order will be proposed (and thus increase `seq_no`), all already obtained signatures will be oudated (since they sign outdated `seq_no`).

Instead we propose to use `seq_no` for new actions and `per_action_seq_no` for already registered. Thus interactions with already registered actions are mutually independent: different orders may be signed in parralel without invalidation signatures for each other.

### `seq_no` sometimes is not enough
`seq_no` is used for replay protection, thus the same message cannot be sent twice to one contract. However if there are a few contracts, authorization is implemented by signing order with one (or more) keys and those contracts share keys, message may be replayed against other contract.
For instance we have two multisignature wallets, first one is controlled by (key1, key2, key3) and second one is controlled by (key1, key4). Thus if those wallets authorize order by checking of signatures of (`seq_no`, order), message with order from first wallet signed by key1 may be replayed to second wallet if `seq_no` coinside (quite probable situation). Instead authorization for those mass usage contracts should contain unique for this contract instance information, for instance (`seq_no`, `uniq_token`, order).
We propose to use `uniq_token` equal to first 64 bits of contract address. It gives negligible 5e-20 probability of collision. Note that we do not generally fear collision here, since attacker cannot get any profits by generating himself wallet with the same `uniq_token`, instead she need to find collision in the already generated contracts. Still 5e-20 is good enough to require hashpower approximately equal to all hashpower of modern Bitcoin network to generate such collision.
