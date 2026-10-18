require('lspconfig').lua_ls.setup({
  root_dir = function(fname)
    local util = require('lspconfig.util')
    local root = util.root_pattern('.luarc.json', '.git')(fname)
    if root and root ~= vim.env.HOME then
      return root
    end
    return vim.fn.getcwd()
  end,
})

