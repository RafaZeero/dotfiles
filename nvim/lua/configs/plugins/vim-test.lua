return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>", { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>tT", ":TestFile<CR>", { desc = "Run all tests in file" })
    vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "Run entire test suite" })
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last executed test" })
    vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>", { desc = "Revisit last test file" })
    vim.cmd("let test#strategy = 'vimux'")
  end,
}
