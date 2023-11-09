- [Plugless Editor](#org780690e)
- [Dependencies](#org57f216f)
  - [Common](#org2f27ec0)
  - [Vim](#orgfb3f783)
- [Installation](#orgabb8e75)
- [Vim config](#orgdbb129b)



<a id="org780690e"></a>

# Plugless Editor

This repository is dedicated to providing lightweight editor configurations that don't rely on plugins. The primary goal is to offer configurations for built-in editors such as Nano, Vim, and Emacs, allowing users to create a functional work environment by simply connecting via SSH or copying files to a remote server. Please keep in mind that these configurations are personal and designed according to my preferences. While they are shared here for the community's benefit, it's advisable to use them with care and consider adapting them to your specific needs.


<a id="org57f216f"></a>

# Dependencies


<a id="org2f27ec0"></a>

## Common

-   bash >= 4.0 The project is not POSIX-compliant because it does rely heavily on bashisms.


<a id="orgfb3f783"></a>

## Vim

-   vim >= 9.0


<a id="orgabb8e75"></a>

# Installation

The whole point is that you don't need to install anything, so just check if you have all dependencies and you are good to go. The only thing you need to do is to install or clone/download this repo and do some editor-specific configuration.


<a id="orgdbb129b"></a>

# Vim config

Export an env var with the location of the plugless-editor project location.

```bash

# Add this to your .rc file (e.g., ~/.bashrc)
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