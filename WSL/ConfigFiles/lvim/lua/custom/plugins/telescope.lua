return {
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   config = function()
  --     require("telescope").load_extension "file_browser"
  --   end,
  -- },
  {
    "nvim-telescope/telescope-symbols.nvim",
    config = function()
      require("telescope").load_extension "session-lens"
    end,
    lazy = true,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "crispgm/telescope-heading.nvim",
    config = function()
      require("telescope").load_extension "heading"
    end,
    lazy = true,
    ft = {
      "markdown",
      "help"
    },
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    config = function()
      require("telescope").load_extension "emoji"
    end,
  }
}
