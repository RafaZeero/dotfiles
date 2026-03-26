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
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})

vim.api.nvim_create_user_command("NewIPYNB", function(opts)
  local filename = opts.args ~= "" and opts.args or "notebook.ipynb"

  if not filename:match("%.ipynb$") then
    filename = filename .. ".ipynb"
  end

  local dir = vim.fn.getcwd()
  local path = dir .. "/" .. filename

  vim.fn.writefile({
    "{",
    ' "cells": [',
    "  {",
    '   "cell_type": "code",',
    '   "execution_count": null,',
    '   "metadata": {},',
    '   "outputs": [],',
    '   "source": []',
    "  }",
    " ],",
    ' "metadata": {',
    '  "kernelspec": {',
    '   "display_name": "venv",',
    '   "language": "python",',
    '   "name": "python3"',
    "  },",
    '  "language_info": {',
    '   "codemirror_mode": {',
    '    "name": "ipython",',
    '    "version": 3',
    "   },",
    '   "file_extension": ".py",',
    '   "mimetype": "text/x-python",',
    '   "name": "python",',
    '   "nbconvert_exporter": "python",',
    '   "pygments_lexer": "ipython3",',
    '   "version": "3.10.11"',
    "  }",
    " },",
    ' "nbformat": 4,',
    ' "nbformat_minor": 2',
    "}",
  }, path)

  -- vim.cmd("0r ~/dotfiles/nvim/templates/ipynb.json")
end, { nargs = "?" })
