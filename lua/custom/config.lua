vim.g.have_nerd_font = true
vim.wo.wrap = true
vim.wo.linebreak = true

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd 'wincmd L' -- Move help window to the right (vertical split)
  end,
})
