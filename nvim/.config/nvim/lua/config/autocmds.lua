-- LSP attach: keymaps and diagnostics.
-- Fires for every buffer a client attaches to - unlike config.on_attach, which
-- nvim-jdtls skips when a buffer attaches to an already-running jdtls server.
vim.diagnostic.config({ virtual_text = true })

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
    vim.keymap.set({ "n", "x" }, "<Leader>ca", vim.lsp.buf.code_action, opts)

    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    if client and client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = bufnr })
    end

    if client and client.name == "jdtls" then
      local jdtls = require("jdtls")
      vim.keymap.set("n", "<Leader>oi", jdtls.organize_imports, opts)
      vim.keymap.set("n", "<Leader>rv", jdtls.extract_variable, opts)
      vim.keymap.set("x", "<Leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable({ visual = true })<CR>", opts)
      vim.keymap.set("n", "<Leader>rc", jdtls.extract_constant, opts)
      vim.keymap.set("x", "<Leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant({ visual = true })<CR>", opts)
      vim.keymap.set("x", "<Leader>rm", "<Esc><Cmd>lua require('jdtls').extract_method({ visual = true })<CR>", opts)
    end
  end,
})

-- Reload buffers changed on disk by other tools (e.g. Claude Code)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- CSV
vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  command = "set fileformat=unix",
})
