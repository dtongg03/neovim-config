local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- === BASIC OPERATIONS (Ctrl keys) ===
map({ "n", "i", "v" }, "<C-s>", ":w<CR>", opts)           -- Save
map("n", "<C-q>", ":qa<CR>", opts)                         -- Quit all
map("n", "<C-n>", ":enew<CR>", opts)                       -- New file

-- === WINDOW NAVIGATION (Ctrl+hjkl) ===
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- === SMART TAB NAVIGATION (Editor ↔ Terminal) ===
map("n", "<Tab>", function()
  -- Check if we're in a terminal buffer
  if vim.bo.buftype == "terminal" then
    -- We're in terminal, go back to last normal buffer
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype ~= "terminal" then
        local wins = vim.fn.win_findbuf(buf)
        if #wins > 0 then
          vim.api.nvim_set_current_win(wins[1])
          return
        end
      end
    end
  else
    -- We're in editor, jump to terminal
    local term_wins = vim.tbl_filter(function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      return vim.bo[buf].buftype == "terminal"
    end, vim.api.nvim_list_wins())
    
    if #term_wins > 0 then
      vim.api.nvim_set_current_win(term_wins[1])
      vim.cmd("startinsert")
    else
      -- No terminal open, open one
      vim.cmd("lua powershell_toggle()")
    end
  end
end, opts)

-- === BUFFER NAVIGATION (Shift+Tab for buffer switching) ===
map("n", "<S-Tab>", ":bnext<CR>", opts)                    -- Next buffer
map("n", "<C-w>", ":bdelete<CR>", opts)                    -- Close buffer

-- === FILE EXPLORER (F keys - easy to remember) ===
map("n", "<F2>", ":Neotree toggle<CR>", opts)              -- Toggle Neo-tree (main)
map("n", "<leader>e", ":Neotree toggle<CR>", opts)         -- Alternative toggle
map("n", "<leader>o", ":Neotree focus<CR>", opts)          -- Focus file tree
map("n", "<C-e>", ":NvimTreeToggle<CR>", opts)             -- Backup nvim-tree
map("n", "<F3>", function()                                 -- Open folder
  vim.ui.input({prompt = "Open folder: ", completion = "dir"}, function(path)
    if path then
      vim.cmd("cd " .. path)
      vim.cmd("Neotree refresh")
      vim.notify("Opened: " .. path, vim.log.levels.INFO)
    end
  end)
end, opts)

-- === SEARCH (Ctrl+F like other editors) ===
map("n", "<C-f>", ":Telescope find_files<CR>", opts)       -- Find files
map("n", "<C-S-f>", ":Telescope live_grep<CR>", opts)      -- Find in files

-- === WINDOW RESIZING (like IDEs) ===
-- Resize with Ctrl+Arrow keys
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Resize with Ctrl+Shift+Arrow keys (bigger steps)
map("n", "<C-S-Up>", ":resize +5<CR>", opts)
map("n", "<C-S-Down>", ":resize -5<CR>", opts)
map("n", "<C-S-Left>", ":vertical resize -5<CR>", opts)
map("n", "<C-S-Right>", ":vertical resize +5<CR>", opts)

-- Window management
map("n", "<leader>wv", ":vsplit<CR>", opts)                -- Vertical split
map("n", "<leader>wh", ":split<CR>", opts)                 -- Horizontal split
map("n", "<leader>wc", ":close<CR>", opts)                 -- Close window
map("n", "<leader>wo", ":only<CR>", opts)                  -- Only this window
map("n", "<leader>w=", "<C-w>=", opts)                     -- Equalize windows

-- === TERMINAL (Fixed Layout) ===
map({ "n", "t" }, "<F4>", function()
  -- Toggle PowerShell; place it as a vertical pane on the right of the explorer
  vim.cmd("lua powershell_toggle()")
  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_set_current_win(win)
        vim.cmd("wincmd L") -- move to far right
        -- Apply fixed width (2/8 screen) and lock it
        local desired = math.floor(vim.o.columns * 0.25)
        pcall(vim.api.nvim_win_set_width, win, desired)
        pcall(vim.api.nvim_set_option_value, "winfixwidth", true, { scope = "local", win = win })
        break
      end
    end
  end, 30)
end, opts)

-- Kill PowerShell quickly
map({ "n", "t" }, "<C-4>", function()
  if _G._powershell_kill then _G._powershell_kill() end
end, opts)

map("n", "<C-`>", function()
  -- Quick terminal toggle with layout fix
  vim.cmd("ToggleTerm")
  vim.defer_fn(function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_set_current_win(win)
        vim.cmd("wincmd J")
        break
      end
    end
  end, 50)
end, opts)

map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts)       -- Floating terminal (exception)
map("t", "<Esc>", [[<C-\><C-n>]], opts)                              -- Exit terminal mode
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)                       -- Navigate from terminal
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

-- === PYTHON DEVELOPMENT ===
map("n", "<F5>", function()                                -- Run Python file (F5 like IDEs)
  local file = vim.fn.expand("%:p")
  if file:match("%.py$") then
    vim.cmd("TermExec cmd='python \"" .. file .. "\"'")
  else
    vim.notify("Not a Python file", vim.log.levels.WARN)
  end
end, opts)

-- === SESSION MANAGEMENT (like IDEs) ===
map("n", "<leader>ss", function() require("persistence").load() end, opts)          -- Restore session
map("n", "<leader>sl", function() require("persistence").load({ last = true }) end, opts) -- Restore last session
map("n", "<leader>sd", function() require("persistence").stop() end, opts)         -- Don't save current session

-- === BUFFER MANAGEMENT (Enhanced) ===
map("n", "<C-Tab>", ":BufferLineCycleNext<CR>", opts)      -- Next buffer (like browsers)
map("n", "<C-S-Tab>", ":BufferLineCyclePrev<CR>", opts)    -- Previous buffer
map("n", "<leader>bp", ":BufferLineTogglePin<CR>", opts)   -- Pin buffer
map("n", "<leader>bP", ":BufferLineGroupClose ungrouped<CR>", opts) -- Close unpinned buffers
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", opts) -- Close other buffers
map("n", "<leader>br", ":BufferLineCloseRight<CR>", opts)  -- Close buffers to the right
map("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opts)   -- Close buffers to the left

-- === QUICK ACTIONS (IDE-like) ===
map("n", "<C-p>", ":Telescope find_files<CR>", opts)       -- Quick file open (like VSCode)
map("n", "<C-S-p>", ":Telescope commands<CR>", opts)       -- Command palette
map("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)    -- Recent files
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)     -- Buffer list
map("n", "<leader>fg", ":Telescope git_files<CR>", opts)   -- Git files

-- === DASHBOARD ===
map("n", "<leader>h", ":Alpha<CR>", opts)                  -- Show dashboard/home

-- === UTILITY COMMANDS ===
-- Clean swap files command
vim.api.nvim_create_user_command("CleanSwap", function()
  local swap_dir = vim.fn.stdpath("state") .. "/swap"
  if vim.fn.isdirectory(swap_dir) == 1 then
    vim.fn.delete(swap_dir, "rf")
    vim.notify("Swap files cleaned!", vim.log.levels.INFO)
  else
    vim.notify("No swap files to clean.", vim.log.levels.INFO)
  end
end, { desc = "Clean all swap files" })

-- Remove all the complex which-key stuff - keep it simple!


