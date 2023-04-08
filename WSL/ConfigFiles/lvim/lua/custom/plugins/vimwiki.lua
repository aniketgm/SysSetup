return {
  -- # Vimwiki
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/Documents/Vimwiki/',
          path_html = '~/Documents/Vimwiki/site_html/',
          custom_wiki2html = 'vimwiki_markdown',
          diary_rel_path = 'Diary/',
          syntax = 'markdown',
          ext = '.md',
          template_default = 'default',
          template_ext = '.tpl',
          template_path = '~/Documents/Vimwiki/Templates/',
          auto_toc = 1,
        }
      }
      vim.g.vimwiki_listsyms = ' ○◑✓'
      vim.g.vimwiki_global_ext = 0
      require("luasnip").filetype_extend("vimwiki", { "markdown" })
    end,
    lazy = true,
    ft = 'markdown'
  },
  -- # Telescope extension for Vimwiki
  {
    "ElPiloto/telescope-vimwiki.nvim",
    config = function()
      require("telescope").load_extension "vimwiki"
    end,
    lazy = true,
    ft = 'vimwiki'
  },
}
