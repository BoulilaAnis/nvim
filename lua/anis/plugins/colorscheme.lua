return{
  "ellisonleao/gruvbox.nvim", priority = 1000 , config = true,
  config = function()
    require("gruvbox").setup({
      contrast = "hard"
    })
    vim.cmd("colorscheme gruvbox")
  end
}
