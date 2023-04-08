return {
  {
    "renerocksai/telekasten.nvim",
    config = function()
      local main = vim.fn.expand("~/Documents/Telekasten")
      local home = vim.fn.expand("~/Documents/Telekasten/Home")
      local work = vim.fn.expand("~/Documents/Telekasten/Work")
      require('telekasten').setup({
        home = main,
        dailies = main .. '/' .. 'Dummy',
        weeklies = main .. '/' .. 'Dummy',
        templates = main .. '/' .. 'Dummy',
        vaults = {
          home_vault = {
            home = home,
            dailies = home .. '/' .. 'Daily',
            weeklies = home .. '/' .. 'Weekly',
            templates = home .. '/' .. 'Templates',
          },
          work_vault = {
            home = work,
            dailies = work .. '/' .. 'Daily',
            weeklies = work .. '/' .. 'Weekly',
            templates = work .. '/' .. 'Templates',
          },
        }
      })
    end,
  }
}
