return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        stylua = {
          append_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
          },
        },
      },
    },
  },
}
