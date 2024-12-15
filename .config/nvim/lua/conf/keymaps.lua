-- Toggling number options
vim.keymap.set("n", "<leader>tn", "<cmd> set nu!<CR>", { desc = "[T]oggle line [N]umber" })
vim.keymap.set("n", "<leader>trn", "<cmd> set rnu!<CR>", { desc = "[T]oggle [R]elative [N]umber" })


-- Toggling inline hints
vim.keymap.set("n", "<leader>ti", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "[T]oggle [I]nlay Hint" })

-- Keep visual mode on identation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Diagnostic related
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float { border = "rounded" }<CR>',
        { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = 'Open diagnostic [Q]uickfix list' })
