return {
        {
                "neovim/nvim-lspconfig",
                dependencies = {
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
                                opts = {
                                        automatic_installation = true,
                                },
                                dependencies = {
                                        "williamboman/mason.nvim",
                                },
                        },
                        "j-hui/fidget.nvim",
                        "b0o/schemastore.nvim",
                        {
                                "pmizio/typescript-tools.nvim",
                                config = false,
                                dependencies = { "nvim-lua/plenary.nvim" }
                        },
                        "folke/neodev.nvim",
                        "towolf/vim-helm",
                },
                config = function(_, opts)
                        vim.diagnostic.config({
                                virtual_text = {
                                        prefix = "●", -- Could be '●', '▎', 'x'
                                },
                        })

                        vim.api.nvim_create_autocmd("LspAttach", {
                                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                                callback = function(ev)
                                        local keymap = function(mode, lhs, rhs, desc)
                                                vim.keymap.set(mode, lhs, rhs,
                                                        { buffer = ev.buf, desc = 'LSP: ' .. desc })
                                        end

                                        keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
                                        keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
                                        keymap("n", "gI", "<cmd>Telescope lsp_implementations<cr>",
                                                "[G]oto [I]mplementation")
                                        -- Got to actual declaration, e.g., c header file
                                        keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "[G]oto [D]efinition")

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
                                                vim.diagnostic.enable(0)
                                        end, "[F]or[m]at")
                                end
                        })

                        local capabilities = vim.lsp.protocol.make_client_capabilities()

                        local cmp_lsp_status_ok, _ = pcall(require, "cmp_nvim_lsp")
                        if cmp_lsp_status_ok then
                                capabilities = vim.tbl_deep_extend('force', capabilities,
                                        require('cmp_nvim_lsp').default_capabilities())
                        end

                        local border = {
                                { "╭", "FloatBorder" },
                                { "─", "FloatBorder" },
                                { "╮", "FloatBorder" },
                                { "│", "FloatBorder" },
                                { "╯", "FloatBorder" },
                                { "─", "FloatBorder" },
                                { "╰", "FloatBorder" },
                                { "│", "FloatBorder" },
                        }
                        local handlers = {
                                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
                                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                                        border = border
                                }),
                        }

                        local servers = {
                                "clangd",
                                "marksman",
                                "groovyls",
                                "cmake",
                                "angularls",

                                {
                                        "helm_ls",
                                        {
                                                default_config = {
                                                        filetypes = { "helm", "helm.yaml", "helm.tmpl" }
                                                }
                                        }
                                },

                                {
                                        "yamlls",
                                        {
                                                settings = {
                                                        yaml = {
                                                                format = {
                                                                        enable = true
                                                                }
                                                        }
                                                }
                                        }
                                },


                                {
                                        "eslint",
                                        {
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
                                                on_attach = function(client, bufnr)
                                                        vim.keymap.set("n", "<leader>fe", "<cmd>EslintFixAll<cr>",
                                                                { desc = "[F]ormat all [E]slint issues", buffer = bufnr })
                                                end,

                                        }
                                },
                                {
                                        "lua_ls",
                                        {
                                                settings = {
                                                        Lua = {
                                                                hint = {
                                                                        enable = true,
                                                                }
                                                        }
                                                }
                                        }
                                },
                                {
                                        "jsonls",
                                        {
                                                init_options = {
                                                        provideFormatter = true,
                                                },
                                                settings = {
                                                        json = {
                                                                schemas = require("schemastore").json.schemas(),
                                                                validate = { enable = true },
                                                                format = { enable = true }
                                                        },
                                                },
                                                capabilities = {
                                                        textDocument = {
                                                                completion = {
                                                                        completionItem = {
                                                                                snippetSupport = true
                                                                        }
                                                                }
                                                        }
                                                }
                                        },
                                },
                                {
                                        "typescript-tools",
                                        {
                                                on_attach = function(_, bufnr)
                                                        vim.keymap.set("n", "<leader>fi",
                                                                "<cmd>TSToolsOrganizeImports<cr>",
                                                                { desc = "[F]ormat [I]mports", buffer = bufnr })
                                                end,
                                                handlers = {
                                                        ["textDocument/publishDiagnostics"] = require(
                                                                "typescript-tools.api").filter_diagnostics(
                                                                {
                                                                        -- 'This may be converted to an async function' diagnostics
                                                                        80006,
                                                                }
                                                        )
                                                },
                                                settings = {
                                                        tsserver_file_preferences = {
                                                                includeInlayParameterNameHints = "all",
                                                        },
                                                },
                                                root_dir = function() require('lspconfig.util').root_pattern('.git') end
                                        },
                                        require("typescript-tools")
                                },
                                {
                                        "pylsp",
                                        {
                                                settings = {
                                                        pylsp = {
                                                                plugins = {
                                                                        pycodestyle = {
                                                                                ignore = { 'W391' },
                                                                                maxLineLength = 100
                                                                        }
                                                                }
                                                        }
                                                }
                                        }

                                }
                        }


                        for _, server_spec in pairs(servers) do
                                local is_table_spec = type(server_spec) == "table"

                                local server = is_table_spec and server_spec[1] or server_spec
                                local server_config = is_table_spec and server_spec[2] or {}

                                local client = is_table_spec and server_spec[3] or require('lspconfig')[server]

                                local config = vim.tbl_deep_extend("force", {
                                        handlers = handlers,
                                        capabilities = capabilities
                                }, server_config)

                                client.setup(config)
                        end
                end
        }
}
