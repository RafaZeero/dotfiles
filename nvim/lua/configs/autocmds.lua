-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- local client = vim.lsp.start_client({
-- 	name = "educationalsp",
-- 	cmd = { "/home/zeero/Documents/codes/projects/go/lsp-tj/main" },
-- })
--
-- if not client then
-- 	vim.notify("hey, you didnt do the client thing good", 1)
-- 	return
-- end

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	callback = function()
-- 		vim.lsp.buf_attach_client(0, client)
-- 	end,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    vim.opt_local.set.number = false
    vim.opt_local.set.relativenumber = false
    vim.opt_local.set.scrolloff = 0
  end,
})
