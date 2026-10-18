require("nvim-tree").setup({
	prefer_startup_root = false, -- resolve symlink
	renderer = {
		--note on icons:
		--in some terminals, some patched fonts cut off glyphs if not given extra space
		--either add extra space, disable icons, or change font
		icons = {
			padding = " ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			git_placement = "after", -- Options: "before", "after", "signcolumn", "right_align"
			glyphs = {
				git = {
					unstaged = "●",
					staged = "✓",
					untracked = "+",
					unmerged = "⚠",
					renamed = "➜",
					deleted = "✗",
					ignored = "◌",
				},
			},
		},
	},

	view = {
		width = 26,
		side = 'right',
	},
	sync_root_with_cwd = true, --fix to open cwd with tree
	respect_buf_cwd = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		update_root = true,
	},

	update_focused_file = {
		enable = true,
		update_root = false, -- Prevent the tree from aggressively shifting roots when crossing symlinks
		ignore_list = {}, -- If it still breaks, you can add your symlink name here to ignore auto-focusing
	},

	-- Add this new section below to ignore AppData and node_modules
	filters = {
		dotfiles = false,
		git_ignored = false,
		custom = {
			"AppData"
			--"node_module",
			--"\\.git"
		},
	},
})
-- use g? for bindings help while in tree
