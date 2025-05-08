return {
        {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
                opts = {
                        ui = {
                                icons = {
                                        package_pending     = " ",
                                        package_installed   = "󰄳 ",
                                        package_uninstalled = " 󰚌",
                                },
                        },
                },
        },
        {
                "williamboman/mason-lspconfig.nvim",
                opts = { automatic_installation = true },
                dependencies = {
                        "williamboman/mason.nvim",
                },
        },
        {
                "neovim/nvim-lspconfig",
                dependencies = {
                        "williamboman/mason.nvim",
                        "williamboman/mason-lspconfig.nvim",
                        "j-hui/fidget.nvim",
                        "b0o/schemastore.nvim",
                        "folke/neodev.nvim",
                        "towolf/vim-helm",
                        "hrsh7th/nvim-cmp",
                },
                config = function(_, opts)
                        vim.diagnostic.config({
                                virtual_text = {
                                        prefix = "●",
                                },
                                severity_sort = true,
                                signs = {
                                        text = {
                                                [vim.diagnostic.severity.ERROR] = "",
                                                [vim.diagnostic.severity.WARN] = "",
                                                [vim.diagnostic.severity.HINT] = "",
                                                [vim.diagnostic.severity.INFO] = "",
                                        },
                                },
                                float = {
                                        -- focusable = false,
                                        style = "minimal",
                                        border = "single",
                                        source = true,
                                        header = "",
                                        prefix = "",
                                        suffix = "",
                                },
                        })

                        -- Improve LSPs UI {{{
                        local icons = {
                                Class = " ",
                                Color = " ",
                                Constant = " ",
                                Constructor = " ",
                                Enum = " ",
                                EnumMember = " ",
                                Event = " ",
                                Field = " ",
                                File = " ",
                                Folder = " ",
                                Function = "󰊕 ",
                                Interface = " ",
                                Keyword = " ",
                                Method = "ƒ ",
                                Module = "󰏗 ",
                                Property = " ",
                                Snippet = " ",
                                Struct = " ",
                                Text = " ",
                                Unit = " ",
                                Value = " ",
                                Variable = " ",
                        }

                        local completion_kinds = vim.lsp.protocol.CompletionItemKind
                        for i, kind in ipairs(completion_kinds) do
                                completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
                        end
                        -- }}}

                        local cmp_lsp_status_ok, _ = pcall(require, "cmp_nvim_lsp")
                        if cmp_lsp_status_ok then
                                vim.lsp.config('*', {
                                        capabilities = require('cmp_nvim_lsp').default_capabilities()
                                })
                        end


                        vim.api.nvim_create_autocmd("LspAttach", {
                                callback = function(ev)
                                        local keymap = function(mode, lhs, rhs, desc)
                                                vim.keymap.set(mode, lhs, rhs,
                                                        { buffer = ev.buf, desc = 'LSP: ' .. desc })
                                        end

                                        keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
                                        keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
                                        keymap("n", "gI", "<cmd>Telescope lsp_implementations<cr>",
                                                "[G]oto kI]mplementation")
                                        -- Got to actual declaration, e.g., c header file
                                        keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",
                                                "[G]oto [D]efinition")

                                        keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<cr>",
                                                "Type [D]efinition")

                                        -- keymap("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                                        --         "S[i]gnature help")

                                        keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", "[R]e[n]ame")
                                        keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>",
                                                "[C]ode [A]ction")

                                        keymap("n", "<leader>fm", function()
                                                vim.lsp.buf.format({
                                                        async = false,
                                                        filter = function(client)
                                                                return client.name ~=
                                                                    "typescript-tools" -- and client.name ~= "lua_ls"
                                                        end,
                                                })

                                                -- in lua, diagnostics are lost on formatting,
                                                -- in theory it should not affect other clients
                                                -- ref: https://www.reddit.com/r/neovim/comments/15dfx4g/help_lsp_diagnostics_are_not_being_displayed/
                                                vim.diagnostic.enable(true, { bufnr = 0 })
                                        end, "[F]or[m]at")
                                end
                        })

                        local servers = {
                                "clangd",
                                "marksman",
                                "groovyls",
                                "cmake",
                                "angularls",
                                "kotlin_language_server",
                                "helm_ls",
                                "yamlls",
                                "lua_ls",
                                "jsonls",
                                "pylsp",
                                "gopls"
                        }

                        for _, server in pairs(servers) do
                                vim.lsp.enable(server)
                        end

                        require('lspconfig').eslint.setup({
                                settings = {
                                        format = { enable = true },
                                        experimental = {
                                                useFlatConfig = false
                                        },
                                        workingDirectory = {
                                                mode = "auto"
                                        }
                                },
                                on_init = function(client)
                                        client.server_capabilities.documentFormattingProvider = true
                                end,
                                on_attach = function(_, bufnr)
                                        vim.keymap.set("n", "<leader>fe", "<cmd>EslintFixAll<cr>",
                                                { desc = "[F]ormat all [E]slint issues", buffer = bufnr })
                                end,

                        })
                end
        },

        {
                "pmizio/typescript-tools.nvim",
                dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
                opts = {},
                config = function()
                        require('typescript-tools').setup({
                                on_attach = function(_, bufnr)
                                        vim.keymap.set("n", "<leader>fi",
                                                "<cmd>TSToolsOrganizeImports<cr>",
                                                { desc = "[F]ormat [I]mports", buffer = bufnr })
                                end,
                                handlers = {
                                        ["textDocument/publishDiagnostics"] = require(
                                                "typescript-tools.api").filter_diagnostics(
                                                {
                                                        -- 'This may be converted to an async function'
                                                        80006,
                                                }
                                        )
                                },
                                settings = {
                                        tsserver_file_preferences = {
                                                includeInlayParameterNameHints = "all",
                                        },
                                },
                                root_dir = require('lspconfig.util').root_pattern(
                                        'pnpm-workspace.yaml',
                                        'tsconfig.json',
                                        'jsconfig.json',
                                        'package.json',
                                        '.git')
                        })
                end
        },
}
