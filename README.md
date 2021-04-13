# My Neovim (and vscode-neovim) config file
#### Located in: $HOME/.config/nvim
![](https://i.imgur.com/raPX5yF.png)

<br>

# Plugin keybinds:
Every relevant keybing mapped by a plugin.


## <a id="surround"></a>Surround ([tpope/vim-surround](https://github.com/tpope/vim-surround))
### Normal mode
  * `cs`: **c**hange **s**urrounding — substitutes one (1st arg.) surrounding for the other (2nd arg.)
    * e.g.: `cs"'` will turn `"Hello world!"` into `'Hello world!'`
    * e.g.: `cs'<q>` will turn `'Hello world!` into `<q>Hello world!</q>`
    * When substituting a tag for another surrounding, the tag is represented by `t`
        * e.g.: `cst"` will turn `<q>Hello world!</q>` into `"Hello world!"`
  * `ds`: **d**elete **s**urrounding — analogue to `cs`
  * `ss`: **s**et **s**urrounding — inserts a surrounding (2nd argument) to the motion received (1st argument)
    * Originally this keybing is `ys`, but I've remapped it to make it compatible with [EasyClip](#easyclip)
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
