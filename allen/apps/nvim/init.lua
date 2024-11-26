vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = "unnamedplus"

-- force these settings globally
vim.cmd([[
  autocmd BufEnter * setlocal tabstop=2 shiftwidth=2 expandtab
]])
