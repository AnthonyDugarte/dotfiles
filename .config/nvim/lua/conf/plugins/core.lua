return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		event = "BufRead",
		opts = function()
			return {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			fast_wrap = {},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		opts = {},
		event = "VeryLazy",
	},
	{
		'nvim-telescope/telescope.nvim',
		-- branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make' },
			{ "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
			"nvim-telescope/telescope-file-browser.nvim",

		},
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

			vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<CR>",
				{ desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep_args<CR>",
				{ desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", "<cmd>Telescope oldfiles<CR>",
				{ desc = "[S]earch recent files" })
			vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<CR>",
				{ desc = "[ ] Search existing buffers" })
		end
	},
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
			},
			"saadparwaiz1/cmp_luasnip",
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'windwp/nvim-autopairs',
		},
		config = function()
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'

			require("luasnip.loaders.from_vscode").lazy_load()

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
				mapping = cmp.mapping.preset.insert {
					-- Select the [n]ext item
					['<C-n>'] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					['<C-p>'] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),

					['<C-y>'] = cmp.mapping.confirm { select = true },

					['<C-s>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					['<C-l>'] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { 'i', 's' }),
					['<C-h>'] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { 'i', 's' }),
				}
				,
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
				}, {
					{ name = 'buffer' }
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			}

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				opts = {
					ui = {
						icons = {
							package_pending = " ",
							package_installed = "󰄳 ",
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
			{ "j-hui/fidget.nvim", opts = {} },
			"b0o/schemastore.nvim",
			{
				"pmizio/typescript-tools.nvim",
				config = false,
				dependencies = {
					"nvim-lua/plenary.nvim"
				}
			},
		},
		config = function(_, opts)
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- Could be '●', '▎', 'x'
				},
			})


			-- vim.api.nvim_create_autocmd({ "LspAttach", "InsertEnter", "InsertLeave" }, {
			-- 	group = vim.api.nvim_create_augroup("InlayHintUserLspConfig", { clear = true }),
			-- 	callback = function(args)
			-- 		local enabled = args.event ~= "InsertEnter"
			-- 		vim.lsp.inlay_hint.enable(enabled, { bufnr = args.buf })
			-- 	end,
			-- });

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local keymap = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = 'LSP: ' .. desc })
					end

					keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
					keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", "[G]oto [R]eferences")
					keymap("n", "gI", "<cmd>Telescope lsp_implementations<cr>",
						"[G]oto [I]mplementation")
					-- Got to actual declaration, e.g., c header file
					keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "[G]oto [D]efinition")

					keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation")

					keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<cr>",
						"Type [D]efinition")

					keymap("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
						"S[i]gnature help")

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
					border =
					    border
				}),
			}

			local servers = {
				{
					"eslint",
					{
						settings = {
							format = { enable = true },
						},
						on_init = function(client)
							client.server_capabilities.documentFormattingProvider = true
						end,
						on_attach = function(client, bufnr)
							vim.keymap.set("n", "<leader>fe", "<cmd>EslintFixAll<cr>",
								{ desc = "[F]ormat all [E]slint issues", buffer = bufnr })
						end

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
	},
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
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true
		end,
		opts = {

			view = {
				relativenumber = true,
				signcolumn = "no",
			},
		}
	}
}
