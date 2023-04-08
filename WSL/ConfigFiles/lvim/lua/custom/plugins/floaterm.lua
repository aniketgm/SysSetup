return {
  {
    "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_keymap_new = '<F9>'
      vim.g.floaterm_keymap_toggle = '<F11>'
      vim.g.floaterm_keymap_prev = '<F10>'
      vim.g.floaterm_keymap_next = '<F12>'
      vim.g.floaterm_wintype = 'split'
      vim.g.floaterm_height = 0.4
      -- vim.g.floaterm_width = 0.9
      vim.g.floaterm_autoclose = 1
      -- vim.g.floaterm_title = '─[-($1/$2)-Terminal-]─'
      vim.g.floaterm_title = '─($1/$2)─Terminal─'
      vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    end,
  }
}
