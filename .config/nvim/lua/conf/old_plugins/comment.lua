return {
        {
                -- TODO: Use native comment functionality
                "numToStr/Comment.nvim",
                dependencies = {
                        "JoosepAlviste/nvim-ts-context-commentstring",
                },
                event = "BufRead",
                opts = function(_, opts)
                        opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
                end,
        },
}
