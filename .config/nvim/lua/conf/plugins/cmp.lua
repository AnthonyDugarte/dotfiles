return {
        {
                "hrsh7th/nvim-cmp",
                dependencies = {
                        {
                                "L3MON4D3/LuaSnip",
                                version = "v2.*",
                                build = "make install_jsregexp",
                                dependencies = {
                                        "rafamadriz/friendly-snippets",
                                },
                                opts = {},
                                config = function(_, opts)
                                        local luasnip = require 'luasnip'

                                        require("luasnip.loaders.from_vscode").lazy_load()

                                        -- HACK: Cancel the snippet session when leaving insert mode.
                                        vim.api.nvim_create_autocmd('ModeChanged', {
                                                group = vim.api.nvim_create_augroup('UnlinkSnippetOnModeChange',
                                                        { clear = true }),
                                                pattern = { 's:n', 'i:*' },
                                                callback = function(event)
                                                        if
                                                            luasnip.session
                                                            and luasnip.session.current_nodes[event.buf]
                                                            and not luasnip.session.jump_active
                                                        then
                                                                luasnip.unlink_current()
                                                        end
                                                end,
                                        })

                                        luasnip.setup(opts)
                                end
                        },
                        "saadparwaiz1/cmp_luasnip",
                        'hrsh7th/cmp-nvim-lsp',
                        'hrsh7th/cmp-buffer',
                        'hrsh7th/cmp-path',
                        'hrsh7th/cmp-cmdline',
                        'hrsh7th/cmp-nvim-lsp-signature-help',
                        'windwp/nvim-autopairs',
                },
                config = function()
                        local luasnip = require 'luasnip'
                        local cmp = require 'cmp'

                        local autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
                        if autopairs_ok then
                                cmp.event:on(
                                        'confirm_done',
                                        cmp_autopairs.on_confirm_done()
                                )
                        end

                        cmp.setup {
                                snippet = {
                                        expand = function(args)
                                                luasnip.lsp_expand(args.body)
                                        end
                                },
                                preselect = cmp.PreselectMode.None,
                                window = {
                                        completion = cmp.config.window.bordered(),
                                        documentation = cmp.config.window.bordered(),
                                },
                                view = {
                                        docs = {
                                                auto_open = true
                                        },
                                },
                                completion = {
                                        autocomplete = false
                                },
                                mapping = cmp.mapping.preset.insert {
                                        -- Scroll the documentation window [b]ack / [f]orward
                                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                                        ['<C-f>'] = cmp.mapping.scroll_docs(4),

                                        ['<CR>'] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        if luasnip.expandable() then
                                                                return luasnip.expand()
                                                                -- only confirm if an option was actually picked
                                                        elseif cmp.get_selected_entry() then
                                                                return cmp.confirm({
                                                                        select = true,
                                                                        behavior = cmp.ConfirmBehavior.Replace
                                                                })
                                                        end
                                                end

                                                fallback()
                                        end),

                                        ['<C-Space>'] = cmp.mapping.complete(),
                                        ['<C-e>'] = cmp.mapping.abort(),

                                        ['<Tab>'] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        cmp.select_next_item()
                                                elseif luasnip.expand_or_locally_jumpable() then
                                                        luasnip.expand_or_jump()
                                                else
                                                        fallback()
                                                end
                                        end, { 'i', 's' }),
                                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        cmp.select_prev_item()
                                                elseif luasnip.expand_or_locally_jumpable(-1) then
                                                        luasnip.jump(-1)
                                                else
                                                        fallback()
                                                end
                                        end, { 'i', 's' }),

                                        ['<C-d>'] = function()
                                                if cmp.visible_docs() then
                                                        cmp.close_docs()
                                                else
                                                        cmp.open_docs()
                                                end
                                        end,
                                }
                                ,
                                sources = cmp.config.sources({
                                        { name = 'nvim_lsp' },
                                        { name = 'buffer' },
                                        { name = 'luasnip' },
                                        { name = 'nvim_lsp_signature_help' },
                                }, {
                                        { name = 'path' },
                                }),
                        }


                        local cmdlineOpts = {
                                mapping = cmp.mapping.preset.cmdline({
                                        ['<CR>'] = {
                                                c = function(default)
                                                        if cmp.visible() and cmp.get_selected_entry() then
                                                                return cmp.confirm({ select = true })
                                                        end

                                                        default()
                                                end,
                                        },
                                }),
                                preselect = cmp.PreselectMode.None,
                                completion = {
                                        autocomplete = { cmp.TriggerEvent.TextChanged }
                                },
                        }
                        cmp.setup.cmdline({ "/", "?" },
                                vim.tbl_deep_extend("force", cmdlineOpts, {
                                        sources = {
                                                { name = "buffer" },
                                        },
                                }))

                        cmp.setup.cmdline(":",
                                vim.tbl_deep_extend("force", cmdlineOpts, {
                                        sources = cmp.config.sources({
                                                { name = "path" },
                                        }, {
                                                { name = "cmdline" },
                                        }),
                                        matching = { disallow_symbol_nonprefix_matching = false }
                                }))
                end
        }
}
