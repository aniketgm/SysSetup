--              __________________
--          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
--         /  \  \  \         __/  /  \  /  \          Description : This is my customized wezterm config
--        /    \  \       _____   /    \/    \                       Highlights:
--       /  /\  \  \     /    /  /            \                      -- Titlebar: hidden, Startup: maximized
--      /        \  \        /  /      \/      \                     -- Theme: tokyomight, Tab-bar: bottom
--     /          \  \      /  /                \
--    /            \  \    /  /                  \     Github Repo : https://github.com/aniketgm/Dotfiles
--   /              \  \  /  /                    \
--  /__            __\  \/  /__                  __\
--

-- Load config from other files
-- require('ui.tab-title').setup()

-- Require the main 'wezterm' module
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace() .. "  ")
end)

wezterm.on("gui-startup", function(cmd)
  local _, _, w1 = mux.spawn_window {
    workspace = "Configs",
    cwd = wezterm.home_dir,
    args = { 'btop' },
  }
  w1:gui_window():toggle_fullscreen()
  w1:spawn_tab {
    args = { 'pwsh', '-nologo' },
  }

  mux.spawn_window {
    workspace = "Coding",
    args = {
      'wsl', '-d', 'Ubuntu-22.04',
      '--cd', '\\\\wsl.localhost\\Ubuntu-22.04\\home\\aniketgm',
    }
  }

  mux.set_active_workspace 'Configs'
end)

wezterm.on(
  'format-tab-title',
  -- function (tab, tabs, panes, config, hover, max_width)
  function(tab)
    if tab.is_active then
      local tab_text = ' ' .. tostring(tab.tab_index + 1) .. ': ' .. tab.active_pane.title .. ' '
      return {
        { Background = { Color = '#874f22' } },
        { Text = tab_text },
      }
    end
  end
)

local wsl_domains = wezterm.default_wsl_domains()
for index, domain in ipairs(wsl_domains) do
  if domain.name == 'WSL:Ubuntu-22.04' then
    domain.default_cwd = "\\\\wsl.localhost\\Ubuntu-22.04\\home\\aniketgm"
  end
end

return {
  -- Domains
  wsl_domains = wsl_domains,

  -- Powershell Core 7+ as default shell
  cell_width = 0.9,
  check_for_updates = false,
  color_scheme = "tokyonight",
  default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-nologo' },
  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    { family = "Symbols Nerd Font Mono", scale = 0.75 }
  }),
  font_size = 12.3,
  -- line_height = 0.9,
  show_update_window = false,
  tab_bar_at_bottom = true,
  automatically_reload_config = true,
  window_padding = {
    left = 5,
    right = 2,
    top = 5,
    bottom = 0,
  },
  window_close_confirmation = "NeverPrompt",
  -- window_decorations = "NONE", -- Hide title bar

  -- # All keymaps below
  -- # -----------------
  keys = {
    { key = 'l', mods = 'ALT', action = act.ShowLauncher },

    -- Split Panes
    {
      key = '|',
      mods = 'ALT|SHIFT',
      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '_',
      mods = 'ALT|SHIFT',
      action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Workspaces
    {
      key = 'w',
      mods = 'ALT',
      action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    { key = 'i', mods = 'CTRL|ALT', action = act.SwitchToWorkspace },
    { key = 'n', mods = 'CTRL|ALT', action = act.SwitchWorkspaceRelative(1) },
    { key = 'p', mods = 'CTRL|ALT', action = act.SwitchWorkspaceRelative(-1) },

    -- Switch to windows. Defined only for 5 windows for now.
    { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
    {
      key = 'LeftArrow',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'RightArrow',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'UpArrow',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'DownArrow',
      mods = 'CTRL|SHIFT',
      action = act.ActivatePaneDirection 'Down',
    },
  }
}
