-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>cr", "<cmd>source %<CR>", { desc = "Source file" })
vim.keymap.set("n", "<leader>cx", ":.lua<CR>", { desc = "Source line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Source line [v]" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection Up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Go to next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Go to previous search" })
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing reference" })

vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Show file tree" })

vim.keymap.set(
  "n",
  "<leader>ls",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Select all ocurrences in file" }
)

-- Buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Remove current buffer" })
vim.keymap.set("n", "<leader>bs", "<cmd>%bd|e#<CR>", { desc = "Remove other buffers" })

vim.keymap.set("n", "<leader>lp", [[viw<leader>p]], { desc = "Replace word with copy reference" })
