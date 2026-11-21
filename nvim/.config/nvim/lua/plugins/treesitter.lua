return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = require("config.langs")
      local parsers = { "xml", "yaml", "json", "sql", "bash", "lua" }
      if langs.enabled("java") then
        vim.list_extend(parsers, { "java" })
      end
      if langs.enabled("ruby") then
        vim.list_extend(parsers, { "ruby", "embedded_template", "html", "javascript" })
      end
      if langs.enabled("rust") then
        vim.list_extend(parsers, { "rust", "toml" })
      end
      if langs.enabled("swift") then
        vim.list_extend(parsers, { "swift" })
      end
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })

      local function map(keys, query)
        vim.keymap.set({ "x", "o" }, keys, function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end)
      end
      map("af", "@function.outer")
      map("if", "@function.inner")
      map("ac", "@class.outer")
      map("ic", "@class.inner")
      map("aa", "@parameter.outer")
      map("ia", "@parameter.inner")
    end,
  },
}
