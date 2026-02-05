return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
    end,
  },
  -- {
  -- 	"linux-cultist/venv-selector.nvim",
  -- 	dependencies = {
  -- 		"neovim/nvim-lspconfig",
  -- 		"mfussenegger/nvim-dap",
  -- 		"mfussenegger/nvim-dap-python", --optional
  -- 		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  -- 	},
  -- 	lazy = false,
  -- 	branch = "regexp", -- This is the regexp branch, use this for the new version
  -- 	config = function()
  -- 		require("venv-selector").setup()
  -- 	end,
  -- 	keys = {
  -- 		{ ",v", "<cmd>VenvSelect<cr>" },
  -- 	},
  -- },
}
