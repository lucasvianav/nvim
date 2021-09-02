# Plugins

1. [Commentary](#commentary)
2. [CapsLock](#capslock)
3. [Surround](#surround)
4. [Unimpaired](#unimpaired)
5. [EasyClip](#easyclip)
6. [Abolish](#abolish)
7. [Eregex](#eregex)
8. [Speed-Dating](#speeddating)
9. [Radical](#radical)
10. [Visual Increment](#visual-increment)
11. [Fugitive](#fugitive)
12. [SplitJoin](#splitjoin)
13. [Easy Align](#easyalign)
14. [Vim Visual Multi](#visualmulti)

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

## <a id="capslock"></a>CapsLock ([tpope/vim-capslock](https://github.com/tpope/vim-capslock))

This plugin adds a virtual caps lock that won't mess normal mode up.

* `gC`: normal mode - toggle permanent caps-lock
* `<C-g>c`: inser mode - toggle temporary caps-lock
  * Is decativated once you leave insert mode.

      I liked [suxpert/vimcaps](https://github.com/suxpert/vimcaps) better - it deactivates normal caps-lock once you exit insert mode and also works in VSCode -, but I don't remember how to make it work.

## <a id="surround"></a>Surround ([tpope/vim-surround](https://github.com/tpope/vim-surround))

### Normal mode

* `cs`: **c**hange **s**urrounding — substitutes one (1st arg.) surrounding for the other (2nd arg.)
  * e.g.: `cs"'` will turn `"Hello world!"` into `'Hello world!'`
  * e.g.: `cs'<q>` will turn `'Hello world!` into `<q>Hello world!</q>`
  * When substituting a tag for another surrounding, the tag is represented by `t`
        * e.g.: `cst"` will turn `<q>Hello world!</q>` into `"Hello world!"`
* `ds`: **d**elete **s**urrounding — analogue to `cs`
* `xs`: e**x**ecute (set) **s**urrounding — inserts a surrounding (2nd argument) to the motion received (1st argument)
  * Originally this keybind is `ys`, but I remapped it to make it compatible with [EasyClip](#easyclip)
  * e.g.: with the cursor on "Hello", `xsiw]` will `Hello world!` into `[Hello world!]`
* `pss`: e**x**ecute **s**uper (welp) **s**urrounding — inserts a surrounding (only argument) to the current line (ignoring leading whitespace)

    Passing `S` instead of `s` for the above keybinds (`cs`, `ss`, `xSs`, `xSS`) will indent the surrounded text and place it on a line of its own.

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
* `[a` (same as `<M-k>`): moves the curent line (or selection) up
* `]a` (same as `<M-j>`): moves the current line (or selection) down
* `[d`: duplicates the current line (or selection), leaving the cursor (and selection) on the upper duplicate
* `]d`: duplicates the current line (or selection), leaving the cursor (and selection) on the lower duplicate
  * It glitches the first time you use it in visual mode :c
* `[b`: breaks the current line before the cursor
* `]d`: breaks the current line after the cursor

## Moving around

Not really from unimpaired, but from [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim).

* `[g, ]g`: goes to next/previous dia**g**nostic (error, warning)
* `[e, ]e`: goes to next/previous **e**rror

### Option toggling

All of the options are changed using `setlocal`, not `set`.

* `c`: cursorline
* `u`: cursorcolumn
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
* `:IPaste`: allows you to choose a yank from the list to paste (**I**nterative Paste)
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

## <a id="splitjoin"></a>SplitJoin ([AndrewRadev/splitjoin.vim](https://github.com/AndrewRadev/splitjoin.vim))

Makes it possible to convert single-line statements into multiline statements and the other way around.

* `gS`: **s**plit into multiline statement
* `gJ`: **j**oin into single-line statement

## <a id="easyalign"></a>EasyAlign ([junegunn/vim-easy-align](https://github.com/junegunn/vim-easy-align))

Makes it easy to align blocks of code. This is kinda complex so I recommend reading the plugin's own README.

* `<Leader>a`: **a**lign
  * Works both in visual and normal mode (needs a motion).
  * Accepts any arguments to describe what it should align around.
* `:EasyAlign`
  * Takes a range.

      Accepted characters do align around: `=`, `<Space>`, `,`, `:`, `.`, `|`, `&` and `#`.
      There are also the following modifiers that should be added before the target-character:

* `2`, `3`, ..., `n`: align around the `nth` occurence of the provided character.
* `-1`, `-2`, ..., `-n`: around align the `nth` to last occurrence.
  * `-` and `-1` both refer to the last occurrence.
* `*`: align arround all occurrences.
* `**`: alternate alignment (left/right) around all occurrences.
* `<Enter>`: switch between left/right/center alignment modes.
* `<Right>`: change alignment behavior for characters like `,` and `:`.
  * By default those characters are placed next to the preceding token without margin.

      It's also possible to align around a regex:

* On interactive mode (normal/visual), prets <C-X> to trigger the regex prompt.
* On command mode: `:EasyAlign /REGEX/`.

## <a id="visualmulti"></a>Vim Visual Multi ([mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi))

Adds support to multiple cursors (similar to VSCode's). I've disabled all the
default mappings but the ones below to prevent me from abusing this plugin.

* `<C-n>`: finds **n**ext word.
* `gl`: finds al**l** words.
  * I know, this is not a good mnemonic.
* `<C-c>`: exits Visual Multi.

