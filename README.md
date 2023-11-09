- [Plugless Editor](#orgaa7a6d9)
- [Depencies](#org1b37b97)
  - [Common](#orgaed88c9)
  - [Vim](#orgfb9c1e9)
- [Installation](#org83d37fb)
- [Vim config](#orga1120cb)



<a id="orgaa7a6d9"></a>

# Plugless Editor

This repository is dedicated to providing lightweight editor configurations that don't rely on plugins. The primary goal is to offer configurations for built-in editors such as Nano, Vim, and Emacs, allowing users to create a functional work environment by simply connecting via SSH or copying files to a remote server. Please keep in mind that these configurations are personal and designed according to my preferences. While they are shared here for the community's benefit, it's advisable to use them with care and consider adapting them to your specific needs.


<a id="org1b37b97"></a>

# Depencies


<a id="orgaed88c9"></a>

## Common

-   bash >= 4.0 The project is not POSIX-complient because it does rely heavely on bashisms.


<a id="orgfb9c1e9"></a>

## Vim

-   vim >= 9.0


<a id="org83d37fb"></a>

# Installation

The whole point is that you don't need to install anything, so just check if you have all depencies and you are good to go. The only thing you need to do is to install clone/download this repo and do some editor specific configuration.


<a id="orga1120cb"></a>

# Vim config

Export an env var with the location of the plugless-editor project location.

```bash

# Add this to your .rc file (ex: ~/.bashrc)
export PLUGLESS_EDITOR_DIR="${HOME}/projects/plugless-editor/"

```

Add this to your ~/.vimrc file

```vimrc

" plugless editor config
let PLUGLESS_EDITOR_DIR = getenv('PLUGLESS_EDITOR_DIR')
if !empty(PLUGLESS_EDITOR_DIR)
    source $PLUGLESS_EDITOR_DIR/vim/vimrc
endif

```