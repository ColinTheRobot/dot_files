return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "jdtls", "lemminx" },
      -- jdtls is started by nvim-jdtls (with the Lombok agent); auto-enabling
      -- it here would launch a second, agent-less jdtls via nvim-lspconfig defaults.
      automatic_enable = { exclude = { "jdtls" } },
    },
  },
  "mfussenegger/nvim-jdtls",
}
