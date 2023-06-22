return {
    {
        "akinsho/toggleterm.nvim",
        keys = {
            { "<leader>t", ":ToggleTerm dir=<c-r>=expand('%:p:h')<cr><cr>" },
            { "<leader>T", ":ToggleTerm<cr>" },
            { "<leader>vt", ":ToggleTerm dir=<c-r>=expand('%:p:h')<cr> direction=vertical<cr>" },
            { "<leader>vT", ":ToggleTerm<cr>" },
            { "<C-w>", [[<C-\><C-n><C-w>]], mode = "t" },
        },
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "horizontal" then
                        -- TODO: return vim.fn.winheight(0) * 0.5
                        return 36
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.5
                    end
                end,
                shade_terminals = false,
            })
            vim.cmd([[ autocmd BufEnter term://* startinsert ]])
        end,
    },
    {
        "boltlessengineer/bufterm.nvim",
        cmd = { "BufTermEnter" },
        config = function()
            require("bufterm").setup({})
        end,
    },
}
