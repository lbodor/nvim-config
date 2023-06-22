return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "folke/trouble.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-telescope/telescope-project.nvim",
            "princejoogie/dir-telescope.nvim",
        },
        keys = {
            { "<leader>p", ":Telescope find_files<cr>" },
            { "<leader>P", ":Telescope project<cr>" },
            { "<leader>o", ":Telescope buffers<cr>" },
            { "<leader>g", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>" },
            { "<leader>b", ":Telescope git_branches<cr>" },
        },
        config = function()
            local telescope = require("telescope")
            local trouble = require("trouble.providers.telescope")
            local live_grep_args_actions = require("telescope-live-grep-args.actions")

            telescope.setup({
                defaults = {
                    layout_strategy = "vertical",
                    mappings = { -- extend mappings
                        i = {
                            ["<c-x>"] = trouble.open_with_trouble,
                        },
                    },
                },
                pickers = {
                    files = {
                        mappings = {
                            i = {
                                ["<C-i>"] = false,
                            },
                        },
                    },
                },
                extensions = {
                    project = {
                        base_dirs = {
                            "~/.config/nvim",
                            "~/nixos",
                            "~/dev",
                        },
                        hidden_files = true, -- default: false
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        -- define mappings, e.g.
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = live_grep_args_actions.quote_prompt(),
                                ["<C-i>"] = live_grep_args_actions.quote_prompt({ postfix = " --iglob " }),
                                ["<c-x>"] = trouble.open_with_trouble,
                            },
                        },
                        -- ... also accepts theme settings, for example:
                        -- theme = "dropdown", -- use dropdown theme
                        -- theme = { }, -- use own theme spec
                        -- layout_config = { mirror=true }, -- mirror preview pane
                    },
                },
            })
            telescope.load_extension("project")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("dir")
        end,
    },
}
