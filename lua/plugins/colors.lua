return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                -- Run `:KawaganaCompile` when config changes.
                compile = true,
            })
            vim.cmd([[colorscheme kanagawa]])
        end,
    },
}
