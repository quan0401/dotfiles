return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		"github/copilot.vim", -- Copilot itself
		"nvim-lua/plenary.nvim", -- For curl, log wrapper
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
		debug = true, -- Enable debugging
		-- See Configuration section for additional options
	},

	config = function()
		require("CopilotChat").setup({
			debug = true,
			build = "make tiktoken", -- Only on MacOS or Linux,
		})
		local keymap = vim.keymap -- Ensure you have your keymap module or library loaded
		keymap.set("v", "<leader>ccp", function()
			local actions = require("CopilotChat.actions")
			require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
		end, { desc = "CopilotChat - Prompt actions" })

		keymap.set("n", "<leader>ccq", function()
			vim.ui.input({ prompt = "Quick Chat: " }, function(input)
				if input ~= nil and input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end)
		end, { desc = "CopilotChat - Quick chat" })

		keymap.set("v", "<leader>ccq", function()
			vim.ui.input({ prompt = "Quick Chat: " }, function(input)
				if input ~= nil and input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
				end
			end)
		end, { desc = "CopilotChat - Quick chat" })

		keymap.set("n", "<leader>cct", function()
			require("CopilotChat").toggle()
		end, { desc = "CopilotChat - Toggle" })
	end,
}
