--return {
--	"nvim-treesitter/nvim-treesitter",
--	lazy = false,
--	build = ":TSUpdate",
--	config = function()
--		local treesitter = require("nvim-treesitter")
--		treesitter.setup()
--
--		treesitter.install =
--		    { "bash", "c", "css", "cpp", "go", "html", "java", "javascript", "json", "lua", "markdown",
--			    "markdown_inline", "python", "rust", "tsx", "typescript", "r", "csv", "yaml", "latex",
--			    "typst" },
--
--		    vim.api.nvim_create_autocmd('FileType', {
--			    pattern = { "bash", "c", "css", "cpp", "go", "html", "java", "javascript", "json", "lua", "markdown", "markdown_inline", "python", "rust", "tsx", "typescript", "r", "csv", "yaml", "latex", "typst" },
--
--			    callback = function()
--				    vim.treesitter.start()
--				    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--			    end,
--		    })
--	end
--}

local ok, ts = pcall(require, "nvim-treesitter")
if not ok or type(ts.install) ~= "function" then
	return -- plugin missing, or old `master` branch without the new API
end

local langs = { "bash", "c", "css", "cpp", "go", "html", "java", "javascript", "json", "lua",
	"markdown", "markdown_inline", "python", "rust", "tsx", "typescript", "r", "csv", "yaml",
	"latex", "typst" }

ts.install(langs) -- async, skips parsers already installed

vim.api.nvim_create_autocmd("FileType", {
	pattern = langs,
	callback = function()
		if pcall(vim.treesitter.start) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
