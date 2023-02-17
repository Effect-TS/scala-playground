# Effect Scala Playground

## Getting Started

To get started, you'll need to have `direnv` on your system. You can install it with `nix` via `nix profile install direnv`.

Once you have `direnv` installed, you can run `direnv allow` in the root of this repository. This will setup the required environment and should launch a `nix` shell with the required dependencies.

You may need to close VSCode and reopen it for the effects of `direnv allow` to take effect.

Once the project is open again, install the [recommended extensions](./.vscode/extensions.json).

One of the extensions we install is the Nix Environment Selector, which allows the development shell and all its packages to integrate with VSCode. You may need to select the environment in the bottom left of VSCode.

You may need to close and reopen VSCode one last time.