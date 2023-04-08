return {
  {
    "phaazon/mind.nvim",
    branch = 'master',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("mind").setup {
        persistence = {
          state_path = "$HOME/Documents/MindNotes/mind.json",
          data_dir = "$HOME/Documents/MindNotes"
        },
        ui = {
          width = 30,
          icon_preset = {
            { " ", "Project" },
            { " ", "Idea" },
            { " ", "Note(s)" },
            { "陼", "Tasks/Todos" },
            { " ", "Todo" },
            { "☰ ", "Doing" },
            { " ", "Done" },
            { " ", "Cancelled" },
            { " ", "GitHub" },
            { " ", "Monitoring" },
            { " ", "Internet, Earth, everyone!" },
            { " ", "On Hold" },
            { "₹ ", "Finance" },
          }
        },
        keymaps = {
          normal = {
            ["<leader>ms"] = "open_data_index"
          }
        }
      }
    end,
  }
}
