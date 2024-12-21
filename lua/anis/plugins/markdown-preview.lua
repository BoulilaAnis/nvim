return {
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   config = function()
  --     local keymap = vim.keymap
  --     keymap.set("n", "<C-m>", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" }) -- toggle file explorer
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      local keymap = vim.keymap
      keymap.set("n", "<C-m>", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })
    end,
  },
}
