# Vigenere Cipher Command

The command can be run with ```vigenere```, and contains all documentation! It is in the out/ directory!

Please note that the implementation of the cipher cracking is not completed yet - I will submit a new version of this project once it is completed! This has working implementations of decryption and encryption, able to both input and output files with plaintext and ciphertext.

## Building it yourself

However, if you want to play with building it yourself with some cool dev tools...

This project has a few files in it that are pretty cool. One of them is called ```devenv.nix```, which works with a tool called devenv that sets up a complete development shell environment with all necessary dependencies and tools installed. It is built on top of a tool called Nix, a purely functional package manager that lets you declaratively define a project's or system's dependencies.

To get started with it, head over to [devenv.sh](https://devenv.sh) and follow the top of the getting started guide, installing Nix and devenv. After that, come back here and run ```devenv shell```, which will open a shell with OCaml, it's platform tools, and some other fun stuff, as well as printing more instructions.
