vim.g.mapleader = ' '

-- LAZY INSTALL
-- install path
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop
-- auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
    print('Installing lazy.nvim...')
    vim.fn.systen({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
    print('Done.')
end
vim.opt.rtp:prepend(lazypath)

-- LAZY PLUGINS
require('lazy').setup({
    { 'rebelot/kanagawa.nvim' },
    { 'navarasu/onedark.nvim' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { 'm4xshen/autoclose.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { 'rust', 'javascript' },
                highlight = { enable = true, }
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { 'WhoIsSethDaniel/lualine-lsp-progress.nvim' },
})


-- OPTIONS
vim.opt.number = true

-- OPTIONS TAB
-- set indentation to be always done with spaces
vim.opt.expandtab = true
-- set the number of spaces <Tab> and <Backspace> inserts/deletes
vim.opt.softtabstop = 4
-- set the number of spaces that are inserted when (auto)indent (example: <) is used
vim.opt.shiftwidth = 4
-- define the width of a <Tab> character
-- makes sure that files containing tabs look the sames as ones using 4 spaces
vim.opt.tabstop = 4
-- (existing files can be converted to these settings with :retab)

-- THEME
require("kanagawa").setup {
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
}
require("kanagawa").load("wave")

-- LSP ZERO
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, buffnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = buffer })

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = buffer,
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end)

-- LSP ZERO EXTRA KEYBINDS
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

-- MASON
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'rust_analyzer', 'tsserver' },
    handlers = {
        lsp_zero.default_setup,
    },
})

-- TELESCOPE
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- HARPOON
local harpoon = require('harpoon')
harpoon:setup()

-- HARPOON KEYBINDS
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- quickly jump to a buffer
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
-- toggle previous and next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- AUTOCLOSE BRACES
require("autoclose").setup()

-- LUALINE
require("lualine").setup {
    options = {
        theme = "iceberg_dark"
    },
    sections = {
        lualine_c = {
            'lsp_progress'
        }
    }
}
