## Install a specific release

```bash
mkdir -p ~/.local
# extract zed to ~/.local/zed.app/
tar -xvf <path/to/download>.tar.gz -C ~/.local
# link the zed binary to ~/.local/bin (or another directory in your $PATH)
ln -sf ~/.local/zed.app/bin/zed ~/.local/bin/zed

# Integration with an XDG-compatible software environment by installing a .desktop file
cp ~/.local/zed.app/share/applications/zed.desktop ~/.local/share/applications/dev.zed.Zed.desktop
sed -i "s|Icon=zed|Icon=$HOME/.local/zed.app/share/icons/hicolor/512x512/apps/zed.png|g" ~/.local/share/applications/dev.zed.Zed.desktop
sed -i "s|Exec=zed|Exec=$HOME/.local/zed.app/libexec/zed-editor|g" ~/.local/share/applications/dev.zed.Zed.desktop
```

## Some keybindings similar to VSCode:

1. Command Palette: `Ctrl + Shift + P`
2. Project Panel: `Ctrl + Shift + E`
3. Open setting: `Ctrl ,`
4. Tasks

## New in Zed

1. Buffer symbol: `Ctrl Shift O`
2. Outline Panel: `Ctrl Shift B`
3. Multi buffer with search: `g /` (Vim mode) > `Ctrl Shift L` to replace all
4. Channels for pair programming
5. Collaboration to share projects with people you trust
6. Switching between multiple tabs: `Ctrl I/O`

## Uninstall

`curl https://zed.dev/install.sh | sh -s uninstall`

Or

```bash
rm -rf $HOME/.local/zed.app
rm -rf $HOME/.local/bin/zed
rm -rf $HOME/.local/share/zed
rm -rf $HOME/.local/share/applications/dev.zed.Zed.desktop

```

