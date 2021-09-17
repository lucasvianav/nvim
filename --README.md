# My Neovim config file

![Simple banner](https://i.imgur.com/raPX5yF.png)

## Description

This is my Neovim config, which currently I use with the Terminal Neovim.

For a while I used it with the [vscode-neovim](https://github.com/asvetliakov/vscode-neovim) extension, but have migrated for TUI and since then haven't updated the VSCode config - maybe some of the plugins that are currently only setted for TUI would be compatible with VSCode, but I haven't tested it. I've removed the VSCode-specific config from the main branch, but you may head to [vscode-compatible](https://github.com/lucasvianav/nvim/tree/vscode-compatible) if you wish.

I'm still a beginner in VIM, so any feedback is welcome :)

In Ubuntu/Debian, clone it to `~/.config/nvim`.

In the `scripts/` there are bash scripts to install and setup everything that's required.

## Summary

 1. [Installation](#installation)
 2. [Settings](#settings)
 3. [Plugin mappings](#plugin-mappings)
 4. [Custom mappings](#custom-mappings)
 5. [Vanilla mappings that I always forget and need to consult](#vanilla)
 6. [Acknowledgements](#acknowledgements)
<!-- 7. [TODO](#todo) -->
<!--  6. [Additional tips/Observations](#additional-tips) -->

## <a id="settings"></a>Settings:

* By default, long lines are displayed as one line (no wrap).
* Tabs are converted to 4 spaces.
* Mouse is enabled.
* Line numbers are relative to the cursorline.
* Files are set to be opened completely folded.
* By default, all `.json` files are interpreted as `.jsonc` (permitting commentaries).
* Whenever you save a file, all trailing whitespaces are deleted.
* A custom motion/text object was defined for **i**ndented blocks: `ai`, `ii`, `aI`, `iI`.
  * See [/kana/vim-textobj-user](https://github.com/kana/vim-textobj-user/wiki)
* I've disabled the arrows keys (in normal, visual and insert modes).

### <a id="sessions"/> Sessions (Terminal Neovim):

I'm using [Startify](https://github.com/mhinz/vim-startify) as a session manager. I've set it to save a Session.vim inside the project root whenever you quit vim and also save sessions for your projects at `//nvim/session/`. When you open a starred project (directory) that contains a Session.vim, that session will be automatically restored and otherwise, you'll be able to select a session to restore (as well as files or directories) on the start screen (screenshot below).

Sessions won't be created on system directories (such as home, Desktop, Documents, etc).

![Start Screen](https://i.imgur.com/GkZNjTH.png)

