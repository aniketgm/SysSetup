--[[
  Bubbles config for lualine
  Original Author: lokesh-krishna
  Modified by: aniketgm
  MIT license, see LICENSE for more details.
--]]
-- Colors definitions
-- ------------------
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  green  = "#98be65",
  bg     = '#202328',
  fg     = "#bbc2cf",
  tmbg   = "#ffb86c"
}

local separators = {
  left_filled = '',
  left_line = '',
  right_filled = '',
  right_line = ''
  -- left_filled = '',
  -- right_filled = ''
}

-- local theme_colors = vim.api.nvim_get_hl_by_name("Normal", true)
-- local fg_color = string.format("%x", theme_colors['foreground'])
-- local bg_color = string.format("%x", theme_colors['background'])

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.tmbg },
    b = { fg = colors.fg, bg = colors.black },
    c = { fg = colors.fg, bg = colors.bg },
  },
  insert = { a = { fg = colors.black, bg = colors.green } },
  visual = { a = { fg = colors.black, bg = colors.violet } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.fg, bg = colors.black },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.fg, bg = colors.bg },
  },
}

-- Lualine customization
lvim.builtin.lualine.options.theme = bubbles_theme
lvim.builtin.lualine.options.component_separators = { left = separators.right_line, right = separators.left_line }
-- lvim.builtin.lualine.options.component_separators = '|'
lvim.builtin.lualine.options.section_separators = { left = separators.right_filled, right = separators.left_filled }
lvim.builtin.lualine.options.icons_enabled = lvim.use_icons
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.disabled_filetypes = { "alpha" }

local lualinecomps = require "lvim.core.lualine.components"

local mode = {
  function()
    local mode = require("lualine.utils.mode").get_mode()
    local map = {
      ["NORMAL"] = lvim.icons.ui.Target,
      ["INSERT"] = lvim.icons.ui.Pencil,
      ["REPLACE"] = "",
      ["V-REPLACE"] = "",
      ["VISUAL"] = "",
      ["V-LINE"] = "L",
      ["V-BLOCK"] = "B",
      ["SELECT"] = "S",
      ["S-LINE"] = "SL",
      ["COMMAND"] = "C",
      ["EX"] = "EX",
      ["MORE"] = lvim.icons.ui.Ellipsis,
      ["CONFIRM"] = lvim.icons.diagnostics.BoldQuestion,
      ["O-PENDING"] = "OP",
      ["SHELL"] = "ﲵ",
      ["TERMINAL"] = "",
    }
    return map[mode] .. ' '
  end,
  -- separator = { left = separators.left_filled },
  padding = { left = 1, right = 0 },
  color = {},
  cond = nil,
}

local branch = {
  "b:gitsigns_head",
  icon = lvim.icons.git.Branch,
  color = { bg = colors.black, fg = colors.white },
}

local location = {
  'location',
  separator = { left = separators.left_filled },
  padding = { left = 1, right = 1 },
}

lvim.builtin.lualine.sections.lualine_a = { mode }
lvim.builtin.lualine.sections.lualine_b = { branch }
lvim.builtin.lualine.sections.lualine_c = {
  lualinecomps.diff,
  lualinecomps.python_env,
}
lvim.builtin.lualine.sections.lualine_x = {
  lualinecomps.diagnostics,
  lualinecomps.lsp,
  -- lualinecomps.spaces,
  lualinecomps.filetype,
}
lvim.builtin.lualine.sections.lualine_y = {}
lvim.builtin.lualine.sections.lualine_z = { location }

lvim.builtin.lualine.inactive_sections.lualine_a = { mode }
lvim.builtin.lualine.inactive_sections.lualine_b = { lualinecomps.branch }
lvim.builtin.lualine.inactive_sections.lualine_c = {
  lualinecomps.diff,
  lualinecomps.python_env,
}
lvim.builtin.lualine.inactive_sections.lualine_x = {
  lualinecomps.diagnostics,
  lualinecomps.lsp,
  -- lualinecomps.spaces,
  lualinecomps.filetype,
}
lvim.builtin.lualine.inactive_sections.lualine_y = { lualinecomps.progress }
lvim.builtin.lualine.inactive_sections.lualine_z = { location }

lvim.builtin.lualine.tabline = {}
lvim.builtin.lualine.extensions = {}
