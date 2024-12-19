vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search hightlights" })

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", {desc = "Increment number"})
-- keymap.set("n", "<leader>-", "<C-x>", {desc = "Decrement number"})

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "close corrent split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "open current buffer in new tab" })
keymap.set("n", "<S-l>", "<cmd>tabn<CR>", { desc = "go to next tab" })
keymap.set("n", "<S-h>", "<cmd>tabp<CR>", { desc = "go to previous tab" })

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- setMove Lines
keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- commenting
keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
-- toggle terminal
-- Store terminal buffer number globally
local terminal_bufnr = nil

function _G.toggle_terminal()
  -- If terminal buffer doesn't exist, create it
  if terminal_bufnr == nil or not vim.api.nvim_buf_is_valid(terminal_bufnr) then
    vim.cmd("13split")
    vim.cmd("terminal")
    terminal_bufnr = vim.api.nvim_get_current_buf()
    -- Set buffer options
    vim.bo[terminal_bufnr].buflisted = false
    vim.bo[terminal_bufnr].modified = false
  else
    -- Find if terminal window is already open
    local terminal_win = nil
    for _, win in pairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == terminal_bufnr then
        terminal_win = win
        break
      end
    end

    if terminal_win then -- Terminal window is open, so close it
      vim.api.nvim_win_close(terminal_win, true)
    else -- Terminal window is not open, so open it
      vim.cmd("13split")
      vim.api.nvim_win_set_buf(0, terminal_bufnr)
    end
  end
end

-- Keybinding to toggle terminal
vim.keymap.set("n", "<leader>tt", _G.toggle_terminal, { noremap = true, silent = true })

-- Auto command to enter insert mode when switching to terminal
vim.cmd([[autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif]])

-- Exit terminal mode with ESC
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
