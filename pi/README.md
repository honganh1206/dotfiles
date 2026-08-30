# Pi configuration

This directory stores the Pi configuration source for this dotfiles repository.
Pi does not load `pi/settings.json` directly.

## Windows installation

1. Install Node.js 22 or later, Git, and Pi.
2. Clone this repository with its submodules.
3. Run the bootstrap script from PowerShell.

```powershell
git clone --recurse-submodules <repository-url> "$HOME\src\dotfiles"
& "$HOME\src\dotfiles\pi\bootstrap-windows.ps1"
```

If the repository already exists, update its submodules first.

```powershell
git -C "$HOME\src\dotfiles" submodule update --init --recursive
& "$HOME\src\dotfiles\pi\bootstrap-windows.ps1"
```

The script creates these global Pi paths:

- `%USERPROFILE%\.pi\agent\settings.json`
- `%USERPROFILE%\.pi\agent\extensions`
- `%USERPROFILE%\.agents\skills`

It writes absolute paths for the local Pi packages.
It creates junctions for extensions and skills.
It installs package dependencies unless you specify `-SkipDependencies`.

Use `-SkipDependencies` only when the package dependencies already exist.

```powershell
& "$HOME\src\dotfiles\pi\bootstrap-windows.ps1" -SkipDependencies
```

The script will not replace a normal directory or file with a junction.
Remove or move that path before you run the script again.

Restart Pi after the script completes.
Then use `/login` or `/settings` to configure your provider.
