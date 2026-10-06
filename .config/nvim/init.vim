set notermguicolors
colorscheme vim
highlight Normal ctermbg=NONE guibg=NONE
highlight NormalNC ctermbg=NONE guibg=NONE

call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'saghen/blink.lib'
Plug 'saghen/blink.cmp', { 'do': 'cargo build --release' }



call plug#end()

lua << EOF
require('nvim-web-devicons').setup {
    default = true;
}

require('nvim-tree').setup {
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "right",
  },
}

require('blink.cmp').setup({
  -- 'default' for mappings similar to built-in completion, 'super-tab' for tab-completion
  keymap = { preset = 'default' },

  appearance = {
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = 'mono'
  },

  -- Default sources
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})


EOF

nnoremap <C-n> :NvimTreeToggle<CR>

