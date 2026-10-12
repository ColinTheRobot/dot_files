-- Merged over nvim-lspconfig's lsp/lemminx.lua. Lives under after/ so it loads
-- last and wins (lsp/*.lua files merge in runtimepath order). Enabled by
-- mason-lspconfig's automatic_enable.
return {
  filetypes = { "xml" },
  settings = {
    xml = {
      format = {
        enabled = true,
        splitAttributes = "preserve",
        maxLineWidth = 280,
      },
    },
    xslt = {
      format = {
        enabled = true,
        splitAttributes = "preserve",
        maxLineWidth = 280,
      },
    },
  },
}
