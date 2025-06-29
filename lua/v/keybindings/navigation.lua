local set_keybindings = require("v.utils.mappings").set_keybindings

---Smart select between j/k and gj/gk so vertical movement works better with
---wrapped lines.
---@see source https://www.reddit.com/r/vim/comments/a8mp8z/remapping_gj_gk_to_j_k_and_vice_versa/
---@param move "j"|"k"
---@return fun(): string
local function smart_vert_movement(move)
  return function()
    local is_operator_pending_mode = vim.api.nvim_get_mode().mode == "no"
    local count = vim.v.count

    if is_operator_pending_mode or (0 < count and count < 5) then
      return move
    end

    if count >= 5 then
      return "m'" .. count .. move
    end

    return "g" .. move
  end
end

set_keybindings({
  -- toggle last visited buffer
  { "n", "<BS>", "<C-^>" },

  -- toggle last visited tab
  { "n", "<M-BS>", "g<Tab>" },

  -- better window navigation
  { "n", "<C-h>", "<C-w>h" },
  { "n", "<C-j>", "<C-w>j" },
  { "n", "<C-k>", "<C-w>k" },
  { "n", "<C-l>", "<C-w>l" },

  -- better nav for omnicomplete
  { { "c", "i" }, "<C-j>", "<C-n>" },
  { { "c", "i" }, "<C-k>", "<C-p>" },

  -- make j/k wrapping-aware
  { "n", "j", smart_vert_movement("j"), { expr = true } },
  { "n", "k", smart_vert_movement("k"), { expr = true } },
})
