-- catppuccin + gruvbox colorscheme configuration

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
        styles = {
           sidebars = "transparent",
           floats = "transparent",
        },
		term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.25, -- percentage of the shade to apply to the inactive window
		},
		lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
		    },
		},
		color_overrides = {
		 crust  = "#000000",   -- darkest layer
		 mauve  = "#c4a7e7",   -- keywords
		 green  = "#a6e3a1",   -- strings
		 

		},
		custom_highlights = {},
		auto_integrations = true,
		integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = false,
				mini = {
				enabled = true,
				indentscope_color = "",
				}
		},
})

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

require("solarized-osaka").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "dark", -- The default dark style. Set to `vivid` for a higher-contrast variant that stays readable in bright environments
  light_style = "light", -- The theme is used when the background is set to light
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = false, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent", -- style for sidebars, see below
    floats = "transparent", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  vivid_brightness = 0.3, -- Adjusts how far the **Vivid** style brightens text colors. Number between 0 and 1, from the default palette to white
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
 	dim_inactive = { 	-- dims the background color of inactive window
        enabled = true,        
		shade = "dark",
        percentage = 0.25, -- percentage of the shade to apply to the inactive window
		}, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})



-- if you want to get rid of toggling and just set one scheme, you can set here
-- local colorscheme = "catppuccin"
-- vim.cmd('silent! colorscheme catppuccin')
-- more theme look here https://vimcolorschemes.com/i/trending
