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
brew bundle --file=~/dotfiles/Brewfile
```

To generate the Brewfile:

```sh
brew bundle dump --describe --force --file=~/dotfiles/Brewfile
```

#### Fish shell

##### Oh-my-fish

```sh
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

#### Fonts

`FiraCode`, `MapleMono`, `Codicon`
