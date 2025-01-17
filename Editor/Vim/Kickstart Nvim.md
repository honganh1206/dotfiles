---
id: Kickstart Nvim
aliases: []
tags: []
---

# Kickstart Nvim

## Plugins

## Keymaps

### General

- Go back to dashboard from buffer: `<space>a`
- Toggle terminal with `<space>td`
- Find file shortcut: `<space>sf`
- Check files in buffer: `<space>x2`
- Write the current file: `<space>`
- Split windows vertically `Ctrl + v` or horizontally `Ctrl + x`

### Nvim Tree

- Toggle explorer tree: `<space>e`
- Find current file in tree: `<space>n`
- Create new file: Navigate to the folder to create file -> `a` -> Type file
  name
- Delete a file: Navigate to file -> `d`
- Rename a file: Navigate to file -> `e`
- Create a new folder: Type the folder name followed with `/' like `new-folder/`
- Move file to a folder: Select the file -> `x` -> Move to destination folder ->
  `p`

### zk-nvim

Useful keymaps:

- `<leader>zn` - Create new note
- `<leader>zo` - Open notes
- `<leader>zf` - Search notes
- `<leader>zt` - Search selected text
- `<leader>zd` - Create note in current directory
- `<leader>zb` - Show backlinks
- `<leader>zl` - Show links
- `<leader>zp` - Preview note

Standard LSP keymaps:

- `K` - Hover information
- `gd` - Go to definition
- `gr` - Find references
- `<leader>zr` - Rename

### Markdown stuff

Markdown Preview:

- `<leader>mp`: Start markdown preview
- `<leader>ms`: Stop markdown preview
- `<leader>mt`: Toggle markdown preview

Vim-markdown:

- `]]`: Increase header level
- `[[`: Decrease header level
- `]h`: Show table of contents

Glow:

- `<leader>mg`: Preview with Glow

Table Mode:

- `<leader>tm`: Toggle table mode
- `<leader>tr`: Realign table
- `<leader>ts`: Sort table

Bullets and Checkboxes:

- `<leader>x`: Toggle checkbox
- `<leader>bn`: Renumber list

Obsidian:

- `<leader>of`: Follow link
- `<leader>ob`: Show backlinks
- `<leader>on`: Create new note
- `<leader>os`: Search notes
- `<leader>ot`: Show tags
