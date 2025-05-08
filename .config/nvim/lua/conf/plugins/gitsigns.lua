return {
        {
                'lewis6991/gitsigns.nvim',
                dependencies = { "folke/which-key.nvim" },
                opts = {
                        current_line_blame_opts = {
                                virt_text_pos = "right_align",
                        },
                        signcolumn = false,
                        numhl = false,
                        on_attach = function(bufnr)
                                local gitsigns = require('gitsigns')

                                require("which-key").add({
                                        { '<leader>h',  group = 'Git [H]unk' },
                                        { '<leader>th', group = '[T]oggle [H]unk' },
                                }, { buffer = bufnr })

                                local function map(mode, lhs, rhs, opts)
                                        opts = opts or {}
                                        opts.buffer = bufnr

                                        vim.keymap.set(mode, lhs, rhs, opts)
                                end

                                map('n', ']c', function()
                                        if vim.wo.diff then
                                                vim.cmd.normal({ ']c', bang = true })
                                        else
                                                gitsigns.nav_hunk(
                                                        'next')
                                        end
                                end, { desc = "Jump to next hunk" })

                                map('n', '[c', function()
                                        if vim.wo.diff then
                                                vim.cmd.normal({ '[c', bang = true })
                                        else
                                                gitsigns.nav_hunk('prev')
                                        end
                                end, { desc = "Jump to prev hunk" })

                                map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "[S]tage" })
                                map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "[R]eset" })

                                map("v", "<leader>hs",
                                        function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                                        { desc = "[S]tage" })
                                map("v", "<leader>hr",
                                        function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                                        { desc = "[R]eset" })

                                map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "[S]tage buffer" })
                                map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "[U]ndo stage" })
                                map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "[R]eset buffer" })
                                map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "[P]review" })
                                map("n", "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<CR>",
                                        { desc = "[P]review [I]nline" })

                                map("n", "<leader>hb", function()
                                        gitsigns.blame_line({ full = true })
                                end, { desc = "[B]lame Line" })

                                map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "[D]iff this" })
                                map("n", "<leader>hD", '<cmd>Gitsigns diffthis \"~\"<CR>',
                                        { desc = "[D]iff this ~" })

                                map('n', '<leader>hQ', '<cmd>Gitsigns setqflist \"all\"<CR>',
                                        { desc = 'set all [Q]uicfix list' })
                                map('n', '<leader>hq', '<cmd>Gitsigns setqflist<CR>', { desc = 'set [Q]uicfix list' })

                                -- Toggles
                                map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>",
                                        { desc = "[T]oggle current [B]lame line" })
                                map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>",
                                        { desc = "[T]oggle [D]eleted" })
                                map("n", "<leader>tw", "<cmd>Gitsigns toggle_word_diff<CR>",
                                        { desc = "[T]oggle [W]ord diff" })

                                -- a few more specific toggles
                                map("n", "<leader>ths", "<cmd>Gitsigns toggle_signs<CR>",
                                        { desc = "[T]oggle [S]igns" })
                                map("n", "<leader>thl", "<cmd>Gitsigns toggle_linehl<CR>",
                                        { desc = "[T]oggle [L]ine highlights" })
                                map("n", "<leader>thn", "<cmd>Gitsigns toggle_numhl<CR>",
                                        { desc = "[T]oggle [N]um highlights" })

                                -- Text object
                                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                        end
                }

        }
}
