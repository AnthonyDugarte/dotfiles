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
                        { "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", desc = "[S]earch [F]iles" },
                        { "<leader>fw", "<cmd>Telescope grep_string<CR>",            desc = "[S]earch current [W]ord" },
                        { "<leader>fb", "<cmd>Telescope buffers<CR>",                desc = "[S]earch existing buffers" },
                        { "<leader>fg", "<cmd>Telescope live_grep_args<CR>",         desc = "[S]earch by [G]rep" },
                        { "<leader>fr", "<cmd>Telescope resume<cr>",                 desc = "[S]earch [R]esume" },
                        { "<leader>f.", "<cmd>Telescope oldfiles<CR>",               desc = "[S]earch recent files" },
                        {
                                "<leader>fg",
                                function()
                                        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
                                        -- require('telescope').extensions.live_grep_args.live_grep_args({
                                        --         default_text = table.concat(utils.get_selection())
                                        -- })
                                end,
                                mode = "v",
                                desc = "[S]earch by [G]rep"
                        }
                },
                cmd = "Telescope",
                lazy = false,
                opts = function(_, opts)
                        local lga_actions = require("telescope-live-grep-args.actions")

                        return vim.tbl_deep_extend("force", opts, {
                                defaults = {
                                        mappings = {
                                                i = {
                                                        ["<C-h>"] = "which_key"
                                                }
                                        },
                                },
                                extensions = {
                                        live_grep_args = {
                                                auto_quoting = true,
                                                mappings = {
                                                        i = {
                                                                ["<C-a>"] = lga_actions.quote_prompt(),
                                                                ["<C-s>"] = lga_actions.quote_prompt({
                                                                        postfix =
                                                                        " --iglob "
                                                                }),
                                                                ["<C-b>"] = lga_actions.quote_prompt({
                                                                        postfix =
                                                                        " --iglob package.json"
                                                                }),
                                                        },
                                                },
                                        }
                                }
                        })
                end,
                config = function(_, opts)
                        require('telescope').setup(opts)

                        -- Better live grep, it allows you to use args alongs your search, e.g.:
                        -- "search" -g *.md
                        require("telescope").load_extension("live_grep_args")
                end

        }
}
