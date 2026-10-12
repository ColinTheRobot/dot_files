return {
  "nvim-tree/nvim-web-devicons",
  "mbbill/undotree",
  {
    "folke/trouble.nvim",
    opts = {
      -- Values <= 1 are a fraction of the editor; width applies to left/right
      -- splits (e.g. <leader>cl), height to top/bottom (e.g. <leader>xx)
      win = { size = { width = 0.4, height = 0.4 } },
      modes = {
        lsp = {
          -- Default minus:
          -- - lsp_type_definitions: jdtls answers an empty
          --   textDocument/typeDefinition with no `result` field, which
          --   Neovim 0.12 rejects as INVALID_SERVER_MESSAGE.
          -- - lsp_references: a workspace-wide search (4-11s in core-api) that
          --   reruns on every CursorHold since this panel follows the cursor.
          --   Use <leader>cr for references on demand.
          sections = {
            "lsp_definitions",
            "lsp_implementations",
            "lsp_declarations",
            "lsp_incoming_calls",
            "lsp_outgoing_calls",
          },
        },
      },
    },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions/implementations/calls" },
      { "<leader>cr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references" },
    },
  },
}
