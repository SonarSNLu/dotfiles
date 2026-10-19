-- require'luasnip'.filetype_extend("vue", {"rails"})

require("luasnip.loaders.from_vscode").load {
	include = {
		"all", -- global snippets (licenses, lorem, etc.)
		"python", "pydoc",
		"rust", "rustdoc",
		"c", "cdoc",
		"cpp", "cppdoc",
		"csharp", "cs", "csharpdoc",
		"r",
		"javascript", "jsdoc",
		"html",
		"css", "scss", "sass", "less", "stylus",
		"tex", "plaintex", -- latex
		"shellscript", "shell", "sh", "zsh", "shelldoc",
		"dockerfile", "yaml", -- docker + kubernetes (see below)
		"gitcommit", "NeogitCommitMessage",
		"gleam",
		"markdown",
		"sql",
		"svelte",
		"swift",
		"go",
		"vue",
	},
}
