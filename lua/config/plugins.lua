-- Disable netrw for file explorers
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set up notifications
vim.notify = require("notify")

-- Catppuccin theme setup
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { light = "latte", dark = "mocha" },
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = { comments = { "italic" }, conditionals = { "italic" } },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = { enabled = true, indentscope_color = "" },
  },
})
vim.cmd.colorscheme "catppuccin"

-- Neo-tree (Modern File Explorer like VSCode - Fixed Left Position)
require("neo-tree").setup({
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = false,
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = nil,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "ﰊ",
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "",
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },
  window = {
    position = "left",
    width = 35,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = { 
        "toggle_node", 
        nowait = false,
      },
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "revert_preview",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["l"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["a"] = { 
        "add",
        config = {
          show_path = "none"
        }
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    }
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true,
      hide_by_name = {
        "node_modules"
      },
      hide_by_pattern = {
        "*.meta",
        "*/src/*/tsconfig.json",
      },
      always_show = {
        ".gitignored",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db"
      },
      never_show_by_pattern = {
        ".null-ls_*",
      },
    },
    follow_current_file = {
      enabled = false,
      leave_dirs_open = false,
    },
    group_empty_dirs = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = false,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      }
    }
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      }
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"]  = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      }
    }
  }
})

-- Nvim-tree (Backup File Explorer)
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", "__pycache__" },
  },
  git = {
    enable = true,
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
})

-- Bufferline (Enhanced tabs like VSCode)
require("bufferline").setup({
  options = {
    mode = "buffers",
    themable = true,
    separator_style = "thin", -- More modern look
    always_show_bufferline = true, -- Always show tabs
    show_buffer_close_icons = true,
    show_close_icon = true, -- Show close icon on the right
    show_tab_indicators = true,
    color_icons = true,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    -- Enhanced click behavior
    left_mouse_command = function(bufnr)
      local buftype = vim.bo[bufnr].buftype
      if buftype == "terminal" then
        vim.cmd("bdelete! " .. bufnr)
      else
        vim.cmd("buffer " .. bufnr)
      end
    end,
    right_mouse_command = function(bufnr)
      -- Right click to close buffer
      vim.cmd("bdelete " .. bufnr)
    end,
    middle_mouse_command = function(bufnr)
      -- Middle click to close buffer (like browsers)
      vim.cmd("bdelete " .. bufnr)
    end,
    -- Offsets for file explorers
    offsets = {
      { 
        filetype = "neo-tree", 
        text = "📁 File Explorer", 
        text_align = "center", 
        separator = true 
      },
      { 
        filetype = "NvimTree", 
        text = "📁 File Explorer", 
        text_align = "center", 
        separator = true 
      }
    },
    -- Custom areas
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
        local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
        local info = #vim.diagnostic.get(0, {severity = seve.INFO})
        local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

        if error ~= 0 then
          table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
        end

        if warning ~= 0 then
          table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
        end

        if hint ~= 0 then
          table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
        end

        if info ~= 0 then
          table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
        end
        return result
      end,
    },
    -- Hover effects
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    -- Groups disabled temporarily to avoid compatibility issues
    -- groups = {}
  },
  highlights = {
    buffer_selected = {
      bold = true,
      italic = false,
    },
    diagnostic_selected = {
      bold = true,
    },
    info_selected = {
      bold = true,
    },
    info_diagnostic_selected = {
      bold = true,
    },
    warning_selected = {
      bold = true,
    },
    warning_diagnostic_selected = {
      bold = true,
    },
    error_selected = {
      bold = true,
    },
    error_diagnostic_selected = {
      bold = true,
    },
  }
})

