return {
        {
                "folke/tokyonight.nvim",
                lazy = false,
                priority = 1000,
                enabled = false,
                init = function()
                        vim.cmd.colorscheme 'tokyonight'
                end,
        },

        {
                "Mofiqul/vscode.nvim",
                lazy = false,
                priority = 1000,
                -- enabled = false,
                init = function()
                        vim.cmd.colorscheme 'vscode'
                end,
        }
}
