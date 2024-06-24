return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      config_path = vim.fn.expand("~/.config/codeium/config.json"),
      enable_chat = true,
    })
  end,
}
