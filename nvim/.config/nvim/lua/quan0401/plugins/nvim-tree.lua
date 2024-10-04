return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Function to open iTerm2, start tmux, and open nvim in the selected directory
		local function open_iterm_tmux_nvim(node)
			local path = node.absolute_path
			-- Use AppleScript to open a new iTerm2 window and execute tmux and nvim
			-- local command = 'osascript -e \'tell application "iTerm"\n    create window with default profile\n    tell current session of current window\n        write text "tmux new-session; send-keys \\"cd '
			-- 	.. path
			-- 	.. ' && nvim\\" C-m"\n    end tell\nend tell\''
			local command = 'osascript -e \'tell application "iTerm"\n'
				.. "    create window with default profile\n"
				.. "    delay 0.5\n" -- Introduce a 0.5-second delay to ensure the window is ready
				.. "    tell current session of current window\n"
				.. '        write text "tmux new-session; send-keys \\"cd '
				.. path
				.. ' && nvim\\" C-m"\n'
				.. "    end tell\n"
				.. "end tell'"
			os.execute(command)
		end

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			vim.keymap.set("n", "ss", function()
				local node = require("nvim-tree.lib").get_node_at_cursor()
				if node then
					open_iterm_tmux_nvim(node)
				end
			end, opts("Open in iTerm2, start tmux, and open nvim in the selected directory"))

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
				side = "right",
			},
			-- on_attach = my_on_attach,

			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},

			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = true,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- <cmd> cmd on mac, <CR> is ente
		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		-- keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus on file explorer" })

		local function open_in_new_terminal()
			local node = require("nvim-tree.lib").get_node_at_cursor()
			if node and node.type == "directory" then
				os.execute("nvim " .. node.absolute_path .. " &") -- Use & to run it in the background
			end
		end

		keymap.set("n", "<leader>ov", function()
			local node = require("nvim-tree.lib").get_node_at_cursor()
			if node then
				open_iterm_tmux_nvim(node)
			end
		end, { desc = "Open in iTerm2, start tmux, and open nvim in the selected directory" })

		keymap.set("n", "<leader>ot", open_in_new_terminal, { desc = "Open folder in new terminal window" })
	end,
}
