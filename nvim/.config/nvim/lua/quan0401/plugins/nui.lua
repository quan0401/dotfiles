return {
	"MunifTanjim/nui.nvim",

	config = function()
		local Input = require("nui.input")
		local event = require("nui.utils.autocmd").event

		local chat = require("CopilotChat")

		local function show_input_popup()
			-- Create the popup with an input field
			local input_popup = Input({
				position = "50%",
				size = {
					width = "80%",
				},
				border = {
					style = "rounded",
					text = {
						top = "Copilot",
						top_align = "center", -- Can be "left", "right", or "center"
					},
				},
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
				},
			}, {
				prompt = "> ", -- Custom prompt for the input
				default_value = "", -- Optional: Pre-fill the input
				on_submit = function(input_text)
					-- Pass the input to Copilot Chat
					chat.ask(input_text)
				end,
			})

			-- Open the popup
			input_popup:mount()

			-- Close the popup on buffer leave or ESC
			input_popup:on(event.BufLeave, function()
				input_popup:unmount()
			end)
		end

		-- Define key mapping to trigger the input popup
		local keymap = vim.keymap
		keymap.set("n", "<leader>cca", function()
			show_input_popup()
		end, { desc = "Show chat input popup" })
	end,
}
