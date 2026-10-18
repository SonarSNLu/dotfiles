require("conform").setup({
formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    cpp = { "clang-format" },
    sql = { "sql-formatter" },
   
    r = { "stylr" },        -- Formatter for R (Tidyverse style)
    rust = { "rustfmt" },    

    -- Standard Web App Configuration
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
  },

    -- Automatically format code when saving the buffer
   format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
