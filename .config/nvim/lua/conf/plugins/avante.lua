return {
        {
                "yetone/avante.nvim",
                -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
                -- ⚠️ must add this setting! ! !
                build = "make",
                event = "VeryLazy",
                version = false, -- Never set this value to "*"! Never!
                ---@module 'avante'
                ---@type avante.Config
                opts = {
                        provider = "gemini",
                        providers = {
                                gemini = {
                                        model = "gemini-2.5-pro",
                                        timeout = 30000, -- Timeout in milliseconds
                                        extra_request_body = {
                                                temperature = 0.75,
                                                max_tokens = 8192,
                                        },
                                },
                        },
                },
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "MunifTanjim/nui.nvim",
                        "nvim-telescope/telescope.nvim",
                        "hrsh7th/nvim-cmp",
                        -- "folke/snacks.nvim",     -- for input provider snacks
                        "echasnovski/mini.nvim",
                        "zbirenbaum/copilot.lua",
                        {
                                -- support for image pasting
                                "HakonHarnes/img-clip.nvim",
                                event = "VeryLazy",
                                opts = {
                                        -- recommended settings
                                        default = {
                                                embed_image_as_base64 = false,
                                                prompt_for_file_name = false,
                                                drag_and_drop = {
                                                        insert_mode = true,
                                                },
                                                -- required for Windows users
                                                use_absolute_path = true,
                                        },
                                },
                        },
                        {
                                'MeanderingProgrammer/render-markdown.nvim',
                                opts = {
                                        file_types = { "markdown", "Avante" },
                                },
                                ft = { "markdown", "Avante" },
                        },
                },
        }
}
