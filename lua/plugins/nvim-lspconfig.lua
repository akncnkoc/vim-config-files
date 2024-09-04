return {
  "neovim/nvim-lspconfig",
  version = "*",
  opts = {
    inlay_hints = { enable = false },
    servers = {
      csharp_ls = {
        root_dir = require("lspconfig/util").root_pattern("*.csproj", "*.sln"),
        handlers = {
          ["window/showMessage"] = function(_, result, ctx)
            -- Suppress the notification
          end,
        },
      },
    },
  },
}
