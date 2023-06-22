vim.o.termguicolors = true
vim.o.showmode = false
vim.o.hlsearch = false
vim.o.ignorecase = true -- Ignore case when using lowercase in search
vim.o.smartcase = true -- But don't ignore it when using upper case
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true -- Convert tabs to spaces.
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.splitbelow = false
vim.o.splitright = true
vim.o.scrolloff = 12 -- Minimum offset in lines to screen borders
vim.o.sidescrolloff = 8
vim.o.mouse = nil
vim.o.hidden = true -- Do not save when switching buffers
vim.o.fileencoding = "utf-8"
vim.o.spell = false
vim.o.spelllang = "en_us"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.wildmode = "longest,list" -- Display auto-complete in Command Mode
vim.o.updatetime = 300 -- Delay until write to Swap and HoldCommand event
vim.wo.signcolumn = "yes"
vim.g.do_file_type_lua = 1
vim.o.undofile = true
vim.o.swapfile = false

--vim.cmd([[ set clipboard=unnamed ]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", ";w", ":w<cr>")
vim.keymap.set("n", ";G", ":G<cr>")
vim.keymap.set("n", ";q", ":q<cr>")
vim.keymap.set("n", ",e", ":e <c-r>=expand('%:p:h') . '/'<cr>")
vim.keymap.set("n", ",s", ":saveas <c-r>=expand('%:p:h') . '/'<cr>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    defaults = {
        lazy = true,
    },
    change_detection = {
        notify = false,
    },
})

--vim.keymap.set("n", "gf", ":!nix fmt %<cr>")
