# Vigenere Cipher Command

The command can be run with ```vigenere```, and contains all documentation! Binaries are available in the GitHub release, or you can build it yourself with the instructions below!

Please note that the implementation of the cipher cracking is not completed yet - I will submit a new version of this project once it is completed! This has working implementations of decryption and encryption, able to both input and output files with plaintext and ciphertext.

Also, please make sure to run the built executable **IN THE ROOT DIRECTORY!** There are files in resources/ that it needs access to via a relative path!

# Building it yourself

There are two paths you can take to build this project: Installing OCaml and the OCaml platform tools, or using Nix.

With the OCaml route, you will actually install OCaml on your system like you have Python installed directly on your system. Installing Nix will enable you to build/develop this project in an isolated environment, installing relevant packages only where they need to be and not in your whole system. Nix is really cool - more about it below!

## OCaml Installation

To install OCaml, head over to [OCaml.org](https://ocaml.org/docs/installing-ocaml#ocaml-platform-tools-on-unix) and follow the guide there to install the main tools. It'll be the unix installation instructions, and then scroll down to the platform tools.

After that, you can install project dependencies with:

```opam install . --deps-only --with-test```

And then build the project with:

```dune build```

Install it with:

```dune install```

Which will put it in your $PATH, presuming you setup opam in your ~/.zprofile properly, as in the installation instructions. After that, just run ```vigenere --help``` to see how to use the command! The subcommands also have their own help dialogues, if you add the --help flag to a subcommand.

## Nix Installation

Nix is a declarative, purely functional package manager and build tool that allows you to list in one file a project's dependencies, how it is built, and some other stuff about it. It's even used with NixOS, a Linux distribution, or with tools like nix-darwin to declaratively configure an entire system!

You can install it with:

```curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install```

which will fully configure Nix on your system with all necessary features enabled. This is a handy install script which is at [this github repo](https://github.com/DeterminateSystems/nix-installer), which has some other instructions for updating/uninstalling Nix.

After that, you can build the project with:

```nix build```

If you build with ```nix build```, the result executable will be in ```result/bin/vigenere```, NOT INSTALLED IN YOUR PATH! If you want to install it in your PATH, you can then run ```nix profile install``` in the project directory, which will install the ```vigenere``` command.

or enter into a development shell with:

```nix develop```

If you run ```nix develop```, you can run the same commands as above, minus the dependency initialization, as Nix does that for you - just ```dune build``` and ```dune install```!

Keep in mind, all of these Nix commands will take **a long time** the first time you run them! They are building from source all of the OCaml platform tools, and then building either the project or development environment!
