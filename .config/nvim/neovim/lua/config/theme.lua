-- theme choice is saved in a file for persistence on restart
-- could use a plugin instead, but hey, this is more fun
-- lualine theme gets stored separately due to possible naming differences

local theme_file = vim.fn.stdpath("config") .. "/lua/config/saved_theme"

-- dim_eob Change ~ color 
local function dim_eob()
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#1a1a1a", bg = "NONE" })
end 

dim_eob()
vim.api.nvim_create_autocmd("ColorScheme", { callback = dim_eob })

-- [Old version of _G.load_theme incase of emergency]
-- _G.load_theme = function()
--    local file = io.open(theme_file, "r")
--	if file then
--		vim.cmd("colorscheme " .. file:read("*l"))
--		require("lualine").setup({ options = { theme = file:read("*l") } })
--	file:close() end
--end

--- Load the bat ascii first so color not overwritten by creating seperate highlightgroup for bat.lua 
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local ascii = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h") .. "/ascii/bat.lua"
    pcall(dofile, ascii)   -- re-creates the I2A* highlight groups
  end,
})

_G.load_theme = function()
	pcall(require, "plugins.colorscheme")   -- make sure colorscheme plugin load first so the theme works
    local file = io.open(theme_file, "r")
    if file then
        local colorscheme = file:read("*l")
        local lualine_theme = file:read("*l")
        file:close()

        -- Apply the core theme using native Vim runtime paths first
        if colorscheme then
            pcall(vim.cmd, "colorscheme " .. colorscheme)
        end

        -- Initialize lualine status bars only after the colorscheme is stable
        if lualine_theme then
            pcall(function()
                require("lualine").setup({ options = { theme = lualine_theme } })
            end)
        end
    end
end

local themes = { --add more themes here, if installed ; to switch :colorscheme catppuccin-macchiato
    { "catppuccin-mocha",     "catppuccin-mocha" },
    { "catppuccin-macchiato", "catppuccin-macchiato" },
    { "catppuccin-frappe",    "catppuccin-frappe" },
    {"moonfly", 	"moonfly"},
    { "catppuccin-latte",     "catppuccin-latte" },
    { "solarized-osaka",	  "solarized-osaka" },
    { "pywal16",              "pywal16" },
    { "gruvbox", "gruvbox" },
    { "pywal16", "pywal16" },
}

local current_theme_index = 1

_G.switch_theme = function()
	current_theme_index = current_theme_index % #themes + 1
	local colorscheme, lualine = unpack(themes[current_theme_index])
	vim.cmd("colorscheme " .. colorscheme)
	require("lualine").setup({ options = { theme = lualine } })
	local file = io.open(theme_file, "w")
	if file then file:write(colorscheme .. "\n" .. lualine) file:close() end
end
