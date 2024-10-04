-- GitHub Repositories
return {
  -- Required plugins
  "nvim-lua/plenary.nvim", -- Lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- Tmux & split window navigation

  -- Copilot Plugin
  "github/copilot.vim",

  -- Copilot Chat Plugin
  {
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
      --
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
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end, { desc = "CopilotChat - Quick chat" })

      keymap.set("v", "<leader>ccq", function()
        vim.ui.input({ prompt = "Quick Chat: " }, function(input)
          if input ~= nil and input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
          end
        end)
      end, { desc = "CopilotChat - Quick chat" })
    end,
  },

  -- Treesitter Context Plugin Configuration
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup({
  --       enable = true, -- Enable this plugin
  --       max_lines = 0, -- No limit on lines the window should span
  --       min_window_height = 0, -- Minimum editor window height to enable context
  --       line_numbers = true,
  --       multiline_threshold = 20, -- Maximum number of lines to show for a single context
  --       trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded
  --       mode = "cursor", -- Line used to calculate context
  --       separator = nil, -- Separator character between context and content
  --       zindex = 20, -- The Z-index of the context window
  --       on_attach = nil, -- Function to call on attach
  --     })
  --   end,
  -- },
}
