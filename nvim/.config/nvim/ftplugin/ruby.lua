vim.keymap.set("i", "bbb", "binding.pry", { buffer = true })

-- Open (or create) the spec for app/**/*.rb
vim.keymap.set("n", "<leader>ts", function()
  local file = vim.fn.expand("%:.")
  if not file:match("_spec%.rb$") then
    vim.cmd.edit((file:gsub("^app/", "spec/"):gsub("%.rb$", "_spec.rb")))
  end
end, { buffer = true, desc = "Open matching RSpec spec" })
