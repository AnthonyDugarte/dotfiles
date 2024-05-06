
-- Toggling number options
vim.keymap.set("n", "<leader>tn", "<cmd> set nu!<CR>", { desc = "[T]oggle line [N]umber" })
vim.keymap.set("n", "<leader>trn", "<cmd> set rnu!<CR>", { desc = "[T]oggle relative [N]umber" })

-- Keep visual mode on identation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Diagnostic related
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev { float = { border = "rounded" } }<CR>', { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next { float = { border = "rounded" } }<CR>', { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float { border = "rounded" }<CR>', { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = 'Open diagnostic [Q]uickfix list' })
