-- #----------------
-- # Custom keymaps
-- #----------------

local fn = require("custom.funcs")

-- To list all keymaps do: <leader>Lk

-- # <Esc> is too far to reach everytime. Use 'ii' to switch to normal mode.
vim.api.nvim_set_keymap("i", "ii", "<Esc>", { noremap = true })

-- # Non leader insert-mode keymaps
-- # ------------------------------
-- vim.api.nvim_set_keymap("i", "<F12>", "FloatermNew --wintype=split --position=botright --height=0.4", { noremap = true })

-- # Non leader normal-mode keymaps
-- # ------------------------------
lvim.keys.normal_mode["<C-m>"] = "<cmd>Telescope resume<cr>"
lvim.keys.normal_mode["<C-q>"] = false
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-t>"] = "<cmd>FloatermNew --wintype=float --height=0.9 --width=0.9<cr>"
lvim.keys.normal_mode["<F3>"] = "<cmd>NvimTreeFindFileToggle<cr>"
lvim.keys.normal_mode["<F4>"] = "<cmd>UndotreeToggle<cr>"
lvim.keys.normal_mode["<F8>"] = "<cmd>TagbarToggle<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"

local trouble_ok, _ = pcall(require, "trouble")
if trouble_ok then
  lvim.lsp.buffer_mappings.normal_mode["gd"] = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" }
  lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<cmd>Trouble lsp_references<cr>", "References" }
  lvim.lsp.buffer_mappings.normal_mode["gi"] = { "<cmd>Trouble lsp_implementations<cr>", "Implementations" }
  lvim.lsp.buffer_mappings.normal_mode["gD"] = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" }
  lvim.lsp.buffer_mappings.normal_mode["gq"] = { "<cmd>Trouble quickfix<cr>", "QuickFix" }
  lvim.lsp.buffer_mappings.normal_mode["gl"] = { "<cmd>Trouble loclist<cr>", "LocationList" }
  lvim.lsp.buffer_mappings.normal_mode["gw"] = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace diagnostics" }
  lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    c = { "<cmd>TroubleClose<cr>", "Trouble close" },
    r = { "<cmd>TroubleRefresh<cr>", "Trouble refresh" },
    t = { "<cmd>TroubleToggle<cr>", "Trouble toggle" },
  }
end

-- # Telescope preview window keymaps
-- # --------------------------------
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-PageUp>"] = actions.preview_scrolling_up,
    ["<C-PageDown>"] = actions.preview_scrolling_down,
  },
  n = {
    ["<C-PageUp>"] = actions.preview_scrolling_up,
    ["<C-PageDown>"] = actions.preview_scrolling_down,
  },
}

-- Lunarvim maps '<leader>w' to save buffer.
-- Removing it for vimwiki, which uses '<leader>ww'
lvim.builtin.which_key.mappings["w"] = nil
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["T"] = nil
lvim.builtin.which_key.mappings["H"] = { "<cmd>nohlsearch<cr>", "No highlight" }

-- # ----------------------
-- # New which-key bindings
-- # ----------------------
lvim.builtin.which_key.mappings["P"] = {
  name = "+Project",
  l = { "<cmd>Telescope projects<cr>", "Select a project" },
  s = { "<cmd>Telescope live_grep<cr>", "Search text in current project" },
}

local session_ok, _ = pcall(require, "auto-session")
if session_ok then
  lvim.builtin.which_key.mappings["S"] = {
    name = "+Session",
    w = { "<cmd>SaveSession<cr>", "Save current session" },
    r = { "<cmd>RestoreSession<cr>", "Restore last session" },
    s = { "<cmd>SearchSession<cr>", "Show sessions" },
    k = { "<cmd>DeleteSession<cr>", "Kill/Delete current session" },
  }
end

lvim.builtin.which_key.mappings["D"] = {
  name = "+Dotfiles",
  r = { "<cmd>edit ~/.bashrc<cr>", "Edit bashrc" },
  a = { "<cmd>edit ~/.bash_aliases<cr>", "Edit bash aliases" },
  f = { "<cmd>edit ~/.bash_functions<cr>", "Edit bash functions" },
  t = { "<cmd>edit ~/.tmux.conf<cr>", "Edit tmux config" },
  s = { "<cmd>edit ~/.config/starship.toml<cr>", "Edit starship prompt config" },
  -- c = { "<cmd>edit ~/.config/alacritty/alacritty.yml", "Edit alacritty config" },
}

lvim.builtin.which_key.mappings["m"] = {
  name = "+MindNotes",
  m = { "<cmd>MindOpenMain<cr>", "Open main mind tree" },
  p = { "<cmd>MindOpenProject<cr>", "Open project mind tree" },
  c = { "<cmd>MindClose<cr>", "Close mind tree" }
}

local harpoon_ok, _ = pcall(require, "harpoon.ui")
if harpoon_ok then
  lvim.keys.normal_mode["<M-1>"] = "<cmd>lua require('harpoon.ui').nav_file(1)<cr>"
  lvim.keys.normal_mode["<M-2>"] = "<cmd>lua require('harpoon.ui').nav_file(2)<cr>"
  lvim.keys.normal_mode["<M-3>"] = "<cmd>lua require('harpoon.ui').nav_file(3)<cr>"
  lvim.builtin.which_key.mappings["h"] = {
    name = "+Harpoon",
    h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show harpoon menu" },
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add to harpoon menu" },
    p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Goto prev file" },
    n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Goto next file" },
  }
