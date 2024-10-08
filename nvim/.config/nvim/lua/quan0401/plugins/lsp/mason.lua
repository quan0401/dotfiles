return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"dockerls",
				"helm_ls",
				"gopls",
				"clangd",
				"ansiblels",
				"terraformls",
				"tflint",
			},
		})

		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*.tf",
			command = "setfiletype terraform",
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
			},
		})

		-- local lspconfig = require("lspconfig")
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
		-- local capabilities = cmp_nvim_lsp.default_capabilities()
		--
		-- -- Define on_attach function
		-- local function on_attach(client, bufnr)
		-- 	if client.name == "terraformls" then
		-- 		-- Keybindings for LSP
		-- 		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {})
		-- 		-- Add more LSP-related configurations here
		-- 	end
		-- end

		-- mason_lspconfig.setup_handlers({
		-- 	-- default handler for installed servers
		-- 	function(server_name)
		-- 		lspconfig[server_name].setup({
		-- 			capabilities = capabilities,
		-- 		})
		-- 	end,
		-- 	-- Specific configuration for terraformls
		-- 	["terraformls"] = function()
		-- 		lspconfig["terraformls"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach, -- Attach the on_attach function
		-- 			settings = {
		-- 				terraform = {
		-- 					validateOnSave = true,
		-- 					experimentalFeatures = {
		-- 						validateOnSave = false,
		-- 						enableWorkspaceFolders = false,
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		-- 	end,
		-- })
	end,
}
