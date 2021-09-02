## <a id="custom-mappings"></a>Custom mappings/abbreviations

### Keybinds

* `<C-J>`, `<C-K>`: navigation in lists (like autocompletion) up and down, respectively
* `<M-S-H>`, `<M-S-J>`, `<M-S-K>`, `<M-S-H>`: resizes windows (left, bottom, top, right respectively)
* `jk`, `<C-C>`: substitutes `<Esc>`, which is unmapped
* `<TAB>`, `<S-TAB>`, `<C-TAB>`, `<C-S-TAB>`: navigation between buffers
* `<BS>`: toggle between buffers (last 2 visited)
* `<C-H>`, `<C-J>`, `<C-K>`, `<C-H>`: navigation between windows (left, bottom, top, right respectively)
  * Also works seamlessly with TMUX panes (thanks to [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)).
* `gp`, `gP`: select last pasted text in character (`v`) and linewise (`V`) mode respectively
* `''` and ` `` `: I've inverted them both
  * `''`: takes the cursor position before the latest jump (undoes the jump)
  * ` `` `: takes the cursor to the line where the cursor was before the latest jump

#### <a id="whichkey"></a>WhichKey ([liuchengxu/vim-which-key](https://github.com/liuchengxu/vim-which-key))

The WhichKey menu will be shown if you press `<Leader>` — in this case `<Space>` — in normal mode, so every keybind below is preceded by `<Space>`. Most of the keybindings do not require you to wait for the WhichKey menu to appear.

* `/`: search text (`:Rg`)
* `b`: list open **b**uffers
* `c`: go to **c**har
* `d`: shows all **d**iagnostics (errors, warnings)
* `e`: toggles **e**xplorer
* `f`: serches **f**iles (same as `:FZF`)
* `F`: **f**ormat selected text
* `g`: displays **g**it options
* `h`: splits editor below (**h**orizontally)
* `n`: hides highligts (same as `:noh`)
* `q`: **q**uits buffer (without closing windows)
  * The code was adapted from [this](https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window/44950143#44950143).
* `r`: opens **r**anger
* `rn`: **r**e**n**ame symbol
* `s`: search and replace word under cursor
  * Confirmation will be asked for each substitution.
  * Plugin: <a id="scalpel"/>[wincent/Scalpel](https://github.com/wincent/scalpel)
* `sy`: go to **sy**llab
* `S`: opens **S**tartify (start screen)
* `t`: displays **t**mux options
  * Use of [preservim/vimux](https://github.com/preservim/vimux).
* `v`: splits editor to the right (**v**ertically)
* `w`: go to **w**ord
* `wq`: saves (**w**rites) and **q**uits buffer (without closing windows)
* `<Tab>`: toggle between buffers (last 2 visited)

### Commands

#### Custom

* `:count`: count number of ocurrences of a pattern in the current buffer

#### Abbreviations

* `:Q`: same as `:q`
* `:Q!`: same as `:q!`
* `:q1`: same as `:q!`
* `:man`: same as `:help` (welp...)
* `:wq`: remapped to `:x`
  * I prefer the `x` command's functionality, but prefer to type `:wq`
  * If you're wondering what the differences are and why I prefer `:x`, read [this comment](https://www.quora.com/Why-do-some-people-close-Vim-with-wq-instead-of-x/answer/Ye-Caiting) by [Ye Caiting](https://www.quora.com/profile/Ye-Caiting).

* `:r`, `:Rvimrc`: **r**eloads the init.vim (same as `:source $MYVIMRC`)
* `:wrv`: saves the file (**w**rite) and **r**eloads **V**IMRC
* `:settings`: opens init.vim (same as `:e $MYVIMRC`)
* `:keybindings`: opens the main keybindings file
* `:bufo`, `BufOnly`: same as `:tabo` but for buffers
  * Plugin: <a id="bufonly"/>[BufOnly](https://www.vim.org/scripts/script.php?script_id=1071).
* `:qb`, `BufClose`: **q**uits **b**uffer (without closing windows)
* `:wqb`, `BqWrite`: saves (**w**rites) and **q**uits **b**uffer (without closing windows)
* `:ToggleTermBottom`: open terminal in the bottom
  * You can exit terminal mode with `jk` and `<C-\><C-N>`.
* `:ToggleTermRight`: open terminal in the right
  * You can exit terminal mode with `jk` and `<C-\><C-N>`.
* `:DelSessions`: deletes current session
  * This'll delete both the Session.vim in the current working directory, as well as this session's Startify entry at ~/.config/nvim/session.
  * For more info about sessions, read [this](#sessions).
* `:Format`: format current buffer

