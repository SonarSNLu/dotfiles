return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
		"jsonls",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
		"r-languageserver",
		"dockerls",
		"yamlls",
		"postgres_lsp",
		"sqlls",
		"clangd"
        "eslint",
		"rust_analyzer",
		"github_actions_language_server",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },	
      },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
--        "prettier", -- prettier formatter, https://www.youtube.com/watch?v=J37YeB63LVI vite+ better
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
--        "eslint_d",
		"sql-formatter", -- SQL formatter
		"sqlfluff", -- SQL linter & formatter
		"stylr",          -- R code formatter
		"lintr",          -- R code linter (optional)
		"clang-format",   -- C/C++ formatter (highly recommended)
		"cpplint",        -- C++ linter (optional)
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}

