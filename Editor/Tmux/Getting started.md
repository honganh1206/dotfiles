Tags: #consume #shell

## Components

Session - Windows - Panes

A session can have multiple windows

We can have multiple sessions, but we can only attach to one

Each session can only have 1 active window

Windows are like tabs and shown at the bottom of the screen

Panes are split in a window, and only 1 pane is active

## Movements

Default prefix key: `Ctrl + space`

### Sessions

Create a new session with a name: `tmux new -s my-session`

List all sessions: `tmux ls`

Preview [w]indows for each session: `prefix + w`

Attach to a session: `tmux attach -s my-session`

### Windows

[C]reate new window: `prefix + c`

Switching between windows: `prefix + window-num` 

Move to [p]revious window: `prefix + p`

Move to [n]ext window: `prefix + n`

### Panes

Split to panes: `prefix` + `%` (vertically) / `"` (horizontally)

Move between panes: `prefix + <arrow-keys>`

Turn pane to window `prefix + !`

Kill a pane: `prefix + x`

## Search

`fzf` integration: `Ctrl + s` 