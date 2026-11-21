local langs = require("config.langs")

local servers = {}
if langs.enabled("java") then
  vim.list_extend(servers, { "jdtls", "lemminx" })
end

return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = servers,
      -- jdtls is started by nvim-jdtls (with the Lombok agent); auto-enabling
      -- it here would launch a second, agent-less jdtls via nvim-lspconfig defaults.
      automatic_enable = { exclude = { "jdtls" } },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      -- ruby-lsp isn't from Mason: langs/ruby/install.sh installs it into each
      -- rbenv Ruby, so the shim runs it with the project's Ruby and bundle.
      if langs.enabled("ruby") then
        vim.lsp.enable("ruby_lsp")
      end
      -- rust-analyzer is a rustup component (langs/rust/install.sh), so it
      -- matches the toolchain. sourcekit-lsp comes with Xcode; for Xcode
      -- projects, run `xcode-build-server config` to write buildServer.json.
      if langs.enabled("rust") then
        vim.lsp.enable("rust_analyzer")
      end
      if langs.enabled("swift") then
        vim.lsp.enable("sourcekit")
      end
    end,
  },
}
