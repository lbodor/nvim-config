return {
    {
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Gdiffsplit",
            "Gread",
        },
        config = function()
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = { "fugitive" },
                command = "setlocal cursorline",
            })
        end,
    },
    {
        "junegunn/gv.vim",
        cmd = { "GV" },
    },
    {
        "lewis6991/gitsigns.nvim",
        branch = "main",
        lazy = false,
        config = function()
            require("gitsigns").setup({
                signs = {
                    untracked = { text = "│" },
                },
                on_attach = function(bufnr)
                    local gitsigns = package.loaded.gitsigns

                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gitsigns.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gitsigns.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    vim.keymap.set("n", "<leader>cd", gitsigns.diffthis)
                    vim.keymap.set("n", "<leader>cp", gitsigns.preview_hunk, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>cs", ":Gitsigns stage_hunk<CR>")
                    vim.keymap.set("n", "<leader>cu", gitsigns.undo_stage_hunk)
                    vim.keymap.set("n", "<leader>cr", ":Gitsigns reset_hunk<CR>")
                    vim.keymap.set("n", "<leader>cS", gitsigns.stage_buffer)
                    vim.keymap.set("n", "<leader>cR", gitsigns.reset_buffer)
                    vim.keymap.set("n", "<leader>cb", gitsigns.toggle_current_line_blame)
                    --                    vim.keymap.set("n", "<leader>cd", gitsigns.toggle_deleted)
                end,
            })
        end,
    },
}
