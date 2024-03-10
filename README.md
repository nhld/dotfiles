### Neovim

![img0.jpg](./img/img1.jpg)

**Requirements:** `brew`, `git`, `neovim`, `luarocks`, `cmake`, `luv`, `stylua`
Fonts used: FiraCode, MapleMono (for italic), Codicon (for icons).

Configs are based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).<br>Check out `.config/nvim/lazy-lock.json` for plugins used.

### Shell

#### - Fish shell:

```
brew install fish
```

- [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish) (alternative [Tide](https://github.com/IlanCosman/tide)): fish framework.

```
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

- [fisher:](https://github.com/jorgebucaran/fisher) fish package manager.

```
brew install fisher
```

- [z:](https://github.com/jethrokuan/z) z for the fish shell directory jumping.

```
fisher install z
```

#### - Shell tools:

Install using `brew`

- [eza:](https://github.com/eza-community/eza) better `ls`.
- [fzf:](https://github.com/junegunn/fzf) fuzzy find files.
- fd, rg.
- lazygit.
