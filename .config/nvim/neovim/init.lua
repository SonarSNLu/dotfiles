-- bread's neovim config
-- keymaps are in lua/config/mappings.lua
-- install a patched font & ensure your terminal supports glyphs
-- enjoy :D

-- auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
	vim.cmd('silent !curl -fLo ' ..
	data_dir ..
	'/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.o.runtimepath = vim.o.runtimepath
	vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local vim         = vim
local Plug        = vim.fn['plug#']

--vim.g.barbar_auto_setup = false
vim.o.showtabline = 0
vim.o.laststatus  = 0

vim.g.start_time  = vim.fn.reltime()
vim.loader.enable() --  SPEEEEEEEEEEED 
vim.call('plug#begin')

Plug('folke/snacks.nvim', { ['as'] = 'snacks' })   -- feature bundle https://github.com/folke/snacks.nvim, enable feature when sure 0 conflict
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' }) --colorscheme
Plug('craftzdog/solarized-osaka.nvim', { ['as'] = 'solarized-osaka' })
Plug('bluz71/vim-moonfly-colors', { ['as'] = 'moonfly' })
Plug('ellisonleao/gruvbox.nvim', { ['as'] = 'gruvbox' }) --colorscheme 2
Plug('uZer/pywal16.nvim', { ['as'] = 'pywal16' })        --or, pywal colorscheme
Plug('nvim-lualine/lualine.nvim')                        --statusline
Plug('nvim-tree/nvim-web-devicons')                      --pretty icons
Plug('folke/which-key.nvim')                             --mappings popup
Plug('romgrk/barbar.nvim')                               --bufferline
Plug('goolord/alpha-nvim')                               --pretty startup
Plug('nhattVim/alpha-ascii.nvim')                        --ascii headers for alpha
Plug('nvim-treesitter/nvim-treesitter')                  --improved syntax
Plug('mfussenegger/nvim-lint')                           --async linter
Plug('nvim-tree/nvim-tree.lua')                          --file explorer
Plug('windwp/nvim-autopairs')                            --autopairs
Plug('lewis6991/gitsigns.nvim')                          --git
Plug('numToStr/Comment.nvim')                            --easier comments
Plug('catgoose/nvim-colorizer.lua')                      --color highlight
Plug('ibhagwan/fzf-lua')                                 --fuzzy finder and grep
Plug('numToStr/FTerm.nvim')                              --floating terminal
Plug('ron-rs/ron.vim')                                   --ron syntax highlighting
Plug('MeanderingProgrammer/render-markdown.nvim')        --render md inline
Plug('emmanueltouzery/decisive.nvim')                    --view csv files
Plug('folke/twilight.nvim')                              --surrounding dim
Plug('stevearc/conform.nvim')                            -- formatter plugin, for vite+
Plug('neovim/nvim-lspconfig')                            --lsp server configs (server installed separately, e.g. lua-language-server) https://luals.github.io/
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('WhoIsSethDaniel/mason-tool-installer.nvim')
Plug('hrsh7th/nvim-cmp')     --completion engine (popup menu). config goes AFTER plug#end
Plug('hrsh7th/cmp-nvim-lsp') --cmp source: suggestions from LSP (no LSP running = no results)
Plug('hrsh7th/cmp-buffer')   --cmp source: words from open buffers
Plug('hrsh7th/cmp-path')     --cmp source: file paths
-- TROUBLESHOOT completion: :checkhealth vim.lsp (is a server attached?)
--   :lua print(vim.inspect(require('cmp').get_config().sources))  (are sources loaded?)
--   :PlugStatus (are all plugins installed?)  :messages (setup errors)

vim.call('plug#end')

-- LSP setup
require('plugins.lsp.lsp')

-- Nvim tree setup
require('nvim-tree').setup({
	sort_by = 'case_sensitive',
	view = {
		width = 30,
		side = 'right',
	},
})


-- for bat ascii
require('alpha_ascii').setup({
	header = 'bat', -- /ASCII file's name without .lua
	use_default = true, -- keep the plugin's own headers too (set false for only yours)
	user_path = vim.fn.fnamemodify(vim.env.MYVIMRC, ':p:h') .. '/ascii',
})

-- move config and plugin config to alternate files
require("config.theme")
require("config.mappings")
require("config.options")
require("config.autocmd")

require('plugins.alpha_config')
-- require("plugins.autopairs")
require("plugins.barbar")
require("plugins.colorizer")
require("plugins.colorscheme")
require("plugins.comment")
-- require("plugins.fterm")
-- require("plugins.fzf-lua")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.nvim-lint")
-- require("plugins.nvim-tree")
require("plugins.render-markdown")
-- require("plugins.treesitter")
-- require("plugins.twilight")
-- require("plugins.which-key")
require("plugins.conform")

vim.defer_fn(function()
	--defer non-essential configs,
	--purely for experimental purposes:
	--this only makes a difference of +-10ms on initial startup
	require("plugins.cmp") -- autocompletion
	require("plugins.autopairs")
	require("plugins.fterm")
	require("plugins.fzf-lua")
	require("plugins.nvim-tree")
	require("plugins.treesitter")
	require("plugins.twilight")
	require("plugins.which-key")
end, 100)

-- Update the bottom of your init.lua to run the setup function for barbar (no flashes at startup)
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.fn['plug#load']('barbar.nvim')

		-- Call the configuration function after loading the code
		if _G.setup_barbar then
			_G.setup_barbar()
		end
	end
})



-- Using vim.schedule forces Neovim to wait until the entire editor window is open and stable
-- before it attempts to read your theme files, just load_theme() if not needed
vim.schedule(function()
	load_theme()
end)
