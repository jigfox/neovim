return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- 1. Setup the autocmd to watch for gotmpl files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gotmpl",
        callback = function()
          local otter = require("otter")

          -- 2. Activate Otter for the languages you want to support.
          --    This tells Otter: "Look for injected regions of these languages,
          --    create hidden buffers for them, and attach their LSPs."
          --
          --    Make sure you have these LSPs installed via Mason
          --    (e.g., bashls, yamlls, taplo for toml, pyright)
          local languages = { "sh", "bash", "yaml", "toml", "json", "python" }

          -- Activate(languages, completion, diagnostics, injection_query)
          otter.activate(languages, true, true, nil)
        end,
      })
    end,
    keys = {
      "<leader>co",
      function()
        local otter = require("otter")
        if vim.b.otter_active then
          otter.deactivate()
          vim.b.otter_active = false
          vim.notify("Otter validation disabled", vim.log.levels.WARN, { title = "Otter" })
        else
          otter.activate({ "yaml" }, true, true, nil)
          vim.b.otter_active = true
          vim.notify("Otter validation enabled", vim.log.levels.INFO, { title = "Otter" })
        end
      end,
      desc = "Toggle Otter (Injected LSP)",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "yaml",
        callback = function()
          local ok, otter = pcall(require, "otter")
          if ok then
            -- Tell Otter to look for injected 'yaml' and provide completions/diagnostics
            otter.activate({ "yaml" }, true, true, nil)
          end
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sources, { name = "otter" })
    end,
  },
}
