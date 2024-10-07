return {
	"luukvbaal/nnn.nvim",
	config = function()
		require("nnn").setup({
			explorer = {
				cmd = "nnn -deA",
				width = 30,
			},
		})
		local keymap = vim.keymap
		keymap.set("n", "<leader>nn", ":NnnPicker<CR>", { desc = "nnn" })
	end,
}
