## <a id="vanilla"></a>Vanilla mappings that I always forget and need to consult

### Movement keybinds

#### Vertical

* `^E`: scrolls down
* `^Y`: scrolls up
* `H`: jumps to the top of the screen (**h**igh)
* `M`: jumps to the middle of the screen (**m**edium)
* `L`: jumps to the bottom of the screen (**l**ow)
* `G`: obviously **g**oes to the end of file, but if given a count **g** to that line
  * e.g.: `50G` jumps to the 50th line
* `'.`, `g;`: jumpts to last edit
* `''` and ` `` `: I've inverted them both
  * `''`: takes the cursor position before the latest jump (undoes the jump)
  * ` `` `: takes the cursor to the line where the cursor was before the latest jump
* `[g, ]g`: goes to next/previous dia**g**nostic (error, warning)
* `[e, ]e`: goes to next/previous **e**rror

#### Horizontal

* `|`: jumps to the 1st column of current line
  * If given a count, jumsp to that column
  * e.g.: `17|` jumps to the 17th column of current line

### <a id="folding"></a>Folding keybinds

I've also left some custom keybinds in here so all the folding keybinds stay together.

* `za`: toggles the topmost level of folding under the cursor
* `zA`: toggles all levels of folding under the cursor
* `zr`: **r**educes folding in the whole buffer
* `zR`: opens all folds
* `zm`: increses folding in the whole buffer (**m**ake folding)
* `zM`: closes all folds

    <!-- ## <a id="additional-tips"></a>Additional tips/Observations

    I'm putting this here because I haven't memorized it yet and neet to consult it. In bash, you can use `Ctrl+Z` to suspend Neovim (or any app I guess) and then `fg` to go back to it (put it in the **f**ore**g**round). You can also use bg to leave it running in the **b**ack**g**round. -->

