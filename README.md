# Spacer!

Vim plugin to add separators and titles into your code.

# Install

## Using Plug plugin manager

- Plugin manager: [Plug](https://github.com/junegunn/vim-plug)

To add this pluggin add this line to your `.vimrc`:

```vim
    Plug  'git@gitlab.com:impresionista/vim-spacer.git'
```

# Documentation

Default keybindings for this plugin.
These are the parameters used by default if can't be readed by the pluggin:

```vim
" Default line length
linelenght=80

" Character used for commentary
comm_char='# '

" Character used for separators
sep_char='-'
```

## In visual mode

**Spacers:**
- `<LEADER>iS` adds a spacer as long as your default line length.
- `<LEADER>is` adds a spacer as long as 3/4 of your default line length.

**Titles:**
- `<LEADER>iT` adds a spacer with title as long as your default line length.
- `<LEADER>it` adds a spacer with title as long as 3/4 of your default line length.


## In insert mode

**Spacers:**
- `<CTL>s` adds a spacer as long as your default line length.
- `<ALT>s` adds a spacer as long as 3/4 of your default line length.

**Titles:**
- `<CTL>t` adds a spacer with title as long as your default line length.
- `<ALT>t` adds a spacer with title as long as 3/4 of your default line length.


## Example

```bash
TITLES:

# This is a long title --------------------------------------------------------

# This is a short title -----------------------------------


SPACERS:

This is a long spacer:
# -----------------------------------------------------------------------------

This is a short spacer:
# ---------------------------------------------------------

```


# TO-DO

- [  ] Add Visual mode to use selected text as title.
- [  ] Add a "Big Title"
- [  ] Add a "Big Spacer"
- [  ] Add config parameters to define outside plugin file.
