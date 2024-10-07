return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "absolute" },
				mappings = {
					i = {
						["<c-k>"] = actions.move_selection_previous, -- move to prev result
						["<c-j>"] = actions.move_selection_next, -- move to next result
						["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<c-a>"] = actions.select_all,
					},
				},
			},
		})

		-- for faster
		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

		-- Custom live_grep_in_glob function
		local function live_grep_in_glob(glob_pattern)
			require("telescope.builtin").live_grep({
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--glob=" .. (glob_pattern or ""),
				},
			})
		end

		-- Create a keymap for live_grep_in_glob
		keymap.set("n", "<leader>fg", function()
			vim.ui.input({ prompt = "Glob: ", completion = "file", default = "**/*." }, live_grep_in_glob)
		end, { desc = "Live grep with glob pattern" })
	end,
}
