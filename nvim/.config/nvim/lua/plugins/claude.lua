return {
  "codegik/claude-chat.nvim",
  cmd = { "ClaudeChat", "ClaudeChatReset", "ClaudeChatFile", "ClaudeChatContinue", "ClaudeChatSessions" },
  keys = {
    { "<leader>ai", "<cmd>ClaudeChat<cr>", desc = "Claude Chat: toggle sidebar" },
    { "<leader>af", "<cmd>ClaudeChatFile<cr>", desc = "Claude Chat: add current file" },
  },
  config = function()
    require("claude-chat").setup()
  end,
}
