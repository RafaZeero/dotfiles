return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			-- I guess this is required :V
			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Add file to list" })

			-- Set key to alt+e
			vim.keymap.set("n", "<m-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle quick menu" })

			-- Set <space>1..<space>5 be my shortcuts to moving to the files
			-- for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
			-- 	vim.keymap.set("n", string.format("<space>%d", idx), function()
			-- 		harpoon:list():select(idx)
			-- 	end)
			-- end

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<m-p>", function()
				harpoon:list():prev()
			end, { desc = "Go to prev" })

			vim.keymap.set("n", "<m-n>", function()
				harpoon:list():next()
			end, { desc = "Go to next" })
		end,
	},
}
