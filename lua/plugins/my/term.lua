function _G.toggle_terminal()
  -- If terminal buffer doesn't exist, create it
  if terminal_bufnr == nil or not vim.api.nvim_buf_is_valid(terminal_bufnr) then
    vim.cmd '13split'
    vim.cmd 'terminal'
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
      vim.cmd '13split'
      vim.api.nvim_win_set_buf(0, terminal_bufnr)
    end
  end
end

-- Keybinding to toggle terminal
vim.keymap.set('n', '<C-t>', _G.toggle_terminal, { noremap = true, silent = true })

-- Auto command to enter insert mode when switching to terminal
vim.cmd [[autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif]]

-- Exit terminal mode with ESC
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
