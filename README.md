# AReaL Harness Homebrew tap

Public Homebrew distribution for complete AReaL Harness CLI bundles on macOS arm64 and Linux x86_64.

## Beta

```sh
brew install areal-project/tap/areal-beta
"$(brew --prefix areal-project/tap/areal-beta)/bin/areal" --version
```

The beta formula is keg-only and does not replace a stable `areal` entry. Use the absolute path above or add its `bin` directory to PATH explicitly.

Finish tasks and safely stop AReaL services before upgrading; Homebrew may clean up old kegs:

```sh
brew update
brew upgrade areal-project/tap/areal-beta
brew test areal-project/tap/areal-beta
```

macOS requires executable `/usr/bin/python3` from Xcode Command Line Tools. Linux requires glibc 2.35+ and system `/usr/bin/bwrap` (for Ubuntu: `sudo apt-get install bubblewrap`), plus Homebrew's own supported host environment.

Archives and checksums are published in [AReaL Harness Releases](https://github.com/areal-project/AReaL-Harness/releases). See the [installation and backend handoff guide](https://github.com/areal-project/AReaL-Harness/blob/main/docs/guides/installation.en.md) before changing an existing installation. Back up configuration and history before activating a new Core.

Only the beta formula is currently published in this tap. Stable releases remain available through the standalone installer.
