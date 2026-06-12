return {
  "stevearc/conform.nvim",
  optional = true,
  opts = function(_, opts)
    opts.formatters = {
      sqlfluff = {
        args = { "format", "-" },
      },
      stylua = {
        append_args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
        },
      },
    }
  end,
}
