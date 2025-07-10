return {

        {
                'stevearc/oil.nvim',
                ---@module 'oil'
                ---@type oil.SetupOpts
                opts = {},

                lazy = false,

                keys = {
                        { '-', function()
                                if vim.bo.filetype == 'oil' then
                                        require("oil.actions").close.callback()
                                else
                                        vim.cmd('Oil')
                                end
                        end }
                },

                dependencies = { "echasnovski/mini.nvim" },
        }
}
