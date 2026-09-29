return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
		-- opts = {
		--         -- auto_install = true,
		--         -- highlight = {
		--         --         enable = true,
		--         -- },
		--         -- indent = {
		--         --         enable = true
		--         -- },
		-- },
		config = function(_)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
