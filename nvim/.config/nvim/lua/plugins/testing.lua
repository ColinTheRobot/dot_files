return {
  {
    "vim-test/vim-test",
    tag = "v3.7.0",
    dependencies = { "preservim/vimux" },
    cmd = { "TestNearest", "TestFile", "TestLast", "TestVisit", "TestSuite" },
    keys = {
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Re-run last test" },
      { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Open last test file" },
      { "<leader>atn", "<cmd>TestNearest -strategy=claude<cr>", desc = "Claude: run nearest test" },
      { "<leader>atf", "<cmd>TestFile -strategy=claude<cr>", desc = "Claude: run test file" },
      { "<leader>atl", "<cmd>TestLast -strategy=claude<cr>", desc = "Claude: re-run last test" },
    },
    init = function()
      vim.g.VimuxUseNearest = 0
      vim.g["test#strategy"] = "vimux"
      vim.g["test#java#runner"] = "maventest"
      vim.g["test#java#maventest#executable"] =
        "JAVA_HOME=$HOME/.sdkman/candidates/java/21.0.12-tem mvn"
      vim.g["test#custom_transformations"] = {
        integration_tests = function(cmd)
          if cmd:find(" verify ") then
            return cmd .. " -Pintegration-test -Dtest=NoUnitTests -Dsurefire.failIfNoSpecifiedTests=false"
          end
          return cmd
        end,
      }
      vim.g["test#transformation"] = "integration_tests"
      vim.g["test#custom_strategies"] = {
        claude = function(cmd)
          local mvnq = cmd:gsub("^JAVA_HOME=%S+ mvn ", "mvnq "):gsub("\\#", "#")
          local pane = vim.fn.system(
            "tmux list-panes -F '#{pane_id} #{pane_current_command}' | awk '$2 == \"claude\" { print $1; exit }'"
          ):gsub("%s+$", "")
          if pane == "" then
            vim.notify("No Claude pane in this tmux window", vim.log.levels.WARN)
            return
          end
          local prompt = "Run this test and explain any failures: `" .. mvnq .. "`"
          vim.fn.system({ "tmux", "send-keys", "-t", pane, "-l", prompt })
          vim.fn.system({ "tmux", "send-keys", "-t", pane, "Enter" })
        end,
      }
    end,
  },
}
