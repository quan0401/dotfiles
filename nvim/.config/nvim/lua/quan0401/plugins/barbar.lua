return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	--- if specified, this plugin will be loaded only when we use the key bindings
	-- keys = {
	-- 	{ "<A-Left>", ":BufferNext<CR>", desc = "Next buffer" }, -- Bind to your desired keymap
	-- 	{ "<A-Right>", ":BufferPrevious<CR>", desc = "Previous buffer" }, -- Another example
	-- },

	event = "VeryLazy", -- this will fix the error with bufferline
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
		-- animation = true,
		-- insert_at_start = true,
		-- …etc.
	},
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
	config = function()
		require("barbar").setup({
			-- options = {
			-- 	show_tab_indicators = true,
			-- 	show_close_icon = false,
			-- 	show_buffer_close_icons = false,
			-- 	show_buffer_icons = false,
			-- 	show_tab_close_icons = false,
			-- 	persist_buffer_sort = true,
			-- 	separator_style = "thin",
			-- 	mappings = true,
			-- },
		})

		vim.opt.sessionoptions:append("globals")
		vim.api.nvim_create_user_command("Mksession", function(attr)
			vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })

			-- Neovim 0.8+
			vim.cmd.mksession({ bang = attr.bang, args = attr.fargs })

			-- Neovim 0.7
			vim.api.nvim_command("mksession " .. (attr.bang and "!" or "") .. attr.args)
		end, { bang = true, complete = "file", desc = "Save barbar with :mksession", nargs = "?" })

		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Move to previous/next
		map("n", "<A-Left>", "<Cmd>BufferPrevious<CR>", opts)
		map("n", "<A-Right>", "<Cmd>BufferNext<CR>", opts)
		-- Re-order to previous/next
		map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
		map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
		-- Goto buffer in position...
		map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
		map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
		map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
		map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
		map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
		map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
		map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
		map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
		map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
		map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
		map("n", "<A-p>", "<Cmd>BufferPick<CR>", opts)
		-- Close buffer
		map("n", "<leader>bc", ":BufferCloseAllButCurrent<CR>", { noremap = true, silent = true })
		map("n", "<leader>bp", ":BufferCloseAllButPinned<CR>", { noremap = true, silent = true })
		map("n", "<leader>bcp", ":BufferCloseAllButCurrentOrPinned<CR>", { noremap = true, silent = true })
		map("n", "<leader>bl", ":BufferCloseBuffersLeft<CR>", { noremap = true, silent = true })
		map("n", "<leader>br", ":BufferCloseBuffersRight<CR>", { noremap = true, silent = true })

		-- This code binds the following keys in normal mode:
		-- - `<leader>bc` to `:BufferCloseAllButCurrent`
		-- - `<leader>bp` to `:BufferCloseAllButPinned`
		-- - `<leader>bcp` to `:BufferCloseAllButCurrentOrPinned`
		-- - `<leader>bl` to `:BufferCloseBuffersLeft`
		-- - `<leader>br` to `:BufferCloseBuffersRight`
		map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
		map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
		map("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", opts)
		map("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
		map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
		map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
	end,
}
