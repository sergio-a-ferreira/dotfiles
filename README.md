* * *

# dotfiles #

<p align="center">
<img alt="Logo" src="https://github.com/sergio-a-ferreira/dotfiles/blob/main/assets/dotfiles.jpeg" style="width:90%; height:400px;">
</p>

##### shell and applications settings and configuration files. #####

* * *

### Getting Started ###
Manages versioning and deployment of CLI configuration files shared among diferent Unix/Linux CLI environments (bash/ksh based).



For now doesn't manage GUI configurations; files for specific distros/flavours, desktop environments/window managers, terminals and other applications shall have their own project with proper instructions.

To set up follow the instructions below, or simply run the script install.sh in the root directory (see Prerequisites and Installation sections bellow).

> Note: the information below assumes that you cloned the dotfiles project into the home directory; correct the path to the dotfiles directory if needed. If you run install.sh script change the DOTFILES_DIR variable to the pretended path.

- #### profile.config ####

  a shell profile configuration file; with common exports, aliases and functions.

  to enable source from ~/.bashrc or ~/.kshrc; edit the rc file and add the following lines to the end of the file:

  ```
  # source dotfiles/profile.config
  [ -r ~/dotfiles/profile.config ] && . ~/dotfiles/profile.config
  ```

- #### vim.config ####

  vim editor configuration file.

  to enable symlink ${HOME}/.vimrc to the vim.config file:

  ```
  ln -s ~/dotfiles/vim.config ~/.vimrc
  ```

- #### git.config ####

  git configuration file.

  to enable symlink ${HOME}/.gitconfig to the git.config file:

  ```
  ln -s  ~/dotfiles/git.config ~/.gitconfig
  ```

- #### dircolors.config ####

  dircolors configuration file - set the LS_COLORS environment variable.

  the file is loaded in profile.config as a fallback if vivid is not present.

  > to enable manually, source the output of the dircolors command:
  ```
  dircolors ~/dotfiles/dircolors.config > /tmp/lscolors.tmp &&
    . /tmp/lscolors.tmp &&
    rm /tmp/lscolors.tmp
  ```

- #### neofetch.config ####

  neofetch configuration file.

  to enable symlink ${HOME}/.config/neofetch/config.conf to the neofetch.config file:

  ```
  ln -s  ~/dotfiles/neofetch.config ~/.config/neofetch/config.conf

  ```

* * * 

### Prerequisites ###

no prerequisites needed; just the application / software to set.

some aliases in profile.config use substitution tools instead of the default GNU coreutils; e.g.: exa for ls or vivid for dircolors; fallbacks to GNU coreutils are provided.

### Installation ###

clone the git repo:

```
git clone https://github.com/sergio-a-ferreira/dotfiles.git
```

change to the dotfiles directory an run the script install.sh:

```
cd dotfiles
sh ./install.sh
```

### Authors ###

* **Sergio Ferreira** - *Initial work* - [sergio-a-ferreira](https://github.com/sergio-a-ferreira)


### License ####

This project is licensed under the UnLicense - see the [LICENSE](LICENSE) file for details
