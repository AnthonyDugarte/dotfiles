return {
        {
                'zbirenbaum/copilot.lua',
                cmd = 'Copilot',
                event = 'InsertEnter',
                dependencies = {
                        "L3MON4D3/LuaSnip",
                        "hrsh7th/nvim-cmp",
                },
                opts = {
                        panel = { enabled = false },

                        suggestion = {
                                auto_trigger = false,
                                keymap = {
                                        accept      = "<M-l>",
                                        accept_word = false,
                                        accept_line = false,
                                        next        = "<M-]>",
                                        prev        = "<M-[>",
                                        dismiss     = "<M-e>",
                                }
                        },
                        filetypes = {
                                markdown = true,
                                sh = function()
                                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                                                -- disable for .env files
                                                return false
                                        end
                                        return true
                                end,
                        },
                },
                config = function(_, opts)
                        local suggestions = require("copilot.suggestion")

                        vim.keymap.set('n', "<leader>tg", function() suggestions.toggle_auto_trigger() end,
                                { desc = '[T]oggle [G]ithub Copilot' })

                        require("copilot").setup(opts)
                end
        }
}
