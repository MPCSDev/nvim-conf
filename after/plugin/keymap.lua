local opts = { noremap = true, silent = true }

-- Telescope
vim.keymap.set('n', '<C-p>', "<cmd>Telescope find_files<CR>", opts)

-- Lsp
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

