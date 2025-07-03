
-- BASIC VIM OPTIONS

vim.g.mapleader = " "

-- do not wrap text
vim.opt.wrap = false

vim.opt.number = true

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

-- keep signcolumn always open
vim.wo.signcolumn = "yes"

tab_overrides = { [2] = {"dart", "yaml"} }
for k, v in pairs(tab_overrides) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = v,
      callback = function()
        vim.opt_local.tabstop = k
        vim.opt_local.shiftwidth = k
        vim.opt_local.softtabstop = k
      end,
    }) 

    vim.api.nvim_create_autocmd("BufLeave", {
      pattern = v,
      callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
      end,

    })
end

-- disable lsp underlines
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, { underline = false }
-- )

-- FORMAT ON SAVE
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end
})

-- LAZY.NVIM

-- install-path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

-- load plugins from the plugins folder
require("lazy").setup({
    {import = "plugins"},
    {import = "plugins/themes"}
})

-- THEME
vim.cmd("colorscheme kanagawa-dragon")
