return {
        {
                "hrsh7th/nvim-cmp",
                dependencies = {
                        "L3MON4D3/LuaSnip",
                        "saadparwaiz1/cmp_luasnip",
                        'hrsh7th/cmp-nvim-lsp',
                        'hrsh7th/cmp-buffer',
                        'hrsh7th/cmp-path',
                        'hrsh7th/cmp-cmdline',
                        'hrsh7th/cmp-nvim-lsp-signature-help',
                        -- 'windwp/nvim-autopairs',
                        {
                                "zbirenbaum/copilot-cmp",
                                dependencies = { "zbirenbaum/copilot.lua" },
                                opts = {}
                        },
                },

                opts = function()
                        local luasnip = require 'luasnip'
                        local cmp = require 'cmp'

                        return {
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
                                        -- -- disable autocomplete on startup
                                        -- autocomplete = false
                                },
                                mapping = cmp.mapping.preset.insert {
                                        -- Scroll the documentation window [b]ack / [f]orward
                                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                                        ['<C-f>'] = cmp.mapping.scroll_docs(4),

                                        ['<CR>'] = cmp.mapping(function(fallback)
                                                if cmp.visible() and cmp.get_selected_entry() then
                                                        return cmp.confirm({
                                                                select = true,
                                                                behavior = cmp.ConfirmBehavior.Replace
                                                        })
                                                end

                                                fallback()
                                        end),

                                        ['<C-Space>'] = cmp.mapping.complete(),
                                        ['<C-e>'] = cmp.mapping.abort(),

                                        ['<C-n>'] = cmp.mapping(function(fallback)
                                                if cmp.visible() then
                                                        cmp.select_next_item()
                                                elseif luasnip.expand_or_locally_jumpable() then
                                                        luasnip.expand_or_jump()
                                                else
                                                        fallback()
                                                end
                                        end, { 'i', 's' }),
                                        ['<C-p>'] = cmp.mapping(function(fallback)
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
                                },
                                sources = {
                                        { name = 'copilot',                 group_index = 2 },
                                        { name = 'nvim_lsp',                group_index = 2 },
                                        { name = 'path',                    group_index = 2 },
                                        { name = 'buffer',                  group_index = 2 },
                                        { name = 'luasnip',                 group_index = 2 },
                                        { name = 'nvim_lsp_signature_help', group_index = 2 },
                                },

                                sorting = {
                                        priority_weight = 2,
                                        comparators = {
                                                require("copilot_cmp.comparators").prioritize,

                                                -- Below is the default comparitor list and order for nvim-cmp
                                                cmp.config.compare.offset,
                                                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                                                cmp.config.compare.exact,
                                                cmp.config.compare.score,
                                                cmp.config.compare.recently_used,
                                                cmp.config.compare.locality,
                                                cmp.config.compare.kind,
                                                cmp.config.compare.sort_text,
                                                cmp.config.compare.length,
                                                cmp.config.compare.order,
                                        },
                                },

                        }
                end,
                config = function(_, opts)
                        local cmp = require 'cmp'

                        -- local autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
                        -- if autopairs_ok then
                        --         cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
                        -- end

                        cmp.setup(opts)

                        local cmdlineOpts = {
                                mapping = cmp.mapping.preset.cmdline({
                                        ['<CR>'] = {
                                                c = function(default)
                                                        if cmp.visible() and cmp.get_selected_entry() then
                                                                cmp.confirm({ select = true })
                                                        else
                                                                default()
                                                        end
                                                end,
                                        },
                                }),
                                preselect = cmp.PreselectMode.None,
                                completion = { autocomplete = { cmp.TriggerEvent.TextChanged } },
                        }

                        cmp.setup.cmdline({ "/", "?" },
                                vim.tbl_deep_extend("force", cmdlineOpts, {
                                        sources = { { name = "buffer" } },
                                }))

                        cmp.setup.cmdline(":",
                                vim.tbl_deep_extend("force", cmdlineOpts, {
                                        sources = cmp.config.sources(
                                                { { name = "path" } },
                                                { { name = "cmdline" } }
                                        ),
                                        matching = { disallow_symbol_nonprefix_matching = false }
                                }))

                        -- from https://github.com/hrsh7th/nvim-cmp/issues/261#issuecomment-1851137665
                        vim.keymap.set('n', "<leader>tc", function()
                                        local current_setting = cmp.get_config().completion.autocomplete

                                        if current_setting and #current_setting > 0 then
                                                cmp.setup({ completion = { autocomplete = false } })
                                                vim.notify('[cmp] Autocomplete disabled')
                                        else
                                                cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
                                                vim.notify('[cmp] Autocomplete enabled')
                                        end
                                end,
                                { desc = '[T]oggle auto-trigger [C]ompletition' })
                end
        },

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
}
