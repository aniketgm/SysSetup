lvim.plugins = {}

local add_plugins = function(plugin_table)
  for _, plugin in pairs(plugin_table) do
    table.insert(lvim.plugins, plugin)
  end
end

add_plugins(require("custom.plugins.colorschemes"))
add_plugins(require("custom.plugins.floaterm"))
add_plugins(require("custom.plugins.undotree"))
add_plugins(require("custom.plugins.noice"))
-- add_plugins(require("custom.plugins.vimwiki"))
add_plugins(require("custom.plugins.markdown"))
add_plugins(require("custom.plugins.others"))
add_plugins(require("custom.plugins.telescope"))
add_plugins(require("custom.plugins.mindnote"))
-- add_plugins(require("custom.plugins.neorg"))
-- add_plugins(require("custom.plugins.wilder"))
-- add_plugins(require("custom.plugins.telekasten"))
