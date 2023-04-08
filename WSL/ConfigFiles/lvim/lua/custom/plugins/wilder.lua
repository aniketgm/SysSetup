return {
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer(
      -- { pumblend = 20, },
        {
          highlighter = wilder.basic_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        },
        wilder.popupmenu_border_theme({
          highlights = { border = 'Normal' },
          border = 'rounded',
        })
      -- wilder.popupmenu_palette_theme({
      --     border = 'rounded', -- 'single', 'double', 'rounded' or 'solid'
      --     max_height = '25%', -- max height of the palette
      --     min_height = 0, -- set to the same as 'max_height' for a fixed height window
      --     prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
      --     reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
      -- })
      ))
    end
  }
}
