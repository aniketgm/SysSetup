return {
  "nvim-neorg/neorg",
  run = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {}, -- Enable default modules

        -- ["core.autocommands"] = {},
        -- ["core.norg.esupports.hop"] = {},
        -- ["core.norg.esupports.metagen"] = {},
        -- ["core.keybinds"] = {},
        -- ["core.norg.news"] = {},
        -- ["core.norg.qol.toc"] = {},
        -- ["core.norg.qol.todo_items"] = {},
        -- -- ["core.syntax"] = {},            -- Has some issue with auto-session.
        -- ["core.tangle"] = {},
        -- ["core.norg.esupports.indent"] = {},
        -- ["core.norg.journal"] = {},
        -- ["core.integrations.treesitter"] = {},
        -- ["core.neorgcmd"] = {},
        -- ["core.mode"] = {},

        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              projects = "~/Documents/Neorg/Projects",
              study    = "~/Documents/Neorg/Study",
              finance  = "~/Documents/Neorg/Finance",
              social   = "~/Documents/Neorg/Social",
            }
          }
        },
        ["core.norg.concealer"] = {},
        ["core.integrations.telescope"] = {}, -- Requires neorg-telescope plugin
      }
    }
    local sources_table = lvim.builtin.cmp.sources
    sources_table[#sources_table + 1] = { name = "neorg" }
  end
}
