-- See https://github.com/LazyVim/LazyVim/discussions/4783#discussioncomment-11249776

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      basedpyright = {
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json", -- last
          ".git",
        },
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "strict",
              diagnosticSeverityOverrides = {
                reportMissingTypeStubs = false,
              },
            },
          },
        },
      },
      buf_ls = {},
      clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
      },
      dockerls = {
        settings = {
          dockerls = {
            root_markers = { "Dockerfile-" },
          },
        },
      },
      gopls = {
        init_options = {
          semanticTokens = true,
        },
        settings = {
          gopls = {
            analyses = {
              ST1000 = false,
              ST1020 = false,
              ST1021 = false,
            },
          },
        },
      },
    },
  },
}
