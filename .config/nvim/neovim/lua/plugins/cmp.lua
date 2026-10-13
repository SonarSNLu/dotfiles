local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args) vim.snippet.expand(args.body) end,   -- Neovim 0.10+
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item() else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources(
    { { name = "nvim_lsp" } },
    { { name = "buffer" }, { name = "path" } }
  ),
})

-- LSP (needs Neovim 0.11+ and the server installed on the system)
vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
vim.lsp.enable({ "lua_ls" })
