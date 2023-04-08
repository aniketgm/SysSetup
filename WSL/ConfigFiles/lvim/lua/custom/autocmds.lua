-- # ----------------------
-- #  Miscellaneous Config
-- # ----------------------
--
-- This houses additional configs like custom commands / autocmds, etc..

-- # Autocmds
-- # --------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "floaterm",
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})

-- local cmdheightaugroup = vim.api.nvim_create_augroup('cmdheight', {clear = true})
-- vim.api.nvim_create_autocmd('RecordingEnter', {
--   group = cmdheightaugroup,
--   callback = function()
--     vim.opt.cmdheight = 1
--   end
-- })
-- vim.api.nvim_create_autocmd('RecordingLeave', {
--   group = cmdheightaugroup,
--   callback = function()
--     vim.opt.cmdheight = 0
--   end
-- })

-- # Custom Commands
-- # ---------------

vim.api.nvim_create_user_command("DiffviewToggle", function(e)
  local view = require("diffview.lib").get_current_view()
  if view then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen " .. e.args)
  end
end, { nargs = "*" })

vim.api.nvim_create_user_command("AddCurrTime", function()
  local time_pattern = "%a, %b %d %Y, %H:%M"
  vim.cmd("put =strftime('" .. time_pattern .. "')")
end, {})

vim.api.nvim_create_user_command("ToggleNr", function()
  local relnumbr = vim.opt.relativenumber:get()
  local numbr = vim.opt.number:get()
  if numbr and relnumbr then
    vim.opt.number = false
    vim.opt.relativenumber = false
  else
    vim.opt.number = true
    vim.opt.relativenumber = true
  end
end, {})

vim.api.nvim_create_user_command("NewFile", function()
  vim.ui.input({ prompt = "New file: " }, function(input)
    vim.cmd("edit " .. input)
  end)
end, {})

-- Param relative boolean #Whether relativenumber should be set
-- local function set_relativenumber(relative)
--   local in_insert_mode = vim.api.nvim_get_mode().mode == "i"

--   if vim.o.number then
--     vim.opt.relativenumber = relative and not in_insert_mode
--   end
-- end

-- lvim.autocommands = {
--     {
--         { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdLineLeave" },
--         {
--             desc = "Set relative number when not in insert mode",
--             callback = function()
--               set_relativenumber(true)
--             end,
--         },
--     },
--     {
--         { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdLineEnter" },
--         {
--             desc = "Turn off relative number when in insert mode",
--             callback = function()
--               set_relativenumber(false)
--             end,
--         },
--     },
-- }


-- # Toggle LSP
-- local diagnostic_active = true
-- local toggle_diagnostics = function()
--   diagnostic_active = not diagnostic_active
--   if diagnostic_active then
--     vim.diagnostic.show()
--   else
--     vim.diagnostic.hide()
--   end
-- end
-- vim.keymap.set('n', "<leader>lt", toggle_diagnostics)
