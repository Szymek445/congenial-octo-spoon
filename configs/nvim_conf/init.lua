-- Set leader key (Space is commonly used for convenience)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General Settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for easier navigation
vim.opt.tabstop = 4          -- Number of spaces per tab
vim.opt.shiftwidth = 4       -- Number of spaces for auto-indent
vim.opt.expandtab = true     -- Convert tabs to spaces
vim.opt.smartindent = true   -- Enable smart indentation
vim.opt.wrap = false         -- Disable line wrapping
vim.opt.swapfile = false     -- Disable swap file creation
vim.opt.backup = false       -- Disable backup files
vim.opt.undofile = true      -- Enable persistent undo
vim.opt.termguicolors = true -- Enable true colors support
vim.opt.clipboard = "unnamedplus"


-- Plugin Manager (packer.nvim)
-- Ensure packer.nvim is installed before continuing
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
  end
end
ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Package manager
  use 'nvim-lua/plenary.nvim'   -- Common utilities
  use 'nvim-treesitter/nvim-treesitter' -- Better syntax highlighting
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
  use 'hoob3rt/lualine.nvim' -- Statusline
  use 'nvim-tree/nvim-tree.lua' -- File explorer
  use 'sindrets/diffview.nvim' -- Diffview for git
end)


-- Treesitter Configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {"lua", "python", "html", "css", "rust", "c", "cpp"},
  highlight = {
    enable = true,
  },
}

-- Telescope Configuration
local telescope = require('telescope')
telescope.setup{}
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { silent = true }) -- Find files
vim.keymap.set('n', '<leader>h', ':Telescope live_grep<CR>', { silent = true }) -- Search text



-- nvim-tree (File Explorer)
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5 
require('nvim-tree').setup({
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
})
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true }) -- Toggle file explorer


-- diff-view 
require('diffview').setup {}
vim.keymap.set('n', '<leader>g', ':DiffviewOpen<CR>', { silent = true }) -- Open explorer winfow
vim.keymap.set('n', '<leader>c', ':DiffviewClose<CR>', { silent = true }) -- Open explorer winfow

