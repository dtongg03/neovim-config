local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Font and appearance (IDE-like)
o.guifont = "JetBrains Mono:h12"
o.termguicolors = true
o.number = true
o.relativenumber = true
wo.signcolumn = "yes"
o.cursorline = true
o.cursorcolumn = false -- Only show cursor line, not column
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8
o.colorcolumn = "80" -- Show column guide

-- Mouse support (essential for IDE experience)
o.mouse = "a" -- Enable mouse in all modes
o.mousemodel = "popup" -- Right click for context menu

-- Better UI
o.cmdheight = 1
o.pumheight = 10 -- Popup menu height
o.showmode = false -- Don't show mode (lualine shows it)
o.showtabline = 2 -- Always show tabline
o.laststatus = 3 -- Global statusline
o.winbar = "%f" -- Show filename in winbar

o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true

o.clipboard = "unnamedplus"
o.updatetime = 250
o.timeoutlen = 400

o.splitright = true
o.splitbelow = true

-- Swap file and backup settings (prevent E325 errors)
o.swapfile = false -- Disable swap files to prevent E325 errors
o.backup = false   -- Disable backup files
o.writebackup = false -- Disable backup before writing
o.undofile = true  -- Enable persistent undo instead
o.undodir = vim.fn.stdpath("data") .. "/undo" -- Set undo directory

-- Windows shell: use PowerShell if available
if vim.fn.has("win32") == 1 then
  if vim.fn.executable("pwsh") == 1 then
    o.shell = "pwsh"
  else
    o.shell = "powershell"
  end
  o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  o.shellquote = ""
  o.shellxquote = ""
  o.shellpipe = "| Out-File -Encoding UTF8 %s"
  o.shellredir = "> %s 2>&1"
end


