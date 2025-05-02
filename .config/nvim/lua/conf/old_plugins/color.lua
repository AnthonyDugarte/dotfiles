return {
        {
                "folke/tokyonight.nvim",
                lazy = false,
                priority = 1000,
                -- enabled = false,
                init = function()
                        -- vim.cmd.colorscheme 'tokyonight'
                end,
        },

        {
                "Mofiqul/vscode.nvim",
                lazy = false,
                priority = 1000,
                -- enabled = false,
                init = function()
                        -- vim.cmd.colorscheme 'vscode'
                end,
        },

        {
                "ashen-org/ashen.nvim",
                -- tag = "*",
                lazy = false,
                priority = 1000,
                init = function()
                        -- vim.cmd.colorscheme 'ashen'
                end
        },

        {
                "rebelot/kanagawa.nvim",
                lazy = false,
                priority = 1000,
                init = function()
                        vim.cmd.colorscheme 'kanagawa-dragon'
                end


        },
}
