vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.plugins")

-- Auto-open Alpha dashboard if no files provided
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Simple check: if no arguments and current buffer is empty
    if vim.fn.argc() == 0 then
      local buf = vim.api.nvim_get_current_buf()
      local name = vim.api.nvim_buf_get_name(buf)
      if name == "" then
        -- Delay to ensure plugins are loaded
        vim.defer_fn(function()
          vim.cmd("Alpha")
        end, 1)
      end
    end
  end,
})