end

-- lvim.builtin.which_key.mappings["z"] = {
--     name = "+Zetelkasten",
--     n = { "<cmd>Telekasten new_note<cr>", "Add a new note" },
--     f = { "<cmd>Telekasten find_notes<cr>", "Find notes" },
--     d = { "<cmd>Telekasten find_daily_notes<cr>", "Find daily notes" },
--     w = { "<cmd>Telekasten find_weekly_notes<cr>", "Find weekly notes" },
--     s = { "<cmd>Telekasten search_notes<cr>", "Search/Grep notes" },
--     l = { "<cmd>Telekasten follow_link<cr>", "Follow link" },
--     t = { "<cmd>Telekasten show_tags<cr>", "Show tags" },
--     p = { "<cmd>Telekasten panel<cr>", "Show command panel" },
--     b = { "<cmd>Telekasten show_backlinks<cr>", "Show backlinks" },
--     v = { "<cmd>Telekasten switch_vault<cr>", "Switch vault" },
-- }

local restapi_ok, _ = pcall(require, "rest-nvim")
if restapi_ok then
  lvim.builtin.which_key.mappings["r"] = {
    name = "RestAPI",
    r = { "<Plug>RestNvim", "Run request" },
    p = { "<Plug>RestNvimPreview", "Preview using curl request" },
    l = { "<Plug>RestNvimLast", "Re-run last request" },
  }
end

local dkr_contr_name = "postgres_db"
lvim.builtin.which_key.mappings["T"] = {
  name = "Terminal",
  l = {
    "<cmd>FloatermNew --title=─($1/$2)─DB─Logs─ " .. fn.docker_logs(dkr_contr_name) .. "<cr>",
    "MySqlDB logs"
  },
  c = {
    "<cmd>FloatermNew --title=─($1/$2)─DB─Prompt─ " .. fn.docker_exec(dkr_contr_name) .. "<cr>",
    "MySqlDB prompt"
  },
}

-- lvim.builtin.which_key.mappings["n"] = {
--   name = "+Neorg Telescope",
--   w = { "<cmd>Telescope neorg switch_workspace<cr>", "Switch workspace" },
--   m = { "<cmd>Neorg inject-metadata<cr>", "Add metadata" },
-- }

-- # -------------------------------------
-- # Extending existing which-key bindings
-- # -------------------------------------

-- # Search extensions
lvim.builtin.which_key.mappings["sF"] = { "<cmd>Telescope find_files cwd=~<cr>", "Find files in HOME" }
lvim.builtin.which_key.mappings["s/"] = { "<cmd>Telescope find_files cwd=/<cr>", "Find files in ROOT" }
lvim.builtin.which_key.mappings["sB"] = { "<cmd>Telescope file_browser cwd=%:p:h depth=2<cr>", "Browse files" }
lvim.builtin.which_key.mappings["sT"] = { "<cmd>Telescope live_grep cwd=~<cr>", "Search text in HOME" }

-- # Buffer extensions
lvim.builtin.which_key.mappings["bs"] = {
  "<cmd>Telescope current_buffer_fuzzy_find<cr>",
  "Search text in this buffer"
}
lvim.builtin.which_key.mappings["bS"] = {
  "<cmd>Telescope live_grep grep_open_files=true<cr>",
  "Search text in all buffers"
}

-- # Vimwiki extensions
lvim.builtin.which_key.mappings["wf"] = {
  "<cmd>lua require('telescope').extensions.vimwiki.vimwiki()<cr>",
  "Find wiki file"
}
lvim.builtin.which_key.mappings["wS"] = {
  "<cmd>lua require('telescope').extensions.vimwiki.live_grep()<cr>",
  "Live grep wiki files"
}
lvim.builtin.which_key.mappings["wg"] = { "<cmd>Glow<cr>", "Markdown preview" }
lvim.builtin.which_key.mappings["wp"] = { "<cmd>MarkdownPreview<cr>", "Markdown preview HTML" }

-- # Toggle Limelight
-- local limelight_ok, _ = pcall(require, "limelight")
-- if limelight_ok then
lvim.builtin.which_key.mappings["ut"] = { "<cmd>Limelight!!<cr>", "Toggle limelight" }
-- end

-- # LazyGit
lvim.builtin.which_key.mappings["g"]["g"] = nil
lvim.builtin.which_key.mappings["gg"] = {
  "<cmd>FloatermNew --wintype=float --height=0.95 --width=0.95 lazygit<cr>",
  "LazyGit"
}

-- # LspStop
lvim.builtin.which_key.mappings["lt"] = { "<cmd>LspStop<cr>", "Stop" }

-- # DiffviewToggle
local diffview_ok, _ = pcall(require, "diffview")
if diffview_ok then
  lvim.keys.normal_mode["<F2>"] = "<cmd>DiffviewToggleFiles<cr>"
  lvim.builtin.which_key.mappings["gD"] = { "<cmd>DiffviewToggle<cr>", "Toggle Diffview" }
end
