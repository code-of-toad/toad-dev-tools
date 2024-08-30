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

-- Ensure that `packer.nvim` is bootstrapped
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Plugins (using packer.nvim as an example)
require('packer').startup(function()
  use 'wbthomason/packer.nvim'            -- Packer manages itself
  use 'neovim/nvim-lspconfig'             -- LSP support
  use 'hrsh7th/nvim-cmp'                  -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'              -- LSP source for nvim-cmp
  use 'nvim-treesitter/nvim-treesitter'   -- Treesitter for better syntax highlighting
  use 'nvim-telescope/telescope.nvim'     -- Fuzzy finder
  use 'nvim-lua/plenary.nvim'             -- Common utilities for plugins
  use { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }  -- FZF sorter for Telescope
  use 'nvim-lualine/lualine.nvim'         -- Statusline
  use 'nvim-tree/nvim-tree.lua'           -- File explorer
  use 'psf/black'                         -- Python code formatter
  use 'mfussenegger/nvim-dap'             -- Debugger
  use 'navarasu/onedark.nvim'             -- Color scheme: Atom One Dark
  use 'numToStr/Comment.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- LSP settings for Python (using pyright)
require('lspconfig').pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'off',
      },
    },
  },
})

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
    bg = '#1c1c1f', -- Set a custom darker bg color
  },
  highlights = {
    Normal = {bg = '#1c1c1f' }  -- Ensure the normal background uses the custom color
  },
  transparent = false, -- Do not use a transparent background
  term_colors = true,  -- Change terminal colors as well
  ending_tildes = false, -- Show end-of-buffer tildes
  cmp_itemkind_reverse = false, -- Reverse item kinds in completion menu
  code_style = {
    comments = 'none',
    keywords = 'none',
    functions = 'bold',
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

-- Comment out lines
require('Comment').setup({
  -- Add any custom configuration here
  padding = true, -- Add a space between comment and the line
  sticky = true,  -- Keeps the cursor in place after commenting
  mappings = {
    -- operator-pending mapping
    basic = true,    -- `gcc` to comment a line
    extra = true,    -- `gbc` to block comment
    extended = false,
  },
})

-- KEY MAPPINGS
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })     -- Save with Space + w
vim.api.nvim_set_keymap('n', '<leader>e', ':<Up><CR>', { noremap = true, silent = true })  -- Execute last nvim command with Space + e
-- Keybinding for commenting line(s)
vim.keymap.set('n', '<C-_>', 'gcc', { noremap = true, silent = true })
vim.keymap.set('v', '<C-_>', 'gc',  { noremap = true, silent = true })













