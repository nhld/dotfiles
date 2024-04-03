##### Install command line tools

```sh
xcode-select --install
```

##### Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

##### Install Homebrew Bundle from Brewfile

```sh
brew bundle --file ~/.config/Brewfile
```

To generate the Brewfile:

```sh
brew bundle dump --describe
```

#### Fish shell

##### Oh-my-fish

```sh
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

##### Fisher

```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

```sh
fisher install jethrokuan/z
```

#### Neovim

Install `rust` and `cargo`

```sh
curl https://sh.rustup.rs -sSf | sh

```

```sh
luarocks install luv
```

```sh
cargo install stylua
```

#### Fonts

`FiraCode`, `MapleMono`, `Codicon`
