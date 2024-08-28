-- Basic settings
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.shiftwidth = 4           -- Shift 4 spaces when tab
vim.opt.tabstop = 4              -- 1 tab == 4 spaces
vim.opt.smartindent = true       -- Autoindent new lines
vim.opt.wrap = false             -- Disable line wrapping
vim.opt.cursorline = true        -- Highlight the current line
vim.opt.termguicolors = true     -- Enable true colors
vim.opt.scrolloff = 8            -- Keep 8 lines above/below cursor
vim.opt.signcolumn = "yes"       -- Always show the sign column

-- Key mappings
vim.g.mapleader = " "            -- Set leader key to space
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })  -- Save with Space+w

-- Plugins (using packer.nvim as an example)
require('packer').startup(function()
  use 'wbthomason/packer.nvim'            -- Packer manages itself
  use 'neovim/nvim-lspconfig'             -- LSP support
  use 'hrsh7th/nvim-cmp'                  -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'              -- LSP source for nvim-cmp
  use 'nvim-treesitter/nvim-treesitter'   -- Treesitter for better syntax highlighting
  use 'nvim-telescope/telescope.nvim'     -- Fuzzy finder
  use 'nvim-lua/plenary.nvim'             -- Common utilities for plugins
  use 'nvim-telescope/telescope-fzf-native.nvim' -- FZF sorter for Telescope
  use 'nvim-lualine/lualine.nvim'         -- Statusline
  use 'nvim-tree/nvim-tree.lua'           -- File explorer
  use 'psf/black'                         -- Python code formatter
  use 'mfussenegger/nvim-dap'             -- Debugger
  use 'navarasu/onedark.nvim'
end)

-- LSP settings for Python (using pyright)
require('lspconfig').pyright.setup{}

-- Treesitter setup
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "lua" },
  highlight = { enable = true }
}

-- Autocompletion setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For vsnip users
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }
  })
})

-- Debugger setup (using nvim-dap)
local dap = require('dap')
dap.adapters.python = {
  type = 'executable',
  command = 'python3',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return 'python3'
    end,
  },
}

-- Statusline setup (using lualine)
require('lualine').setup {
  options = { theme = 'auto' }
}

-- File explorer setup (using nvim-tree)
require('nvim-tree').setup {}

-- Telescope setup
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "venv", ".git" },
    mappings = {
      i = {
        ["<C-n>"] = require('telescope.actions').cycle_history_next,
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
      },
    },
  }
}

-- Python-specific settings
vim.g.python3_host_prog = '/usr/bin/python3'  -- Set Python 3 interpreter

-- Color scheme
require('onedark').setup {
    style = 'dark', -- Set the theme style do dark
    colors = {
        bg = '#1c1c1c', -- Set a custom darker bg color
    },
    highlights = {
        Normal = {bg = '#1c1c1c' }  -- Ensure the normal background uses the custom color
    },
    transparent = false, -- Do not use a transparent background
    term_colors = true,  -- Change terminal colors as well
    ending_tildes = false, -- Show end-of-buffer tildes
    cmp_itemkind_reverse = false, -- Reverse item kinds in completion menu
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'italic,bold',
        strings = 'none',
        variables = 'none'
    },
    diagnostics = {
        darker = true, -- Darker colors for diagnostic
        undercurl = true, -- Use undercurl instead of underline for diagnostics
        background = false, -- Use background color for virtual text
    },
}
require('onedark').load()
