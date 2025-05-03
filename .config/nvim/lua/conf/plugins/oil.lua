return {

        {
                'stevearc/oil.nvim',
                ---@module 'oil'
                ---@type oil.SetupOpts
                opts = {},
                -- Optional dependencies
                dependencies = { { "echasnovski/mini.icons", opts = {} } },
                -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
                -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
                lazy = false,

                keys = {
                        { '<Tab>', function()
                                if vim.bo.filetype == 'oil' then
                                        require("oil.actions").close.callback()
                                else
                                        vim.cmd('Oil')
                                end
                        end }
                }
        }
}
