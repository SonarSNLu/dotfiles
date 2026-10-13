return {
  {
    "jeryldev/pyworks.nvim",
    config = function()
      require("pyworks").setup()  -- See Configuration section for options
    end,
    lazy = false,
  },
}
