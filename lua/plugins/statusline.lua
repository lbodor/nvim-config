return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            { "kyazdani42/nvim-web-devicons" },
            { "smiteshp/nvim-navic" },
        },
        config = function()
            local navic = require("nvim-navic")

            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    --theme = "nightfox",
                    theme = "kanagawa",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    -- component_separators = "",
                    -- section_separators = "",
                },
                sections = {
                    lualine_a = { "mode" },
                    -- lualine_c = {
                    --     { navic.get_location, cond = navic.is_available },
                    -- },
                    lualine_b = {},
                    -- lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = { "branch", "filename", "diagnostics" },
                    lualine_x = { "fileformat", "progress", "location" },
                    -- lualine_x = { 'encoding', 'fileformat', 'progress', 'location' },
                    -- lualine_x = { 'encoding', 'fileformat', 'filetype', 'progress', 'location' },
                    lualine_y = {},
                    lualine_z = {},
                    -- lualine_y = {'progress'},
                    -- lualine_z = {'location'}
                },
                -- tabline = {
                --     lualine_a = { "tabs" },
                -- lualine_b = { "branch" },
                -- lualine_c = { "filename" },
                -- lualine_x = {},
                -- lualine_y = {},
                -- lualine_z = { "tabs" },
                -- },
            })
        end,
    },
}
