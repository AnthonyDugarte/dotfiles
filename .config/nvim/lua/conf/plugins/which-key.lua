return {
        {
                "folke/which-key.nvim",
                event = "VeryLazy",
                opts = {
                        spec = {
                                { '<leader>s',  group = '[S]earch' },
                                { '<leader>t',  group = '[T]oggle' },
                                { '<leader>tr', group = '[T]oggle [R]elative' },
                                { '<leader>c',  group = '[C]ode' },
                                { '<leader>r',  group = '[R]ename' },
                                { '<leader>f',  group = '[F]ormat' },
                                { '<leader>a',  group = '[A]vante' },

                                {
                                        "<leader>?",
                                        function() require("which-key").show({ global = false }); end,
                                        desc = "Keymaps"
                                },
                        }
                }
        }
}
