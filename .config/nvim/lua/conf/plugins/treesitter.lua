return {
        {
                "nvim-treesitter/nvim-treesitter",
                dependencies = {
                        {
                                'JoosepAlviste/nvim-ts-context-commentstring',
                                opts = {
                                        enable_autocmd = false,
                                },
                                init = function()
                                        vim.g.skip_ts_context_commentstring_module = true
                                end
                        },
                },
                build = ':TSUpdate',
                opts = {
                        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "luadoc", 'markdown', 'html' },
                        auto_install = true,
                        highlight = {
                                enable = true,
                                additional_vim_regex_highlighting = { 'ruby' },
                        },
                        indent = {
                                enable = true,
                                disable = { 'ruby' },
                        },
                },
                config = function(_, opts)
                        require('nvim-treesitter.install').prefer_git = true
                        require('nvim-treesitter.configs').setup(opts)
                end
        },
}
