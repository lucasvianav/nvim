# My Neovim (and vscode-neovim) config file
![Simple banner](https://i.imgur.com/raPX5yF.png)

## Description
This is simply my Neovim config, which I use mainly with the [vscode-neovim](https://github.com/asvetliakov/vscode-neovim) extension. I'm still a beginner in VIM, so any feedback is welcome :)

In Ubuntu, clone it to: ~/.config/nvim

## Summary

  1.  [Installation](#installation)
  2.  [Plugin mappings](#plugin-mappings)
  3.  [Custom mappings](#custom-mappings)
  4.  [Vanilla mappings that I always forget and need to consult](#vanilla)
  5.  [Additional tips/Observations](#additional-tip)
  6.  [Acknowledgements](#acknowledgements)
  7.  [TODO](#todo)

# <a id="plugin-mappings"></a>Plugin mappings:
Every relevant keybind/command mapped by a plugin.

  1.  [Commentary](#commentary)
  2.  [Surround](#surround)
  3.  [Unimpaired](#unimpaired)
  4.  [EasyClip](#easyclip)
  5.  [Abolish](#abolish)
  6.  [Eregex](#eregex)
  7.  [Speed-Dating](#speeddating)
  8.  [Radical](#radical)
  9.  [Visual Increment](#visual-increment)
  10. [Fugitive](#fugitive)

Plugins in other sections:
  1. [WhichKey](#whichkey)
  2. [CapsLock](#capslock)


## <a id="commentary"></a>Commentary ([tpope/vim-commentary](https://github.com/tpope/vim-commentary))
### Keybinds
  * `gcc`: toggles comment of a line (takes a count)
  * `gc`: toggles comment of a motion or selection
    * e.g.: `gcap` will toggle comment of a paragraph
  * `<C-/>`: toggles comment of a line (takes a count) or selection
    * Does not support motion.

### Commands
  * `:Commentary`: can be used with a range or as part of a `:global` invocation
    * e.g.: `:7,17Commentary` will toggle comment for lines 7 through 17
    * e.g.: `g/TODO/Commentary` witll toggle comment for all lines contaning the word "TODO"

To add support to a filetype, you have yo adjust `commentstring`. For example, the command below will set the `commentstring` for `.apache` files to `#`.
```
autocmd FileType apache setlocal commentstring=#\ %s
```

## <a id="surround"></a>Surround ([tpope/vim-surround](https://github.com/tpope/vim-surround))
### Normal mode
  * `cs`: **c**hange **s**urrounding — substitutes one (1st arg.) surrounding for the other (2nd arg.)
    * e.g.: `cs"'` will turn `"Hello world!"` into `'Hello world!'`
    * e.g.: `cs'<q>` will turn `'Hello world!` into `<q>Hello world!</q>`
    * When substituting a tag for another surrounding, the tag is represented by `t`
        * e.g.: `cst"` will turn `<q>Hello world!</q>` into `"Hello world!"`
  * `ds`: **d**elete **s**urrounding — analogue to `cs`
  * `çs`: **ç**et (set) **s**urrounding — inserts a surrounding (2nd argument) to the motion received (1st argument)
    * Originally this keybind is `ys`, but I remapped it to make it compatible with [EasyClip](#easyclip)
    * e.g.: with the cursor on "Hello", `çsiw]` will `Hello world!` into `[Hello world!]`
  * `pss`: **ç**et **s**uper (welp) **s**urrounding — inserts a surrounding (only argument) to the current line (ignoring leading whitespace)

Passing `S` instead of `s` for the above keybinds (`cs`, `ss`, `çSs`, `çSS`) will indent the surrounded text and place it on a line of its own.

### Visual mode
  * `vS`: set **S**urrounding — inserts a surrounding to the selection
  * `^vS`: set **S**urrounding — inserts a surrounding to each selection on the block
  * `VS`: set **S**urrounding — indents the line and places it on a line of its own

### Observations
  * When adding a tag, you can include it's attributes.
  * With parenthesis, curly braces or brackets, if you use the opening one it'll add extra spaces and if you use the closing one it won't.
    * e.g.: with the cursor on "Hello", `ssiw]` will `Hello world!` into `[Hello world!]`
    * e.g.: with the cursor on "Hello", `ssiw[` will `Hello world!` into `[ Hello world! ]`
  * If `f` is used leading the new surrounding expression, Vim prompts for a function name to insert. The surrounded text will be wrapped in a functino call.
    * e.g.: `ssiwfprint<CR>` will turn `"hello"` into `print("hello")`
    * e.g.: `c"fprint<CR>` will turn `"hello"` into `print(hello)`
    * The delete operation is not supported.
    * If you use `F` instead of `f`, extra spaces will be added between the fuction parenthesis and the surrounded text.
        * e.g.: `ssiwFprint<CR>` will turn `"hello"` into `print( "hello" )`

<br>

## <a id="unimpaired"></a>Unimpaired ([tpope/vim-unimpaired](https://github.com/tpope/vim-unimpaired))
Instead of installing the plugin, I copied and edited the source the code to better fit what I wanted, so it's slightly different from tpope's original.

Since all keybinds consist in bracket mappings, it's nice to establish a logic to it. In the a keyboard layout (at least in mine), `[` (the **open**ing bracket) comes above `]` (the **clos**ing bracket) (and slightly to the left), so think of `[` as _up_, _top_, _left_, _start_, _before_, _open_, _on_ and `]` as _down_, _bottom_, _right_, _after_, _close_, _off_. All the command follow that logic.

### Text manipulation
  * `[<Space>`: adds a blank line above
  * `]<Space>`: adds a blank line below
  * `[e` (same as `<M-k>`): moves the curent line (or selection) up
    * In VSCode, the visual mode version is buggy. If you don't hold/mash the buttons, everything should be ok.
  * `]e` (same as `<M-j>`): moves the current line (or selection) down
    * In VSCode, the visual mode version is buggy. If you don't hold/mash the buttons, everything should be ok.
  * `[d`: duplicates the current line (or selection), leaving the cursor (and selection) on the upper duplicate
  * `]d`: duplicates the current line (or selection), leaving the cursor (and selection) on the lower duplicate
    * It glitches the first time you use it in visual mode :c
  * `[b`: breaks the current line before the cursor
  * `]d`: breaks the current line after the cursor

### Option toggling
In terminal Neovim, all of the options are changed using `setlocal`, not `set`.
I was able to make it work in VSCode (using JavaScript to update the settings.json file), but couldn't supress the Output panel.

The supported options are:
  * `c`: cursorline
    * Does not exist in VSCode.
  * `u`: cursorcolumn
    * Does not exist in VSCode.
  * `r`: relativenumber
  * `s`: spell
  * `w`: wrap

You use `[` to activate the option, `]` deactivate it and `y` to toggle it, as well as a leading `o` (stands for **o**ption) before the option letter, so `[oc` activates cursorline, `]oc` deactivates it, `yoc` toggles it and so on.

### Encoding/Decoding
`[` is used to encode and `]` is used to decode. As tpope's states in the plugin's documentation, think encoding comes before decoding.

The supported encodings are:
  * `s`: C-style **s**trings
  * `u`: **U**RL
  * `x`: **X**ML

## <a id="easyclip"></a>EasyClip ([svermeulen/vim-easyclip](https://github.com/svermeulen/vim-easyclip))

### Main keybinds
  * `y`, `Y`: same as you'd expect from vanilla, but keeps a yank history (each yank is stored in a register)
  * `d`, `D`, `c`, `C`: same as you'd expect from vanilla, but the deleted/changed text is not yanked, but completely erased/lost (black hole)
    * `dD`: makes the current line blank
  * `p`, `P`: same as you'd expect from vanilla, but auto-formats the pasted text
  * `\p`, `\P`: same as above, but does not auto-format text
  * `\cf`: in theory, this would toggle the auto-format if used immediately after pasting, but I can't get it to work
  * `s`, `S`: substitutes the passed motion by the current yank, similar to visually selecting it and pasting (the substituted text is also not yanked)
  * `x`, `X`: cuts — yanks and deletes — the passed motion (vanilla `d`)
  * `m`: deletes the character under the cursor (vanilla `x`)

### Yank history navigation
  * `[p`: navigates the yank history forwards permanently
  * `]p`: navigates the yank history backwards permanently
  * `<C-N>`: navigates the yank history forwards temporarily immediately after a paste
  * `<C-P>`: navigates the yank history backwards temporarily immediately after a paste

The plugin documentation references the opposite direction reference for the command — `]p` and `<C-P>` being forwards, as well as `[p` and `<C-N>` being backwards —, but the way I described above makes more sense to me.

### Commands
  * `:Yanks`: displays the full list of yanks
    * Displaying the yank list doesn't quite work in VSCode
  * `:IPaste`: allows you to choose a yank from the list to paste (**I**nterative Paste)
    * Displaying the yank list doesn't quite work in VSCode
  * `:Paste`: same as above but does not display yank list

If the commands above described doesn't make a lot os sense to you, I highly recommend you read the plugin's documentation/README.md, it'll certainly help you better understand the plugin's funcionality.

## <a id="abolish"></a>Abolish ([tpope/vim-abolish](https://github.com/tpope/vim-abolish))
As tpope himself stated, this plugin e kinda hard to explain, so I won't even try. I recommend you read the plugins documentation/README.md for a better explanation and examples.

### Commands
  * `:Abolish`: sets **ab**breviations for the many defined variations of a word to the many variations of another
    * It's better used in a script.
    * Saves you the effort of having to write many lines of `:iabbrev`
    * e.g.: `:Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}`
  * `:Subvert`: **sub**stitutes the many defined variations of a word by the many variations of another
    * Saves you the effort of having to execute many `:%s`
    * e.g.: `:%Subvert/facilit{y,ies}/building{,s}/g`
    * e.g.: `:Subvert/address{,es}/reference{,s}/g`
    * e.g.: `:Subvert/child{,ren}/adult{,s}/g`

Note: some examples of variations of a word are lowercase/uppercase, masc/fem, singular/plural, etc.

### <a id="coercion"></a>Keybinds — Coercion
For me, it's better to remember it as **Conversion**, as it'll _convert_ the word under the cursor to another "case-format".
The command is `cr` and it takes an argument to represent the new "case-format".

The supported "case-formats" are:
  * `s`: snake_case
  * `m`: MiexdCase
  * `c`: camelCase
  * `u`: UPPER_CASE
  * `-`: dash-case
  * `.`: dot-case
  * `<space>`: space case
  * `t`: Title Case

e.g.: `crs` will turn `fooBar` into `foo_bar` and so on.

## <a id="eregex"></a>Eregex ([othree/eregex.vim](https://github.com/othree/eregex.vim))
I hate VIM regex, so this enables me to use Perl regex, with which I'm more familiar.

### Commands
  * `:M/`: search with Perl regex
  * `:S`, `:%S`: search-replace with Perl regex
    * `:s`, `%s` stays the same as vanilla

### Keybinds
  * `/`: same as vanilla, but with Perl regex
  * `?`: same as vanilla, but with Perl regex

## <a id="speeddating"></a>Speed-Dating ([tpope/vim-speeddating](https://github.com/tpope/vim-speeddating))
Situationally useful. Don't really use it much, but I like the concept of having it.

  * `<C-X>`, `<C-A>`: same as vanilla, but also work on dates, roman numerals and ordinals (1st, 2nd, 3rd, ...)
    * In visual mode, supports letters of the alphabet.
  * `d<C-X>`, `d<C-A>`: sets the timestamp under the cursor to the current time and current UTC time respectively (does not create a timestamp)

## Radical ([glts/vim-radical](https://github.com/glts/vim-radical))
Situationally useful. Don't really use it much, but I like the concept of having it.

The command for **c**onve**r**ting a number to another representation is `cr` (the same as [Coercion](#coercion), but doesn't conflict). It takes the representation's initial as argument.

  * `gA`: shows the four representations of the number under the cursor (or selected in Visual Mode)
  * `crd`: converts the number to decimal
  * `crx`: converts the number to hex
  * `cro`: converts the number to octal
  * `crb`: coverts the number to binary

## <a id="visual-increment"></a>Visual-Increment ([triglav/vim-visual-increment](https://github.com/triglav/vim-visual-increment))
Makes `<C-A>` and `<C-X>` work in blockwise visual mode (`^V`) to create sequences of numbers (decimal, hex, octal) and letters. For examples, read the plugin's README.

## <a id="fugitive"></a>Fugitive ([tpope/vim-fugitive](https://github.com/tpope/vim-fugitive))
Makes possible to use `:Git` (that I abbreviated to `:git`) as you would in the command line.c

# <a id="custom-mappings"></a>Custom mappings/abbreviations
## Keybinds
  * `<C-J>`, `<C-K>`: navigation in lists (like autocompletion) up and down, respectively
  * `<M-S-H>`, `<M-S-J>`, `<M-S-K>`, `<M-S-H>`: resizes windows (left, bottom, top, right respectively)
  * `jk`, `<C-C>`: substitutes `<Esc>`, which is unmapped
  * `<TAB>`, `<S-TAB>`, `<C-TAB>`, `<C-S-TAB>`: navigation between buffers
  * `<C-H>`, `<C-J>`, `<C-K>`, `<C-H>`: navigation between windows (left, bottom, top, right respectively)
  * `gp`, `gP`: select last pasted text in character (`v`) and linewise (`V`) mode respectively
  * `''` and ` `` `: I've inverted them both
    * `''`: takes the cursor position before the latest jump (undoes the jump)
    * ` `` `: takes the cursor to the line where the cursor was before the latest jump

### <a id="whichkey"></a>WhichKey ([liuchengxu/vim-which-key](https://github.com/liuchengxu/vim-which-key))
The WhichKey menu will be shown if you press `<Leader>` — in this case `<Space>` — in normal mode, so every keybind below is preceded by `<Space>`.

#### Terminal Neovim
I need to organize it.

#### VSCode ([VSpaceCode/vscode-which-key](https://github.com/VSpaceCode/vscode-which-key))
Most of the keybindings do not require you to wait for the WhichKey menu to appear.

  * `<Space>`: opens VSCode Command Palette
  * `/`: searches in the whole project (workspace?)
  * `s`: "find & replace" in project
  * `d`: goes to definition
  * `D`: goes to declaration
  * `e`: toggles explorer visibility
    * If you press `<Space>e` without waiting for the WhichKey menu to appear, it'll toggle sidebar visibility
    * If you press `<Space>`, wait for the WhichKey menu to appear and then press `e`, you'll open the explorer
    * `<C-S-\>` and `<C-M-E>` are alternatives (not part of WhichKey), they'll always toggle explorer.
  * `E`: displays errors
  * `g`: displays git options
  * `v`: splits editor to the right
  * `h`: splits editor below
  * `i`: organizes imports (Python-only?)
  * `m`: displays merge conflict options
  * `n`: hides highligts (same as `:noh`)
  * `o`, `O`: same as vanilla `o`and `O`, but the new line will be blank
  * `t`: toggles integrated terminal
    * `<C-S-t>` is an alternative (not part of WhichKey), it'll always toggle the terminal.

### Folding
These keybindings are better detailed [here](#folding).

#### Terminal Neovim
  * `´`, `<F9>`: toggles the topmost level of folding under the cursor
  * `<S-´>`, `<F10>`: toggles all levels of folding under the cursor

#### VSCode
  * `´`, `<F9>`, `<F10>`: toggles the topmost level of folding under the cursor
  * `zA`: folds recursively under the cursor
  * `zAA`, `zAa`: unfolds recursively under the cursor
  * `zR`: opens all folds (mnemonic is **R**educe)
  * `zm`: takes a count and folds the level passed (**m** folding)

## Commands
### Custom
  * `:count`: count number of ocurrences of a pattern in the current buffer
  * `:uq`: **u**ndoes last **q**uit - reopens last closed tag
    * In Terminal Neovim, is the same as `:e #`;
    * In VSCode, calls VSCode's "reopen closed editor" action.

### Abbreviations
  * `:Q`: same as `:q`
  * `:Q!`: same as `:q!`
  * `:q1`: same as `:q!`
  * `:wq`: remapped to `:x`
    * I prefer the `x` command's functionality, but prefer to type `:wq`
    * If you're wondering what the differences are and why I prefer `:x`, read [this comment](https://www.quora.com/Why-do-some-people-close-Vim-with-wq-instead-of-x/answer/Ye-Caiting) by [Ye Caiting](https://www.quora.com/profile/Ye-Caiting).

### Interacting with Terminal Neovim
  * `:r`, `:Rvimrc`: **r**eloads the init.vim (same as `:source $MYVIMRC`)
  * `:wrv`: saves the file (**w**rite) and **r**eloads **V**IMRC
  * `:settings`: opens init.vim (same as `:e $MYVIMRC`)
  * `:keybindings`: opens the main keybindings file

### Interacting with VSCode
  * `:qv[scode]`: **q**uit **vs**code (closes VSCode window)
  * `:r[vscode]`, `:R[vscode]`: **r**eloads **VS**Code window
  * `:wrv[scode]`: saves the file (**w**rite) and **r**eloads **VS**Code window
  * `:settings`: opens VSCode's settings.json
  * `:keybindings`, `:keybinds`, `:keyboard`: opens VSCode's keybindings.json

# <a id="vanilla"></a>Vanilla mappings that I always forget and need to consult
  * `:e!:`: Discard/revert unsaved changes
    * Remapped in VSCode so it does the same as vanilla.

## Movement keybinds
### Vertical
  * `^E`: scrolls down
  * `^Y`: scrolls up
  * `M`: jumps to the middle of the screen
  * `H`: jumps to the top of the screen
  * `L`: jumps to the bottom of the screen
  * `G`: obviously jumps to the end of file, but if given a count jumps to that line
    * e.g.: `50G` jumps to the 50th line
  * `'.`, `g;`: jumpts to last edit
  * `''` and ` `` `: I've inverted them both
    * `''`: takes the cursor position before the latest jump (undoes the jump)
    * ` `` `: takes the cursor to the line where the cursor was before the latest jump

### Horizontal
  * `|`: jumps to the 1st column of current line
    * If given a count, jumsp to that column
    * e.g.: `17|` jumps to the 17th column of current line

## <a id="folding"></a>Folding keybinds
I've also left some custom keybinds in here so all the folding keybinds stay together.

### Terminal Neovim
  * `za`, `<F9>`: toggles the topmost level of folding under the cursor
    * `<F9>` works in insert mode
  * `zA`, `<F10>`: toggles all levels of folding under the cursor
    * `<F10>` works in insert mode
  * `zr`: **r**educes folding in the whole buffer
  * `zR`: opens all folds
  * `zm`: increses folding in the whole buffer (**m** folding)
  * `zM`: closes all folds

### VSCode
  * `za`, `<F9>`, `<F10>`: toggles the topmost level of folding under the cursor
    * `<F9>`, `<F10>` works in insert mode
  * `zA`: folds recursively under the cursor
  * `zAA`, `zAa`: unfolds recursively under the cursor
  * `zR`: opens all folds (mnemonic is **R**educe)
  * `zm`: takes a count and folds the level passed (**m** folding)
    * If no count is given, folds level 1 by default
    * There's also `zm1`, `zm2`, ..., `zm7`
    * e.g.: `zm`, `1zm`, `zm1` will fold level 1
    * e.g.: `2zm`, `zm2` will fold level 2
  * `zM`: closes all folds

# <a id="additional-tips"></a>Additional tips/Observations
I'm putting this here because I haven't memorized it yet and neet to consult it. In bash, you can use `Ctrl+Z` to suspend Neovim (or any app I guess) and then `fg` to go back to it (put it in the **f**ore**g**round). You can also use bg to leave it running in the **b**ack**g**round.

## <a id="capslock"></a>CapsLock ([suxpert/vimcaps](https://github.com/suxpert/vimcaps))
This plugin is pretty simples and I like it a lot: it basically deactivates CapsLock once you exit insert mode. 
An alternative would be [tpope's vim-capslock](https://github.com/tpope/vim-capslock), but I couldn't make it work on VSCode (vimcaps does).

# <a id="acknowledgements"></a>Acknowledgements
Just wanna thank:
  * [Christian Chiarulli](https://github.com/ChristianChiarulli), for making an excelent Neovim-introduction [video series](https://www.youtube.com/playlist?list=PLhoH5vyxr6QqPtKMp03pcJd_Vg8FZ0rtg) and [blog posts](https://www.chrisatmachine.com/neovim). When I started using/learning about VIM, I really just copying his config.
  * [Greg Hurrell](https://github.com/wincent), for the great [screencasts and stream](https://www.youtube.com/channel/UCXPHFM88IlFn68OmLwtPmZA).
  * [Alexey Svetliakov](https://github.com/asvetliakov/), for making and maintaining the absolutely unbeliavable [vscode-neovim](https://github.com/asvetliakov/vscode-neovim) extension.
  * All of the awesome people who made the plugins I listed/installed.

# <a id="todo"></a>TODO
  * Update README.md
    * Write installation guide
    * Write about other plugins/features
  * Test [wincent/scalpel](https://github.com/wincent/scalpel)
  * Test [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi)
  * Learn more about VSCode's output tab
    * Is it possible to use it for commands like :Yanks and :IPaste?
    * Is it possible to supress it when running terminal commands (e.g.: `:! ls`)?
  * Figure out why isn't EasyClip's toggle format (<Leader>cf?) working
