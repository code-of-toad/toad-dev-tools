-- UPDATED: 2026-10-16

-- Neovim 0.11.6 configuration for WSL Ubuntu
-- Place at: ~/.config/nvim/init.lua

-- 1. Core settings ----------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nvim-tree recommends disabling the built-in netrw explorer first.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true            -- Absolute line numbers
vim.opt.relativenumber = true    -- Relative distances to other lines
vim.opt.expandtab = true         -- Insert spaces when pressing Tab
vim.opt.shiftwidth = 4           -- Spaces used by >> and <<
vim.opt.tabstop = 4              -- Display width of a tab character
vim.opt.smartindent = true       -- Autoindent new lines
vim.opt.wrap = false             -- Do not visually wrap long lines
vim.opt.cursorline = true        -- Highlight current line
vim.opt.termguicolors = true     -- True-color terminal themes
vim.opt.scrolloff = 8            -- Keep context above/below cursor
vim.opt.signcolumn = 'yes'       -- Prevent layout shifts from diagnostics
vim.opt.ignorecase = true        -- Case-insensitive searching by default
vim.opt.smartcase = true         -- Respect uppercase characters in searches
vim.opt.splitright = true        -- Vertical splits appear on the right
vim.opt.splitbelow = true        -- Horizontal splits appear below
vim.opt.mouse = 'a'              -- Mouse support in the terminal

-- 2. Key mappings -----------------------------------------------------------
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('n', '<leader>e', ':<Up><CR>', { desc = 'Repeat previous Ex command', silent = true })
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = 'Quit window', silent = true })

-- 3. Bootstrap lazy.nvim ----------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local output = vim.fn.system({
        'git', 'clone', '--filter=blob:none', '--branch=stable',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { 'lazy.nvim installation failed:\n' .. output, 'ErrorMsg' } }, true, {})
        return
    end
end
vim.opt.rtp:prepend(lazypath)

-- 4. Plugins ----------------------------------------------------------------
require('lazy').setup({
    -- Atom One Dark theme, with your darker background.
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedark').setup({
                style = 'dark',
                colors = { bg = '#1c1c1f' },
                highlights = { Normal = { bg = '#1c1c1f' } },
                transparent = false,
                term_colors = true,
                ending_tildes = false,
                code_style = {
                    comments = 'none',
                    keywords = 'none',
                    functions = 'bold',
                    strings = 'none',
                    variables = 'none',
                },
            })
            require('onedark').load()
        end,
    },

    -- Syntax highlighting: 0.11-compatible legacy branch.
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        -- Parsers are installed via ensure_installed; run :TSUpdate manually after startup when needed.
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'python', 'lua', 'bash', 'json', 'yaml', 'sql' },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Completion sources and dropdown.
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body) -- Native Neovim snippets
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
            })
        end,
    },

    -- Python language server configuration for Neovim 0.11+.
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = { 'hrsh7th/cmp-nvim-lsp' },
        config = function()
            vim.lsp.config('pyright', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = 'basic',
                        },
                    },
                },
            })
            vim.lsp.enable('pyright')
        end,
    },

    -- File and live-text fuzzy searching.
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8', -- Compatible release for Neovim 0.11.6
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup({
                defaults = {
                    file_ignore_patterns = { 'venv/', '%.venv/', '%.git/' },
                },
            })
            pcall(telescope.load_extension, 'fzf')
        end,
    },

    -- Sidebar file explorer (works without a Nerd Font).
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                view = { width = 32 },
                renderer = {
                    icons = {
                        show = { file = false, folder = false, folder_arrow = false, git = false },
                    },
                },
            })
        end,
    },

    -- Bottom status line.
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = { theme = 'auto', icons_enabled = false },
            })
        end,
    },

    -- Line/block commenting with gcc, gc, and Ctrl+/.
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({ padding = true, sticky = true })
            vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)',
                { remap = true, desc = 'Toggle current line comment' })
            vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)',
                { remap = true, desc = 'Toggle selected line comments' })
        end,
    },

    -- Python formatting with the separately installed black executable.
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = { python = { 'black' } },
                format_on_save = function(bufnr)
                    if vim.bo[bufnr].filetype == 'python' then
                        return { timeout_ms = 1000, lsp_format = 'fallback' }
                    end
                end,
            })
        end,
    },

    -- Python debugging with debugpy, installed at the OS level.
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            dap.adapters.python = {
                type = 'executable',
                command = '/usr/bin/python3', -- Ubuntu Python with apt python3-debugpy
                args = { '-Xfrozen_modules=off', '-m', 'debugpy.adapter' },
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch current file',
                    program = '${file}',
                    pythonPath = function()
                        local venv_python = vim.fn.getcwd() .. '/.venv/bin/python'
                        if vim.fn.executable(venv_python) == 1 then
                            return venv_python
                        end
                        return '/usr/bin/python3'
                    end,
                },
            }
        end,
    },
}, {
    install = { colorscheme = { 'onedark' } },
    checker = { enabled = false }, -- Update plugins deliberately with :Lazy update
    rocks = { enabled = false },
})

-- 5. Workflow shortcuts ----------------------------------------------------
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end,
    { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end,
    { desc = 'Search file contents' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end,
    { desc = 'Find open buffers' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end,
    { desc = 'Search Neovim help' })
vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>f', function()
    require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format current buffer' })

-- Language server shortcuts (active in supported files).
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

-- Debugging shortcuts (Python).
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Start/continue debugger' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Debug: step over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Debug: step into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'Debug: step out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end,
    { desc = 'Toggle breakpoint' })
