--https://github.com/stevearc/conform.nvim, :help conform for info

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		cpp = { "clang-format" },
		sql = { "sql-formatter" }, -- sqlfmt for more advanced use later

		r = { "air" }, -- Formatter for R (Tidyverse style)
		rust = { "rustfmt" },

		-- Standard Web App Configuration
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },

		-- markdown
		md = { "markdownlint-cli2" },
	},

	-- Automatically format code when saving the buffer
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