-- Statusline (Enhanced)
require("lualine").setup({
  options = {
    theme = "catppuccin",
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "alpha", "neo-tree" },
      winbar = { "alpha", "neo-tree", "toggleterm" },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { 
      "branch", 
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " }
      },
      {
        "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = " " }
      }
    },
    lualine_c = { 
      {
        "filename",
        file_status = true,
        newfile_status = false,
        path = 1, -- Show relative path
        symbols = {
          modified = '[+]',
          readonly = '[-]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
      }
    },
    lualine_x = { 
      {
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = '#ffffff', gui = 'bold' },
      },
      "encoding", 
      "fileformat", 
      "filetype" 
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 
      {
        "filename",
        path = 1,
        symbols = {
          modified = ' ●',
          readonly = '',
          unnamed = '',
        }
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 
      {
        "filename",
        path = 1,
        symbols = {
          modified = ' ●',
          readonly = '',
          unnamed = '',
        }
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
})

-- Barbecue (VSCode-like breadcrumb)
require("barbecue").setup({
  create_autocmd = false, -- prevent barbecue from updating itself automatically
  attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
  show_dirname = true,
  show_basename = true,
  show_modified = true,
  modified = function(bufnr) return vim.bo[bufnr].modified end,
  ellipsis = true,
  exclude_filetypes = { "netrw", "toggleterm", "alpha", "neo-tree" },
  modifiers = {
    dirname = ":~:.",
    basename = "",
  },
  symbols = {
    modified = "●",
    ellipsis = "…",
    separator = "",
  },
  kinds = {
    File = "",
    Module = "",
    Namespace = "",
    Package = "",
    Class = "",
    Method = "",
    Property = "",
    Field = "",
    Constructor = "",
    Enum = "",
    Interface = "",
    Function = "",
    Variable = "",
    Constant = "",
    String = "",
    Number = "",
    Boolean = "◩",
    Array = "",
    Object = "",
    Key = "",
    Null = "ﳠ",
    EnumMember = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  },
})

-- Window Management
require("windows").setup({
  autowidth = {
    enable = false,
    winwidth = 5,
    filetype = {
      help = 2,
    },
  },
  ignore = {
    buftype = { "quickfix", "terminal" },
    filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "toggleterm" }
  },
  animation = {
    enable = true,
    duration = 300,
    fps = 30,
    easing = "in_out_sine"
  }
})

-- Auto-update barbecue
vim.api.nvim_create_autocmd({
  "WinScrolled",
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})

-- Telescope with file browser
require("telescope").setup({
  defaults = {
    layout_config = { horizontal = { preview_width = 0.55 } },
    file_ignore_patterns = { "%.git/", "node_modules/", "__pycache__/" },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = false,
      mappings = {
        ["i"] = {},
        ["n"] = {},
      },
    },
  },
})
require("telescope").load_extension("file_browser")

-- Oil.nvim (file manager like vim-vinegar)
require("oil").setup({
  default_file_explorer = false,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  delete_to_trash = false,
  skip_confirm_for_simple_edits = false,
  prompt_save_on_select_new_entry = true,
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    timeout_ms = 1000,
    autosave_changes = false,
  },
  constrain_cursor = "editable",
  experimental_watch_for_changes = false,
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = true,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },
})

-- Treesitter (disabled auto-install due to missing C compiler)
require("nvim-treesitter.configs").setup({
  ensure_installed = {}, -- Empty to avoid auto-install
  highlight = { enable = true },
  indent = { enable = true },
})

-- Fidget (LSP status)
require("fidget").setup({})

-- Indent guides
require("ibl").setup({
  indent = { char = "│", tab_char = "│" },
  scope = { enabled = false },
})

-- Completion
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
  snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item() else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
      before = function(entry, vim_item)
        return vim_item
      end,
    }),
  },
})

-- Conform (formatter)
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format", "black" },
    lua = { "stylua" },
  },
})

