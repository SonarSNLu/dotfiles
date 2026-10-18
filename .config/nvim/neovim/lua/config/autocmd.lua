--useful stuff

-- close nvim-tree if it's last buffer open
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == "NvimTree" then
	vim.cmd("quit")
	end
	end,
})


-- auto-create missing dirs when saving a file
--vim.api.nvim_create_autocmd("BufWritePre", {
--	pattern = "*",
--	callback = function()
--	local dir = vim.fn.expand("<afile>:p:h")
--	if vim.fn.isdirectory(dir) == 0 then
--		vim.fn.mkdir(dir, "p")
--	end
--end,
--})


-- linting when file is written to
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype, on write
    require("lint").try_lint()
  end,
})


-- spellcheck in md
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell wrap",
})


-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
		end,
})


-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
	vim.highlight.on_yank({ timeout = 300 })
	end,
})


-- reload files on external change
--vim.api.nvim_create_autocmd("FocusGained", {
--	pattern = "*",
--	command = "checktime",
--})


-- restore cursor pos on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
	local line = vim.fn.line("'\"")
	if line > 1 and line <= vim.fn.line("$") then
		vim.cmd("normal! g'\"")
	end
end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    vim.g.startup_time_ms = string.format("%.2f ms", startuptime * 1000)
  end,
})

vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePre *",
	group = "alpha_on_empty",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name == "" then
      vim.cmd([[:Alpha | bd#]])
		end
	end,
})


vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
         vim.opt.relativenumber = true
      end
   end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      if vim.o.nu then
         vim.opt.relativenumber = false
         -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
         -- Workaround for https://github.com/neovim/neovim/issues/32068
         if not vim.tbl_contains({"@", "-"}, vim.v.event.cmdtype) then
            vim.cmd "redraw"
         end
      end
   end,
})

-- Disable on nvim menu startup
local orig_laststatus = vim.o.laststatus

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "FileType" }, {
  callback = function()
    vim.schedule(function()
      local on_alpha = vim.bo.filetype == "alpha"
      vim.o.laststatus  = on_alpha and 0 or orig_laststatus
      vim.o.showtabline = on_alpha and 0 or 2
    end)
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    local buf = 0
    -- Check if current buffer is empty, unnamed, and not modified
    if vim.bo[buf].filetype == "" and vim.bo[buf].buftype == "" and vim.fn.bufname(buf) == "" and vim.api.nvim_buf_line_count(buf) == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end
  end,
})

