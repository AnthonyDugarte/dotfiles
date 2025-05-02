return {
        {
                "rebelot/kanagawa.nvim",
                lazy = false,
                priority = 1000,
                init = function()
                        -- vim.cmd.colorscheme 'kanagawa-dragon'
                end
        },
        {
                "catppuccin/nvim",
                name = "catppuccin",
                priority = 1000,
                init = function()
                        vim.cmd.colorscheme 'catppuccin-macchiato'
                end

        }
}
