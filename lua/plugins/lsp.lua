local lib = require("lib")

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "gn", vim.lsp.buf.rename },
            { "gd", vim.lsp.buf.definition },
            { "gi", vim.lsp.buf.implementation },
            { "gs", vim.lsp.buf.signature_help },
            { "gr", vim.lsp.buf.references },
            { "ga", vim.lsp.buf.code_action },
            { "gf", vim.lsp.buf.format },
        },
        config = function()
            vim.diagnostic.config({
                virtual_lines = {
                    only_current_line = false,
                },
                virtual_text = false,
                signs = true,
                underline = false,
                update_in_insert = false,
            })

            local lspconfig = require("lspconfig")
            lspconfig.bashls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.lemminx.setup({})
            lspconfig.gopls.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.terraformls.setup({})
            lspconfig.tflint.setup({})

            lspconfig.nil_ls.setup({
                settings = {
                    ["nil"] = {
                        formatting = {
                            command = { "alejandra" },
                        },
                    },
                },
            })

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            -- library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        format = {
                            enable = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        -- dir = "/home/lbodor/dev/null-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local null_ls = require("null-ls")

            -- Find project root.
            local project_root = function()
                -- See airblade/vim-rooter for FindRootDiretory.
                -- vim-rooter updates cwd via autocmd, but not before null-ls receives diagnostics on buffer load.
                return vim.api.nvim_call_function("FindRootDirectory", {}) or vim.loop.cwd()
            end

            -- Try to find treefmt.toml.
            local treefmt_config = function()
                local config = os.getenv("TREEFMT_CONFIG") or project_root() .. "/treefmt.toml"
                if vim.fn.filereadable(config) == 1 then
                    return config
                end
            end

            -- Return true if formatter is handled by treefmt.
            local is_registered_with_treefmt = function(formatter_name)
                local config = treefmt_config()
                if config then
                    for line in io.lines(config) do
                        if line == "[formatter." .. formatter_name .. "]" then
                            return true
                        end
                    end
                end
            end

            -- Runtime condition to disable formatters that are handled by treefmt.
            local unless_registered_with_treefmt = function(params)
                return not is_registered_with_treefmt(params:get_source().name)
            end

            local sources = {
                -- All
                null_ls.builtins.formatting.treefmt.with({
                    runtime_condition = treefmt_config,
                }),

                null_ls.builtins.completion.spell,

                -- Bash
                null_ls.builtins.diagnostics.shellcheck.with({
                    diagnostics_format = "[#{c}] #{m} (#{s})",
                }),
                null_ls.builtins.code_actions.shellcheck,

                -- Lua
                null_ls.builtins.diagnostics.selene.with({
                    diagnostics_format = "#{m} (#{s})",
                }),
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-type", "Tabs" },
                }),
            }

            -- Return true if source is a formatter
            local is_formatter = function(source)
                return (type(source.method) == "table" and lib.contains(source.method, null_ls.methods.FORMATTING))
                    or (source.method == null_ls.methods.FORMATTING)
            end

            for _, source in ipairs(sources) do
                -- null-ls sets lsp project root once on startup, so we dynamically change the
                -- spawn directory to project root of current file, so that null-ls sources can find
                -- their configuration files (e.g., selene.toml, treefmt.toml).
                source.generator.opts.cwd = project_root

                -- Disable formatters that are handled by treefmt.
                if is_formatter(source) then
                    source.generator.opts.runtime_condition = unless_registered_with_treefmt
                end
            end

            null_ls.setup({ sources = sources })
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    require("jdtls").start_or_attach({
                        cmd = { "jdt.sh" },
                        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
                        settings = {
                            java = {
                                format = {
                                    settings = {
                                        url = "file:///home/lbodor/dev/geodesy/gnss-guidelines/gnss-eclipse-formatter.xml",
                                    },
                                },
                            },
                        },
                    })
                end,
            })
        end,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        keys = {
            { "<leader>e", ":lua require('lsp_lines').toggle()<cr>" },
        },
        config = function()
            local lsp_lines = require("lsp_lines")
            lsp_lines.toggle()
            lsp_lines.setup()
        end,
    },
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>W", ":TroubleToggle<cr>" },
            { "<leader>xx", ":TroubleToggle<cr>" },
            { "<leader>xw", ":TroubleToggle workspace_diagnostics<cr>" },
            { "<leader>xd", ":TroubleToggle document_diagnostics<cr>" },
            { "<leader>xl", ":TroubleToggle loclist<cr>" },
            { "<leader>xq", ":TroubleToggle quickfix<cr>" },
            { "<leader>xr", ":TroubleToggle lsp_references<cr>" },
        },
        config = function()
            require("trouble").setup({
                auto_fold = false,
                padding = false,
                icons = false,
                auto_preview = true,
                use_diagnostic_signs = true,
            })
        end,
    },
}
