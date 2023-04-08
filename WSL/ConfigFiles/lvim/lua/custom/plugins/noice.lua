return {
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        lsp = {
          signature = { enabled = false },
          hover = { enabled = false },
        },
        -- messages = {
        --     enabled = false
        -- },
        views = {
          cmdline_popup = {
            position = {
              row = -5,
              col = "50%",
            },
            size = {
              width = 90,
              height = "auto",
            }
          },
        }
      })
    end
  }
}
