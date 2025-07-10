return {
        {
                'echasnovski/mini.nvim',
                version = '*',
                dependencies = {
                        { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } }
                },
                config = function()
                        require('mini.comment').setup({
                                options = {
                                        custom_commentstring = function()
                                                return require('ts_context_commentstring').calculate_commentstring() or
                                                    vim.bo.commentstring
                                        end,
                                },
                        })
                        -- require('mini.surround').setup()
                        require('mini.pairs').setup()
                        require('mini.sessions').setup()
                        require('mini.starter').setup()
                        require('mini.icons').setup()
                end
        },
        {
                "kylechui/nvim-surround",
                version = "^3.0.0",
                event = "VeryLazy",
                opts = {},
        },
        -- {
        --         'numToStr/Comment.nvim',
        --         opts = {}
        -- }
}
