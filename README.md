* * *

# dotfiles #

<p align="center">
<img alt="Logo" src="https://github.com/sergio-a-ferreira/dotfiles/blob/main/assets/banner.jpg" style="width:96%; height:120px;">
</p>

##### shell and applications settings and configuration files. #####

* * *

#### Getting Started ####
General purpose configuration files for bash and ksh shells, and applications like vim, nano, git, dircolors.

Files for specific distros / flavours, desktop environments / window managers, terminals or other apllications shall have their own directory with proper instructions.

To set up follow the instructions below, or simply run the script install.sh in the root directory (see Prerequisites section bellow).


#### profile.config ####

a simple shell profile configuration file; sources the environment from the shaman framework if available.

to enable source from ~/.bashrc and / or ~/.kshrc

edit the pretended shell rc file and add the following lines to the end of the file:

```
# source dotfiles/profile.config
[ -r ~/dotfiles/profile.config ] && . ~/dotfiles/profile.config
```

#### vim.config ####

vim editor configuration file.

to enable symlink ${HOME}/.vimrc to the vim.config file:

```
ln -s ~/dotfiles/vim.config ~/.vimrc
```

#### profile.config ####

git configuration file.

to enable symlink ${HOME}/.gitconfig to the git.config file:

```
ln -s  ~/dotfiles/git.config ~/.gitconfig
```

#### dircolor.config ####

dircolors configuration file - set the LS_COLORS environment variable.

the file is loaded in profile.config if vivid is not present

to enable ls colors link file dir_colors to \~/.dir_colors

> to enable source the output of the dircolors command

```
dircolors ~/dotfiles/dircolors.config > /tmp/lscolors.tmp &&
. /tmp/lscolors.tmp &&
rm /tmp/lscolors.tmp

```

* * * 

#### Prerequisites ####

no prerequisites needed; just the application / software to set.

some aliases use decorate sofware like exa (ls) and vivid (dircolors); fallbacks to GNU Utils tools are provided.

#### Installation ####

clone the git repo:

```
git clone https://github.com/sergio-a-ferreira/dotfiles.git
```

change to the dotfiles directory an run the script install.sh:

```
cd dotfiles
sh ./install.sh
```

