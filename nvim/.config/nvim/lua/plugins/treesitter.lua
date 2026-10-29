return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "java", "xml", "yaml", "json", "sql", "bash", "ruby" })

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
