local jdtls = require("jdtls")

-- Installation location of jdtls by nvim-lsp-installer
local JDTLS_LOCATION = vim.fn.stdpath("data") .. "/lsp_servers/jdtls"

-- Data directory - change it to your liking
local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/workspace/java/"

-- Only for Linux and Mac
local SYSTEM = "linux"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    JDTLS_LOCATION .. "/config_" .. SYSTEM,
    "-data",
    workspace_dir,
  },

  capabilities = require("config.lsp").capabilities,
  root_dir = root_dir,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk/"
          },
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk/"
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/"
          },
          {
            name = "JavaSE-18",
            path = "/usr/lib/jvm/java-18-openjdk/"
          },
        },
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
    signatureHelp = {
      enabled = true,
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = {
      preferred = "fernflower"
    },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        startThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = {},
  },
  on_attach = require("config.lsp").on_attach
}

jdtls.start_or_attach(config)

require("jdtls.setup").add_commands()

vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
