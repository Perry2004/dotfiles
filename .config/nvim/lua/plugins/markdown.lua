return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft["markdown"] = false
      return opts
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      return {}
    end,
  },
}
