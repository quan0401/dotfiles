return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		local function restore_session_prompt()
			local session_path = require("auto-session").get_latest_session()
			if session_path then
				vim.ui.input({ prompt = "Restore previous session? (y/n): " }, function(input)
					if input == "y" then
						require("auto-session").RestoreSession()
					end
				end)
			end
		end

		auto_session.setup({
			-- auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			auto_restore_last_session = true,
			auto_restore = true,
		})

		local keymap = vim.keymap
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	callback = restore_session_prompt,
		-- })

		keymap.set(
			"n",
			"<leader>wl",
			require("auto-session.session-lens").search_session,
			{ desc = "Show nvim sessions", noremap = true }
		) -- search for session

		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
