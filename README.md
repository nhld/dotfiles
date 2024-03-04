### Neovim

![img0.jpg](./img/img1.jpg)
(Shot on [Wezterm](https://github.com/wez/wezterm), FiraMono Nerd Font, [Tokyo Night - Moon](https://github.com/folke/tokyonight.nvim) colorscheme)

**Requirements:** `brew`, `git`, `neovim`, `luajit`, `luarocks`, `cmake`,`luv`, a nerd font (to display some icons).
Most of them can be installed via `brew`.

```
...
brew install luarocks
brew install cmake
luarocks install luv
...
```

Neovim configs are based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) using [lazy.nvim](https://github.com/folke/lazy.nvim) plugins manager.
Check out `.config/nvim/lazy-lock.json` for plugins used.

### Shell

#### - fish shell:

```
brew install fish
```

- [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) (alternative [Tide](https://github.com/IlanCosman/tide)) fish framework.

```
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

- [fisher](https://github.com/jorgebucaran/fisher)fish package manager.

```
brew install fisher
```

- [z](https://github.com/jethrokuan/z)z for the fish shell directory jumping.

```
fisher install z
```

##### Shell tools

Install using `brew`

- [eza](https://github.com/eza-community/eza)better `ls`.
- [fzf](https://github.com/junegunn/fzf)fuzzy find files.
- fd, rg.
