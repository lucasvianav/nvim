# My Neovim (and vscode-neovim) config file
#### Located in: $HOME/.config/nvim
![](https://i.imgur.com/raPX5yF.png)

<br>

# Plugin keybinds:
Every relevant keybind mapped by a plugin.

  1. [Commentary](#commentary)
  2. [Surround](#surround)
  3. [Unimpaired](#unimpaired)
  4. [EasyClip](#easyclip)


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
  * `ss`: **s**et **s**urrounding — inserts a surrounding (2nd argument) to the motion received (1st argument)
    * Originally this keybind is `ys`, but I've remapped it to make it compatible with [EasyClip](#easyclip)
    * e.g.: with the cursor on "Hello", `ssiw]` will `Hello world!` into `[Hello world!]`
  * `sss`: **s**et **s**uper (welp) **s**urrounding — inserts a surrounding (only argument) to the current line (ignoring leading whitespace)

Passing `S` instead of `s` for the above keybinds (`cs`, `ss`, `sSs`, `sSS`) will indent the surrounded text and place it on a line of its own.

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
Instead of installing the plugin, I've copied the source and edited the code to better fit what I wanted, so it's slightly different from tpope's original.

Since all keybinds consist in bracket mappings, it's nice to establish a logic to it. In the a keyboard layout (at least in mine), `[` (the **open**ing bracket) comes above `]` (the **clos**ing bracket) (and slightly to the left), so think of `[` as _up_, _top_, _left_, _start_, _before_, _open_, _on_ and `]` as _down_, _bottom_, _right_, _after_, _close_, _off_. All the command follow that logic.

### Text manipulation
  * `[<Space>`: adds a blank line above
  * `]<Space>`: adds a blank line below
  * `[e` (same as `<M-k>`): moves the curent line (or selection) up
    * In VSCode, the visual mode version is buggy. If you don't hold/mash the buttons, everything should be ok.
  * `]e` (same as `<M-j>`): moves the current line (or selection) down
    * In VSCode, the visual mode version is buggy. If you don't hold/mash the buttons, everything should be ok.
  * `[d`: duplicates the current line (or selection), leaving the cursor (and selection) on the upper duplicate
  * `]d`: duplicates the current line (or selection), leaving the cursor (and selection) on the bottom duplicate
  * `[b`: breaks the current line before the cursor
  * `]d`: breaks the current line after the cursor

### Option toggling
All of the options are changed using `setlocal`, not `set`.
I like these keybinds a lot, unfortunaly I wasn't able to make it work in VSCode, so they work only in terminal Neovim.

The supported options are:
  * `c`: cursorline
  * `u`: cursorcolumn
  * `r`: relativenumber
  * `s`: spell
  * `w`: wrap

You use `[` to activate the option and `]` deactivate it, as well as a leading `o` (stands for **o**ption) before the option letter, so `[oc` activates cursorline, `]oc` deactivates it and so on.

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
