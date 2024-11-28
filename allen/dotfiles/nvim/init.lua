vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.smartcase = true

-- force these settings globally
vim.cmd([[
  autocmd BufEnter * setlocal tabstop=2
  autocmd BufEnter * setlocal shiftwidth=2
  autocmd BufEnter * setlocal expandtab
]])
