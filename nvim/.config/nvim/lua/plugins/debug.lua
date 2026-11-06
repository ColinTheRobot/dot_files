return {
  {
    "mfussenegger/nvim-dap",
    tag = "0.10.0",
    lazy = false,
    dependencies = { "theHamsta/nvim-dap-virtual-text" },
    config = function()
      local dap = require("dap")
      require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol" })

      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to localhost:5005",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end
      map("<leader>db", dap.toggle_breakpoint, "Debug: toggle breakpoint")
      map("<leader>dc", dap.continue, "Debug: start / continue")
      map("<leader>dn", dap.step_over, "Debug: step over")
      map("<leader>di", dap.step_into, "Debug: step into")
      map("<leader>do", dap.step_out, "Debug: step out")
      map("<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, "Debug: show value under cursor")
      map("<leader>dq", dap.terminate, "Debug: stop")
      map("<leader>dt", function()
        require("jdtls").test_nearest_method()
      end, "Debug: nearest test")
    end,
  },
}
