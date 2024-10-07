-- GitHub Repositories
return {
	-- Required plugins
	"nvim-lua/plenary.nvim", -- Lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- Tmux & split window navigation
	"github/copilot.vim",
	{
		"matze/vim-move",

		config = function()
			-- Configure vim-move key mappings for Neovim
			local keymap = vim.keymap

			keymap.set("v", "<A-Up>", "<Plug>MoveBlockUp", { desc = "MoveBlockUp" })
			keymap.set("v", "<A-Down>", "<Plug>MoveBlockDown", { desc = "MoveBlockDown" })

			keymap.set("n", "<A-Up>", "<Plug>MoveLineUp", { desc = "MoveLineUp" })
			keymap.set("n", "<A-Down>", "<Plug>MoveLineDown", { desc = "MoveLineDown" })
		end,
	},
	{
		"mg979/vim-visual-multi",
	},
}
