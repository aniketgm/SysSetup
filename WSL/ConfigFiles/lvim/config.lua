--[[
              __________________
          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
         /  \  \  \         __/  /  \  /  \          Description : Customized lunarvim configuration. This configuration
        /    \  \       _____   /    \/    \                       is divided into following sections:
       /  /\  \  \     /    /  /            \                      - LunarVim options
      /        \  \        /  /      \/      \                     - Vim options
     /          \  \      /  /                \                    - Additional plugins and their configurations
    /            \  \    /  /                  \                   - Additional keymappings
   /              \  \  /  /                    \
  /__            __\  \/  /__                  __\   Github Repo : https://github.com/aniketgm/Dotfiles
--]]
reload("custom/options")
reload("custom/plugins")
reload("custom/autocmds")
reload("custom/keymaps")

-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }

-- # Prefer curl over git for treesitter
require 'nvim-treesitter.install'.prefer_git = false

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "stylua" },
  -- {
  --     command = "prettier",
  --     extra_args = { "--print-width", "100" },
  --     filetypes = { "typescript", "typescriptreact", "html", "css", "javascript" },
  -- },
  {
    command = "prettierd",
    extra_args = { vim.api.nvim_buf_get_name(0) },
    filetypes = { "typescript", "typescriptreact", "html", "css", "javascript" },
  },
}
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
