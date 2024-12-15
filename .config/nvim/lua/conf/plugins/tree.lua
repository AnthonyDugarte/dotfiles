return {
        {
                "nvim-tree/nvim-tree.lua",
                dependencies = {
                        "nvim-tree/nvim-web-devicons"
                },
                init = function()
                        vim.g.loaded_netrw = 1
                        vim.g.loaded_netrwPlugin = 1
                end,
                opts = {
                        view = {
                                relativenumber = true,
                                signcolumn = "no",
                        },
                },
                keys = {
                        {
                                "<leader>se",
                                "<cmd>NvimTreeToggle<cr>",
                                desc = "[S]earch [E]xplorer"
                        },
                        {
                                "<leader>sE",
                                "<cmd>NvimTreeFindFileToggle<cr>",
                                desc = "[S]earch [E]xplorer with focused file"
                        }
                }
        },
}
