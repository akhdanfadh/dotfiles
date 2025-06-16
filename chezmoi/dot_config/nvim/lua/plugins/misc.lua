return {
  -- Read or write files with sudo command
  {
    "lambdalisue/vim-suda",
    cmd = {
      "SudaRead",
      "SudaWrite",
    },
  },

  -- CMP in the command mode (blink replacing nvim-cmp)
  -- I thought it would be useful, but :q and enter will autocompleted to :qall
  -- Now just use the default cmdline.enabled=false by lazyvim developer,
  -- and press Tab to show the completion menu.
  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     cmdline = {
  --       enabled = true,
  --       keymap = { preset = 'inherit' },
  --       completion = {
  --         menu = {
  --           auto_show = function(ctx)
  --             return vim.fn.getcmdtype() == ':'
  --             -- enable for inputs as well, with:
  --             -- or vim.fn.getcmdtype() == '@'
  --           end,
  --         },
  --       },
  --     },
  --   }
  -- }
}
