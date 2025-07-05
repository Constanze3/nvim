vim.g.mapleader = " "

vim.opt.number = true

-- do not wrap text
vim.opt.wrap = false

-- set indentation to be always done with spaces
vim.opt.expandtab = true

-- define the width of a <Tab> character (how \t is displayed)
-- makes sure that files containing tabs look the sames as ones using 4 spaces
vim.opt.tabstop = 4

-- set the number of spaces <Tab> and <Backspace> inserts/deletes
vim.opt.softtabstop = 4

-- set the number of spaces that are inserted when (auto)indent (example: <) is used
vim.opt.shiftwidth = 4
-- (existing files can be converted to these settings with :retab)

-- keep signcolumn always open (otherwise error/warning symbols can get annoying)
vim.wo.signcolumn = "yes"

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
        vim.lsp.buf.format()
    end,
})

-- global variable used to collect information from individual plugins
global = {
    packages = {},
}

-- install-path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- ensure that lazy.nvim is installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins with lazy.nvim from the plugins folder
require("lazy").setup({
    { import = "plugins" },
    { import = "plugins/themes" },
})

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function(_)
        -- download/update packages
        require("mason").setup()
        require("mason-tool-installer").setup({
            ensure_installed = global.packages,
            auto_update = true,
        })
    end,
})

-- load wsl support
require("custom/wsl")

-- set theme
vim.cmd("colorscheme kanagawa-dragon")
