-- Merged over nvim-lspconfig's lsp/ruby_lsp.lua (see after/lsp/lemminx.lua).
-- Enabled from plugins/lsp.lua when ruby is in ~/.config/dotfiles/langs.
return {
  init_options = {
    -- Its lenses run VS Code commands (rubyLsp.runTest) Neovim can't execute;
    -- vim-test (<leader>tn/tf) covers running tests instead.
    enabledFeatures = { codeLens = false },
    featuresConfiguration = {
      inlayHint = { implicitHashValue = true, implicitRescue = true },
    },
  },
  on_attach = function(client, bufnr)
    if client:supports_method("textDocument/formatting") then
      -- Cleared on every attach so a restarted server doesn't format twice
      local group = vim.api.nvim_create_augroup("ruby_lsp_format_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
          -- RuboCop can take over the 1s default on large files
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 3000 })
        end,
      })
    end
  end,
}
