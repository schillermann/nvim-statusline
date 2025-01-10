# Simple Statusline for Neovim

The main goal is to display only the most necessary information, without a lot of color, so that you can concentrate on editing the files.

Statusline for open file
![Statusline File Open](doc/statusline-file-open.png)

Statusline for modified file
![Statusline File Modified](doc/statusline-file-modified.png)

Statusline for read only file
![Statusline File Read Only](doc/statusline-file-readonly.png)

Statusline for help file
![Statusline Help File](doc/statusline-help-file.png)

Statusline for Netrw or NvimTree
![Statusline Netrw](doc/statusline-netrw.png)

## Installation

### [Vim Packages](https://neovim.io/doc/user/repeat.html#packages)

```lua
require('nvim-statusline')
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'schillermann/nvim-statusline'
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'schillermann/nvim-statusline',
}
```

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'schillermann/nvim-statusline',
}
```
