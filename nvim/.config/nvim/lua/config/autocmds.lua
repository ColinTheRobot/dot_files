-- LSP attach: keymaps and diagnostics.
-- Fires for every buffer a client attaches to - unlike config.on_attach, which
-- nvim-jdtls skips when a buffer attaches to an already-running jdtls server.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)

    if client and client.name == "jdtls" then
      vim.keymap.set("n", "<Leader>oi", require("jdtls").organize_imports, opts)
    end
  end,
})

-- CSV
vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  command = "set fileformat=unix",
})
