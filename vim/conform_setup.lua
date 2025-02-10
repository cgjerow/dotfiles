require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		kotlin = { "ktlint" },
	},
	format_on_save = {
		timeout_ms = 3000,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
