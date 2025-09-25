local M = {}

-- Workspace state lives here
local state = {
  root = nil,
  name = nil,
  type = nil, -- one of: git|python|nodejs|folder
  recent = {},
}

local json = vim.json or require('vim.json')

local function get_state_dir()
  return vim.fn.stdpath("state") .. "/ide_workspace"
end

local function get_history_path()
  return get_state_dir() .. "/workspace_history.json"
end

local function path_join(a, b)
  if a:sub(-1) == "/" or a:sub(-1) == "\\" then
    return a .. b
  end
  local sep = package.config:sub(1,1)
  return a .. sep .. b
end

local function path_exists(p)
  return vim.uv.fs_stat(p) ~= nil
end

local function has_file(dir, filename)
  return path_exists(path_join(dir, filename))
end

local function detect_type(root)
  if has_file(root, ".git") then return "git" end
  if has_file(root, "pyproject.toml") or has_file(root, "requirements.txt") or has_file(root, ".venv") then
    return "python"
  end
  if has_file(root, "package.json") then return "nodejs" end
  return "folder"
end

local function basename(p)
  if not p or p == "" then return "" end
  return vim.fn.fnamemodify(p, ":t")
end

local function ensure_dirs()
  local dir = get_state_dir()
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

local function load_history()
  local hist_path = get_history_path()
  if not path_exists(hist_path) then return {} end
  local ok, content = pcall(vim.fn.readfile, hist_path)
  if not ok or not content or #content == 0 then return {} end
  local joined = table.concat(content, "\n")
  local okj, data = pcall(vim.json.decode, joined)
  if not okj or type(data) ~= "table" then return {} end
  return data
end

local function save_history(items)
  ensure_dirs()
  local hist_path = get_history_path()
  local ok, encoded = pcall(vim.json.encode, items)
  if not ok then return end
  pcall(vim.fn.writefile, { encoded }, hist_path)
end

local function push_recent(path)
  if not path or path == "" then return end
  -- Deduplicate and keep last 15 entries
  local new_list, seen = {}, {}
  table.insert(new_list, path)
  seen[path] = true
  for _, item in ipairs(state.recent) do
    if not seen[item] then
      table.insert(new_list, item)
      seen[item] = true
    end
    if #new_list >= 15 then break end
  end
  state.recent = new_list
  save_history(state.recent)
end

local function apply_workspace(new_root)
  if not new_root or new_root == "" then return end
  vim.cmd("cd " .. vim.fn.fnameescape(new_root))
  state.root = new_root
  state.name = basename(new_root)
  state.type = detect_type(new_root)
  push_recent(new_root)
  -- Refresh file explorer if present
  pcall(function()
    vim.cmd("Neotree reveal left")
  end)
  -- Optional notification
  pcall(vim.notify, string.format("Workspace: %s (%s)", state.name or new_root, state.type or "folder"), vim.log.levels.INFO)
end

-- Public API

function M.get_current_workspace()
  if not state.root then
    -- Initialize from current working directory
    local cwd = vim.loop.cwd() or vim.fn.getcwd()
    state.root = cwd
    state.name = basename(cwd)
    state.type = detect_type(cwd)
    state.recent = load_history()
  end
  return { root = state.root, name = state.name, type = state.type }
end

function M.set_workspace_root()
  local function set_path(path)
    if path and path ~= "" then
      apply_workspace(path)
    end
  end

  if vim.ui and vim.ui.input then
    vim.ui.input({ prompt = "Set workspace root: ", completion = "dir" }, set_path)
  else
    local path = vim.fn.input("Set workspace root: ")
    set_path(path)
  end
end

function M.show_recent_workspaces()
  state.recent = state.recent and state.recent or load_history()
  if #state.recent == 0 then
    pcall(vim.notify, "No recent workspaces", vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, p in ipairs(state.recent) do
    table.insert(items, { text = string.format("%s  (%s)", p, detect_type(p)), path = p })
  end

  local function on_choice(choice)
    if choice and choice.path then
      apply_workspace(choice.path)
    end
  end

  if vim.ui and vim.ui.select then
    vim.ui.select(items, {
      prompt = "Recent workspaces",
      format_item = function(item) return item.text end,
    }, on_choice)
  else
    -- Fallback: pick the first
    on_choice(items[1])
  end
end

-- Track directory changes to keep state in sync
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    local cwd = vim.loop.cwd() or vim.fn.getcwd()
    if cwd ~= state.root then
      apply_workspace(cwd)
    end
  end,
})

return M


