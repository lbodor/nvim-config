return {
    {
        "folke/which-key.nvim",
        branch = "main",
        lazy = false,
        config = function()
            require("which-key").setup()
        end,
    },
}
