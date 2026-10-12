return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.opt.background = "light"

    -- Re-apply overrides whenever a colorscheme loads, so they aren't wiped
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruvbox",
      callback = function()
        vim.cmd("highlight clear SignColumn")
        vim.cmd("highlight VertSplit    ctermbg=236")
        vim.cmd("highlight ColorColumn  ctermbg=237")
        vim.cmd("highlight LineNr       ctermbg=236 ctermfg=200")
        vim.cmd("highlight StatusLineNC ctermbg=238 ctermfg=0")
        vim.cmd("highlight StatusLine   ctermbg=240 ctermfg=232")
        vim.cmd("highlight Visual       ctermbg=240 ctermfg=0")
        vim.cmd("highlight Pmenu        ctermbg=240 ctermfg=12")
        vim.cmd("highlight PmenuSel     ctermbg=3   ctermfg=1")
        vim.cmd("highlight SpellBad     ctermbg=0   ctermfg=1")
        vim.cmd("highlight Cursor guifg=white guibg=black")
        vim.cmd("highlight iCursor guifg=white guibg=steelblue")
      end,
    })

    vim.cmd("colorscheme gruvbox")
  end,
}
