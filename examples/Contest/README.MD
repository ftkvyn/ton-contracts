# Contracts for contest
Here is a set of contracts for Telegram SmartContract Contest.
Two contracts we fully implemented: Automatic DNS and Manual DNS, they are located in `adns` and `mdns` respectively. They allow to registrate and manage multi-level domains in one contract, while allowing to delegate some brunches to other contracts. Pay-per-storage mechanism implemented for automatic dns contract.

There is also fully implemented and tested multisignature contract located in `multisig` directory. This contract contain proposed by me guidelines (see `Guideline_proposal.md`), thus it eliminates risk of signature reusage between different multisig contracts (or even other contracts) controlled by the same private keys, and also allows to sign different partial orders in parallel without checking seq_no sequnce. Finally it allows to send up to 127 messages in one order.

However this contract contains severe bug: head signature does not cover additional signatures (made by other owner of multisignature owner). This way any retranslating node may push addishional invalid signatures (or remove valid) inside previously correct message and thus cause excessive gas usage (for checking garbage) or delaying authorization (for not checking valid signatures).

This problem is completely solved in another multisignature contract located in `new_multisig` directory. That version is also optimized for gas usage and somewhat tested. However there are only scripts for `init`, creating new orders and signing existing orders, and no fift scripts for merging signatures and cosigning orders. So, while smart contrac is usable and (as I think) has no flaws, there are still work to do to make it usable for end users.
