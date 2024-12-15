return {
        {
                'nvim-telescope/telescope.nvim',
                -- branch = '0.1.x',
                dependencies = {
                        'nvim-lua/plenary.nvim',
                        { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make' },
                        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
                        "nvim-telescope/telescope-file-browser.nvim",
                },
                keys = {
                        { "<leader>sf",       "<cmd>Telescope find_files hidden=true<CR>", { desc = "[S]earch [F]iles" } },
                        { "<leader>sw",       "<cmd>Telescope grep_string<CR>",            { desc = "[S]earch current [W]ord" } },
                        { "<leader>sg",       "<cmd>Telescope live_grep_args<CR>",         { desc = "[S]earch by [G]rep" } },
                        { "<leader>sr",       "<cmd>Telescope resume<cr>",                 { desc = "[S]earch [R]esume" } },
                        { "<leader>s.",       "<cmd>Telescope oldfiles<CR>",               { desc = "[S]earch recent files" } },
                        { "<leader><leader>", "<cmd>Telescope buffers<CR>",                { desc = "[S]earch existing buffers" } },
                },
                cmd = "Telescope",
                config = function()
                        require('telescope').setup({
                                defaults = {
                                        prompt_prefix = "   ",
                                        selection_caret = "  ",
                                        entry_prefix = "  ",
                                        mappings = {
                                                i = {
                                                        ["<C-h>"] = "which_key"
                                                }
                                        },
                                        layout_config = {
                                                prompt_position = "top",
                                        },
                                        path_display = {
                                                "filename_first",
                                        },
                                        vimgrep_arguments = {
                                                "rg",
                                                "--color=never",
                                                "--no-heading",
                                                "--with-filename",
                                                "--line-number",
                                                "--column",
                                                "--smart-case",
                                                "--hidden"
                                        }
                                },
                                extensions = {
                                        file_browser = {
                                                hijack_netrw = true,
                                        }
                                }
                        })
                        -- Better live grep, it allows you to use args alongs your search, e.g.:
                        -- "search" -g *.md
                        require("telescope").load_extension "live_grep_args"
                        require("telescope").load_extension "file_browser"
                end
        }
}
