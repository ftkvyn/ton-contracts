# Proposals
All proposals here are not implemented, however basing on my experience I strongly believe they will improve quality of FunC code and reduce number of bugs.
## Dict types
Dicts and Cells should be separated into different classes on funC level (while still be the same cell on TVM level). Moreover Dict type should also not be unified for all Dict types: thus starting with parent class Dict during first dict operation (serch, add, delete etc) object should be implicitlt casted to child Dict class for instance (UDict32, IDict7, PfxDict1023 etc). Of course there should be possibility to explicitly chose the given type.
## Initial storage generation on FunC level 
It is possible to generate initial persistent storage and even initial state directly from funC code.
To demonstrate that I moved initial storage generation of multisignature contract into `multisig_init_storage.fc`. 
Instead building it manually in fift (thus having 2 different languages codebase to generate one contract) we may generate most of the code on the funC level, while on fift we only interact with user and filesystem.
The same way it is possible to generate messages.
This way, given that we have 3 section in our funC source file: contract code, contract storage generation, contract message generation, funC compiler
should generate 4 separate files: code, code of storage generation, code of message generation and finally `main.fif` which will include all previous files and provide way to generate all types of messages: from init to handlers.
## Complex types
In contrast with previous proposals I'm not sure how to implement this and how it will change effectiveness of produced code. I propose to generate complex types, with description given in TL-B notation and methods (analogues to structures and classes in C++).
