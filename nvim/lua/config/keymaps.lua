-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local set = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

set("n", "<leader>cf", "<cmd>source %<CR>", { desc = "Source [F]ile" })
set("n", "<leader>cx", ":.lua<CR>", { desc = "Source line" })
set("v", "<leader>x", ":lua<CR>", { desc = "Source line [v]" })

-- Diagnostic keymaps
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

set("n", "<m-j>", "<cmd>cn<CR>", { desc = "Next item in quick list" })
set("n", "<m-k>", "<cmd>cp<CR>", { desc = "Prev item in quick list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- control size of splits (width/height)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-;>", "<C-w>+>")
set("n", "<M-'>", "<C-w>->")

set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

-- set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })

set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection Down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection Up" })
set("n", "J", "mzJ`z", { desc = "Join line below" })
set("n", "n", "nzzzv", { desc = "Go to next search" })
set("n", "N", "Nzzzv", { desc = "Go to previous search" })
-- greatest remap ever
set("x", "<leader>p", [["_dP]], { desc = "Paste without losing reference" })

set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Show file tree" })

set(
  "n",
  "<leader>ls",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Select all ocurrences in file" }
)

-- Buffer
set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Remove current buffer" })
set("n", "<leader>bs", "<cmd>%bd|e#<CR>", { desc = "Remove other buffers" })

set("n", "<leader>lp", [[viw<leader>p]], { desc = "Replace word with copy reference" })

set("n", "<leader>cc", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.fn.termopen("claude")
end, { desc = "Open claude code" })
