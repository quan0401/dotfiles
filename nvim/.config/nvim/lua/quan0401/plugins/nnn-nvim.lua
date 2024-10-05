return {
	"luukvbaal/nnn.nvim",
	config = function()
		require("nnn").setup({
			command = "nnn -C",
			-- set_default_mappings = false,
			-- action = {
			-- 	["<C-t>"] = "tabedit",
			-- 	["<C-s>"] = "split",
			-- 	["<C-v>"] = "vsplit",
			-- 	["<C-o>"] = "drop",
			-- 	["<C-q>"] = "quit",
			-- },
		})
	end,
}
