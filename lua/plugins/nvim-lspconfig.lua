return {
  "neovim/nvim-lspconfig",
  version = "*",
  opts = {
    servers = {
      omnisharp = {
        handlers = {
          ["textDocument/definition"] = function(...)
            return require("omnisharp_extended").handler(...)
          end,
        },
        keys = {
          {
            "gd",
            function()
              require("omnisharp_extended").telescope_lsp_definitions()
            end,
            desc = "Goto Definition",
          },
        },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      },
    },
  },
  setup = {
    eslint = function()
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = true
        elseif client.name == "tsserver" or client.name == "vtsls" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end)
    end,
  },
}
