vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

local mason = vim.fn.stdpath("data") .. "/mason/packages"
local bundles = {
  vim.fn.glob(mason .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
local excluded = { "com.microsoft.java.test.runner-jar-with-dependencies.jar", "jacocoagent.jar" }
for _, jar in ipairs(vim.fn.glob(mason .. "/java-test/extension/server/*.jar", true, true)) do
  if not vim.tbl_contains(excluded, vim.fn.fnamemodify(jar, ":t")) then
    table.insert(bundles, jar)
  end
end

-- Java (jdtls) - Spring Boot with nvim-jdtls. Runs for every Java buffer;
-- start_or_attach reuses the running server for the same root_dir.
require("jdtls").start_or_attach({
  init_options = { bundles = bundles },
  cmd = {
    "jdtls",
    "--jvm-arg=-Djava.import.generatesMetadataFilesAtProjectRoot=false",
    "--jvm-arg=-Xmx8G",
    "--jvm-arg=-javaagent:" .. vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar",
  },
  root_dir = vim.fs.root(0, { "pom.xml", "build.gradle", ".git" }),
  settings = {
    java = {
      referencesCodeLens = { enabled = true },
      symbols = { includeSourceMethodDeclarations = true },
      contentProvider = { preferred = "fernflower" },
      sources = {
        organizeImports = { starThreshold = 9999 },
      },
      project = {
        sourceEncoding = "UTF-8",
        importOnType = true,
      },
      implementationsCodeLens = { enabled = true },
      inlayHints = {
        parameterNames = { enabled = "all" },
      },
      format = {
        enabled = true,
        comments = { enabled = false },
        tabSize = 4,
      },
    },
  },
})
