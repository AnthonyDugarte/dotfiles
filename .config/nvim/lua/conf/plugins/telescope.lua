local utils = require("conf.utils")

return {
        {
                'nvim-telescope/telescope.nvim',
                -- branch = '0.1.x',
                dependencies = {
                        'nvim-lua/plenary.nvim',
                        { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make' },
                        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
                },
                keys = {
                        { "<leader>ff",       "<cmd>Telescope find_files hidden=true<CR>", desc = "[S]earch [F]iles" },
                        { "<leader>fw",       "<cmd>Telescope grep_string<CR>",            desc = "[S]earch current [W]ord" },
                        { "<leader>fb", "<cmd>Telescope buffers<CR>",                desc = "[S]earch existing buffers" },
                        { "<leader>fg",       "<cmd>Telescope live_grep_args<CR>",         desc = "[S]earch by [G]rep" },
                        { "<leader>fr",       "<cmd>Telescope resume<cr>",                 desc = "[S]earch [R]esume" },
                        { "<leader>f.",       "<cmd>Telescope oldfiles<CR>",               desc = "[S]earch recent files" },
                        {
                                "<leader>fg",
                                function()
                                        require('telescope').extensions.live_grep_args.live_grep_args({
                                                default_text = table.concat(utils.get_selection())
                                        })
                                end,
                                mode = "v",
                                desc = "[S]earch by [G]rep"
                        }
                },
                cmd = "Telescope",
                lazy = false,
                opts = {
                        defaults = {
                                mappings          = {
                                        i = {
                                                ["<C-h>"] = "which_key"
                                        }
                                },
                        }
                },
                config = function (_, opts) 
                        require('telescope').setup(opts)

                        -- Better live grep, it allows you to use args alongs your search, e.g.:
                        -- "search" -g *.md
                        require("telescope").load_extension("live_grep_args")
                end

        }
}
