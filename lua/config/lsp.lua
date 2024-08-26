local lsp = require("lspconfig")

-- Loop through all servers and disable inlay hints
for server, _ in pairs(lsp) do
  lsp[server].setup({
    on_attach = function(client)
      if client.server_capabilities.inlayHintProvider then
        client.server_capabilities.inlayHintProvider = false
      end
    end,
  })
end
