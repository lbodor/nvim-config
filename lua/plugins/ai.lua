return {
    {
        "Exafunction/codeium.vim",
        lazy = false,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        config = function()
            require("copilot").setup({
                panel = {
                    auto_refresh = true,
                },
            })
        end,
    },
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "cat /home/lbodor/.p/open-ai",
            })
        end,
    },
}
