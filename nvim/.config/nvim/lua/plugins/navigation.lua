local function cycle_pane(step)
  local wins = vim.tbl_filter(function(w)
    return vim.api.nvim_win_get_config(w).relative == ""
  end, vim.api.nvim_tabpage_list_wins(0))
  table.sort(wins, function(a, b)
    return vim.fn.win_id2win(a) < vim.fn.win_id2win(b)
  end)
  local target = vim.fn.index(wins, vim.api.nvim_get_current_win()) + 1 + step
  if vim.env.TMUX and (target < 1 or target > #wins) then
    vim.api.nvim_set_current_win(wins[step > 0 and 1 or #wins])
    vim.fn.system({ "tmux", "select-pane", "-t", step > 0 and ":.+" or ":.-" })
  else
    vim.api.nvim_set_current_win(wins[(target - 1) % #wins + 1])
  end
end

return {
  -- Fuzzy Finder
  -- junegunn/fzf provides the fzf binary (also used by the shell via ~/.fzf.zsh)
  { "junegunn/fzf", build = "./install --all" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Open buffers" },
      { "<leader>fh", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jump list" },
      { "<leader>fs", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace symbols (LSP)" },
      { "<leader>fi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Implementations (LSP)" },
      { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume last picker" },
    },
    opts = {
      -- Point at the binary directly so it works even when nvim isn't started from zsh
      fzf_bin = vim.fn.stdpath("data") .. "/lazy/fzf/bin/fzf",
    },
  },

  -- tmux pane navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight", "TmuxNavigatePrevious", "TmuxNavigatorProcessList" },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      { "<M-]>", function() cycle_pane(1) end, mode = { "n", "i", "t" }, desc = "Next pane (vim/tmux)" },
      { "<M-[>", function() cycle_pane(-1) end, mode = { "n", "i", "t" }, desc = "Previous pane (vim/tmux)" },
    },
  },
}
