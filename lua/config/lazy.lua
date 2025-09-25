local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "folke/which-key.nvim", opts = {} },
  { "nvim-tree/nvim-web-devicons" },
  
  -- Modern file explorer (like VSCode)
  { 
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  },
  
  -- Keep nvim-tree as backup
  { "nvim-tree/nvim-tree.lua" },
  
  -- Enhanced statusline and winbar
  { "nvim-lualine/lualine.nvim" },
  { 
    "utilyre/barbecue.nvim", -- VSCode-like breadcrumb
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
  },
  
  -- Window management
  { "anuvyklack/windows.nvim", -- Auto-resize windows
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    }
  },
  { "sindrets/winshift.nvim" }, -- Move windows around
  
  -- Enhanced telescope
  { "nvim-telescope/telescope.nvim", tag = "0.1.6" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  
  -- Enhanced syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" }, -- Show context
  
  -- Terminal
  { "akinsho/toggleterm.nvim", version = "*" },
  
  -- LSP
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "onsails/lspkind.nvim" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  { "stevearc/conform.nvim" },
  { "j-hui/fidget.nvim", tag = "legacy" },
  
  -- UI
  { "goolord/alpha-nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "akinsho/bufferline.nvim", version = "*" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
  { "stevearc/oil.nvim" },
  
  -- Better notifications
  { "rcarriga/nvim-notify" },
  
  -- Session management
  { "folke/persistence.nvim" },
}, {
  ui = { border = "rounded" },
})


