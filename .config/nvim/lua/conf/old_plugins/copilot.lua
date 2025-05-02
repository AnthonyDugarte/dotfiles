return {
        {
                'zbirenbaum/copilot.lua',
                event = 'InsertEnter',
                cmd = 'Copilot',
                keys = {
                        {
                                "<leader>tg",
                                function() require("copilot.suggestion").toggle_auto_trigger() end,
                                desc = '[T]oggle [G]ithub Copilot'
                        }
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
                }
        }
}
