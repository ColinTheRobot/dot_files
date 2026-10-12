vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

-- Java (jdtls) - Spring Boot with nvim-jdtls. Runs for every Java buffer;
-- start_or_attach reuses the running server for the same root_dir.
require("jdtls").start_or_attach({
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
      contentProvider = { preferred = "fernflower" },
      sources = {
        organizeImports = { starThreshold = 9999 },
      },
      project = {
        sourceEncoding = "UTF-8",
        importOnType = true,
      },
      implementationsCodeLens = { enabled = true },
      format = {
        enabled = true,
        comments = { enabled = false },
        tabSize = 4,
      },
    },
  },
})
