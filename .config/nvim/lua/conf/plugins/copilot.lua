return {
        {
                "github/copilot.vim",
                config = function()
                        -- avoid using the tab key to accept a suggestion
                        -- vim.g.copilot_no_tab_map = true
                        --
                        -- vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
                        --         expr = true,
                        --         replace_keycodes = false,
                        --         desc = 'Accept suggestion',
                        -- })
                end,
                enabled = false,
        },
        {
                'zbirenbaum/copilot.lua',
                cmd = 'Copilot',
                event = 'InsertEnter',
                dependencies = {
                        "L3MON4D3/LuaSnip",
                        "hrsh7th/nvim-cmp",
                },
                opts = {
                        -- I don't find the panel useful.
                        panel = { enabled = false },
                        suggestion = {
                                auto_trigger = false,
                                -- Use alt to interact with Copilot.
                                keymap = {
                                        accept = "<M-l>",
                                        accept_word = false,
                                        accept_line = false,
                                        next = "<M-]>",
                                        prev = "<M-[>",
                                        dismiss = "<C-]>",
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
                enabled = true,
        }
}
