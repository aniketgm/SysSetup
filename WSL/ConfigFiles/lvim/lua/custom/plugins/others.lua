return {
  { "junegunn/limelight.vim" },
  { "ThePrimeagen/harpoon" },
  { "Bekaboo/deadcolumn.nvim" },
  -- { "dstein64/vim-startuptime" },
  -- {
  --     "smzm/hydrovim",
  --     dependencies = { "MunifTanjim/nui.nvim" },
  --     lazy = true,
  --     ft = "python",
  -- },
  {
    "chrisbra/unicode.vim",
    lazy = true,
  },
  {
    "preservim/tagbar",
    config = function()
      vim.g.tagbar_ctags_bins = '/usr/bin/ctags'
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        render = "minimal",
        top_down = false,
      })
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({})
    end
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('rest-nvim').setup({})
    end
  },
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require('auto-session').setup()
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('trouble').setup {}
    end
  },
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end
  },
  --[[
  {
      "ja-ford/delaytrain.nvim",
      config = function()
        require('delaytrain').setup {
            delay_ms = 1000, -- How long repeated usage of a key should be prevented
            grace_period = 2, -- How many repeated keypresses are allowed
            keys = { -- Which keys (in which modes) should be delayed
                ['nv'] = { 'h', 'j', 'k', 'l' },
                ['nvi'] = { '<Left>', '<Down>', '<Up>', '<Right>' },
            },
            ignore_filetypes = { "help", "NvimTree", "mason", "undotree" }, -- Example: set to {"help", "NvimTr*"} to
            -- disable the plugin for help and NvimTree
        }
      end
  },
  {
    "lmburns/lf.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
    config = function()
      require('lf').setup({})
    end,
  },
  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "anuvyklack/pretty-fold.nvim",
    config = function ()
      require('pretty-fold').setup()
    end
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end,
  },
  --]]
}
