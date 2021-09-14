require("telescope-emoji").setup({
    -- emoji: { name="", value="", cagegory="", description="" }
    action = function(emoji)
        -- vim.fn.setreg('"', emoji.value)
        -- print('Press p or ""p to paste the emoji:' .. emoji.value)

        vim.fn.execute('normal! i' .. emoji.value) -- insets the emoji
        vim.fn.execute('stopi') -- leaves insert mode
    end,
})

