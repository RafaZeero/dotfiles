vim.opt_local.expandtab = true -- Usar espaços em vez de tabs
vim.opt_local.tabstop = 4 -- Tamanho do tab como 4 espaços
vim.opt_local.softtabstop = 4 -- Número de espaços inseridos por um tab
vim.opt_local.shiftwidth = 4 -- Indentação de 4 espaços
vim.opt_local.smartindent = true -- Indentação inteligente
vim.opt_local.autoindent = true -- Auto-indentação

local opts = function(optsTable)
  local _opts = { buffer = true }
  for k, v in pairs(optsTable) do
    _opts[k] = v
  end

  return _opts
end

vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/nvim/bin/python3")

vim.g.molten_image_provider = "image.nvim"
vim.g.molten_virt_text_output = true
-- vim.g.molten_wrap_output = true -- default: false
vim.g.molten_output_win_max_height = 20
vim.g.molten_use_border_highlights = true -- default: false
vim.g.molten_virt_lines_off_by_1 = true -- default: false
vim.g.molten_enter_output_behavior = "open_then_enter"

-- Molten
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", opts({ desc = "Initialize the plugin" }))
vim.keymap.set("n", "<leader>me", ":MoltenEvaluateOperator<CR>", opts({ desc = "Run operator selection" }))
vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", opts({ desc = "Evaluate line" }))
vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<CR>", opts({ desc = "Re-evaluate cell" }))
vim.keymap.set("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv", opts({ desc = "Evaluate visual selection" }))
vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", opts({ desc = "Delete cell" }))
vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", opts({ desc = "Hide output" }))
vim.keymap.set("n", "<leader>ms", ":noautocmd MoltenEnterOutput<CR>", opts({ desc = "Show/Enter output" }))