-- Toggleterm (Fixed layout - always at bottom)
require("toggleterm").setup({
  open_mapping = [[<C-`>]],
  direction = "horizontal", -- Always horizontal at bottom
  size = function(term)
    return math.floor(vim.o.lines * 0.25) -- Fixed 25% of screen height
  end,
  shade_terminals = false,
  start_in_insert = true,
  close_on_exit = false,
  persist_size = false,
  persist_mode = true,
  auto_scroll = true,
  insert_mappings = true,
  terminal_mappings = true,
  shell = (function()
    if vim.fn.executable("pwsh") == 1 then return "pwsh" end
    return "powershell"
  end)(),
  float_opts = {
    border = "curved",
    winblend = 0,
    width = function()
      return math.floor(vim.o.columns * 0.8)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.8)
    end,
  },
  winbar = {
    enabled = true,
    name_formatter = function(term)
      -- Add a clickable Kill button for the main PowerShell terminal (id=1)
      if term and term.id == 1 then
        -- %@v:lua.fn@ ... %T creates a clickable region which calls fn()
        return string.format(" 💻 PowerShell %d  %%@v:lua._powershell_kill@✖ Kill%%T ", term.id)
      end
      return string.format(" 💻 PowerShell %d ", term and term.id or 0)
    end
  },
  -- Fixed position settings
  on_create = function(term)
    vim.opt_local.mouse = "a"
    -- Ensure terminal stays at bottom
    if term.direction == "horizontal" then
      vim.cmd("wincmd J") -- Move to bottom
    end
  end,
  -- Do not force reposition on open; we'll control placement from our toggle function
  on_open = nil,
  -- Custom highlights
  highlights = {
    Normal = {
      guibg = "NONE",
    },
    NormalFloat = {
      link = 'Normal'
    },
    FloatBorder = {
      guifg = "#89b4fa",
      guibg = "NONE",
    },
  },
})

-- Create persistent terminals
local Terminal = require("toggleterm.terminal").Terminal

-- PowerShell terminal (always available)
local powershell = Terminal:new({
  cmd = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
  direction = "vertical",
  size = function()
    -- Fixed 2/8 (25%) of screen width
    return math.floor(vim.o.columns * 0.25)
  end,
  count = 1,
  id = 1,
  display_name = "Kill this shell",
  on_open = function(term)
    -- Move the terminal to the far right and lock width
    vim.defer_fn(function()
      if term and term.window then
        vim.api.nvim_set_current_win(term.window)
        vim.cmd("wincmd L")
        -- Set fixed width and prevent auto-equalize
        local desired = math.floor(vim.o.columns * 0.25)
        pcall(vim.api.nvim_win_set_width, term.window, desired)
        pcall(vim.api.nvim_set_option_value, "winfixwidth", true, { scope = "local", win = term.window })
      end
    end, 20)
  end,
})

-- Floating terminal
local float_term = Terminal:new({
  direction = "float",
  count = 2,
  id = 2,
  display_name = "Kill this shell",
})

-- Python REPL terminal
local python_repl = Terminal:new({
  cmd = "python",
  direction = "horizontal",
  count = 3,
  id = 3,
  display_name = "Kill this shell",
})

-- Make terminals globally accessible
_G.powershell_toggle = function() powershell:toggle() end
_G.float_term_toggle = function() float_term:toggle() end
_G.python_repl_toggle = function() python_repl:toggle() end

-- Global kill handler for the main PowerShell terminal (clickable in winbar)
_G._powershell_kill = function()
  if not powershell then return end
  -- Try to stop the underlying job if exposed
  pcall(function()
    if powershell.job_id then
      vim.fn.jobstop(powershell.job_id)
    end
  end)
  -- Close terminal window/buffer
  pcall(function() powershell:shutdown() end)
  pcall(function() powershell:close() end)
  -- As a fallback, try bdelete on the buffer
  pcall(function()
    if powershell.bufnr and vim.api.nvim_buf_is_valid(powershell.bufnr) then
      vim.api.nvim_buf_delete(powershell.bufnr, { force = true })
    end
  end)
  pcall(vim.notify, "PowerShell killed", vim.log.levels.INFO)
end

-- Mason and LSP (Updated for Neovim 0.11+)
require("mason").setup()
require("mason-lspconfig").setup({ 
  ensure_installed = { "pyright", "ruff" },
  handlers = {
    -- Default handler for installed servers
    function(server_name)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use the new vim.lsp.config API
      if vim.lsp.config then
        -- New API for Neovim 0.11+
        vim.lsp.config[server_name] = {
          capabilities = capabilities,
          settings = server_name == "ruff" and { args = {} } or nil,
        }
      else
        -- Fallback to old lspconfig for older Neovim versions
        local lspconfig = require("lspconfig")
        if server_name == "ruff" then
          lspconfig[server_name].setup({ 
            capabilities = capabilities, 
            init_options = { settings = { args = {} } } 
          })
        else
          lspconfig[server_name].setup({ capabilities = capabilities })
        end
      end
    end,
  }
})

-- Global keymaps for LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local bufmap = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr }) end
    bufmap("n", "gd", vim.lsp.buf.definition)
    bufmap("n", "gr", vim.lsp.buf.references)
    bufmap("n", "K", vim.lsp.buf.hover)
    bufmap("n", "<leader>rn", vim.lsp.buf.rename)
    bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
    bufmap("n", "<leader>f", function() require("conform").format({ async = true }) end)
  end,
})

-- Alpha (dashboard) with custom header
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  "",
  "        ██████╗ ██╗   ██╗ ██████╗ ███╗   ██╗ ██████╗ ",
  "        ██╔══██╗██║   ██║██╔═══██╗████╗  ██║██╔════╝ ",
  "        ██║  ██║██║   ██║██║   ██║██╔██╗ ██║██║  ███╗",
  "        ██║  ██║██║   ██║██║   ██║██║╚██╗██║██║   ██║",
  "        ██████╔╝╚██████╔╝╚██████╔╝██║ ╚████║╚██████╔╝",
  "        ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ",
  "",
  "            ████████╗ ██████╗ ███╗   ██╗ ██████╗ ",
  "            ╚══██╔══╝██╔═══██╗████╗  ██║██╔════╝ ",
  "               ██║   ██║   ██║██╔██╗ ██║██║  ███╗",
  "               ██║   ██║   ██║██║╚██╗██║██║   ██║",
  "               ██║   ╚██████╔╝██║ ╚████║╚██████╔╝",
  "               ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ",
  "",
}
dashboard.section.header.opts = dashboard.section.header.opts or {}
dashboard.section.header.opts.hl = "Title"
dashboard.section.buttons.val = {
  dashboard.button("n", "  New file", ":ene | startinsert\n"),
  dashboard.button("f", "  Find file", ":Telescope find_files\n"),
  dashboard.button("r", "  Recent", ":Telescope oldfiles\n"),
  dashboard.button("t", "  Toggle PowerShell", ":ToggleTerm direction=horizontal\n"),
  dashboard.button("q", "  Quit", ":qa\n"),
}
-- Simple layout without shortcuts
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 2 },
}

dashboard.section.footer.val = "🐍 Happy Python Coding with Neovim! 🚀"

-- Configure Alpha to auto-start
dashboard.opts.opts = {
  noautocmd = false,
}

alpha.setup(dashboard.config)

-- Hide tabline on dashboard, show when leaving
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    vim.opt.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "alpha",
  callback = function()
    vim.opt.showtabline = 2
  end,
})

-- Auto-show dashboard when no files are open
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    -- Wait a bit for the buffer to be deleted
    vim.defer_fn(function()
      local bufs = vim.api.nvim_list_bufs()
      local valid_bufs = 0
      
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
          local name = vim.api.nvim_buf_get_name(buf)
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          -- Count valid buffers (not empty, not special filetypes)
          if name ~= "" or (ft ~= "" and ft ~= "alpha") then
            valid_bufs = valid_bufs + 1
          end
        end
      end
      
      -- If no valid buffers remain, show dashboard
      if valid_bufs == 0 then
        vim.cmd("Alpha")
      end
    end, 10)
  end,
})

-- Dashboard will be handled by init.lua VimEnter autocmd

-- Session Management (like IDEs)
require("persistence").setup({
  dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
  options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }
})

-- Treesitter Context (show current function/class)
require("treesitter-context").setup({
  enable = true,
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})

-- Enhanced Telescope setup
require("telescope").setup({
  defaults = {
    layout_config = { 
      horizontal = { 
        preview_width = 0.55,
        width = 0.87,
        height = 0.80,
      } 
    },
    file_ignore_patterns = { "%.git/", "node_modules/", "__pycache__/" },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
      n = {
        ["<C-h>"] = "which_key",
      }
    }
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = false,
      mappings = {
        ["i"] = {},
        ["n"] = {},
      },
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({})
    }
  },
})
require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")

-- Better notifications
require("notify").setup({
  background_colour = "#000000",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 3000,
  top_down = true
})

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

-- Auto-commands for better IDE experience
local augroup = vim.api.nvim_create_augroup("IDEExperience", { clear = true })

-- Removed aggressive auto-reposition autocmds to avoid layout conflicts

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Auto-save when focus is lost (like IDEs)
vim.api.nvim_create_autocmd("FocusLost", {
  group = augroup,
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! wall")
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Handle swap file recovery gracefully
vim.api.nvim_create_autocmd("SwapExists", {
  group = augroup,
  callback = function()
    vim.v.swapchoice = "o" -- Always open read-only if swap exists
    vim.notify("Swap file detected. Opening in read-only mode.", vim.log.levels.WARN)
  end,
})


