local M = {}

-- Project root markers (common files that indicate project root)
local root_markers = {
  ".git",
  ".gitignore", 
  "requirements.txt",
  "pyproject.toml",
  "setup.py",
  "Pipfile",
  "poetry.lock",
  "package.json",
  "Cargo.toml",
  "go.mod",
  ".vscode",
  ".idea",
  "README.md",
  "Makefile"
}

-- Find project root by looking for common project files
function M.find_project_root(start_path)
  start_path = start_path or vim.fn.expand("%:p:h")
  
  -- If no file is open, use current working directory
  if start_path == "" then
    start_path = vim.fn.getcwd()
  end
  
  local current_dir = start_path
  
  -- Walk up the directory tree
  while current_dir ~= "/" and current_dir ~= "" do
    -- Check for root markers
    for _, marker in ipairs(root_markers) do
      local marker_path = current_dir .. "/" .. marker
      if vim.fn.isdirectory(marker_path) == 1 or vim.fn.filereadable(marker_path) == 1 then
        return current_dir
      end
    end
    
    -- Move up one directory
    local parent = vim.fn.fnamemodify(current_dir, ":h")
    if parent == current_dir then
      break -- Reached root
    end
    current_dir = parent
  end
  
  -- If no project root found, return the starting directory
  return start_path
end

-- Smart file creation logic
function M.create_file_smart(filename)
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.expand("%:p:h")
  local project_root = M.find_project_root()
  
  -- Determine where to create the file
  local target_dir
  
  -- If filename contains path separators, respect the full path
  if string.find(filename, "[/\\]") then
    -- Check if it's relative to project root
    if not string.match(filename, "^[A-Za-z]:[/\\]") and not string.match(filename, "^/") then
      target_dir = project_root
    else
      target_dir = ""
    end
  else
    -- Simple filename - decide based on context
    if current_file == "" then
      -- No file open, create in project root
      target_dir = project_root
    else
      -- File is open, create in same directory as current file
      target_dir = current_dir
    end
  end
  
  -- Construct full path
  local full_path
  if target_dir == "" then
    full_path = filename
  else
    full_path = target_dir .. "/" .. filename
  end
  
  -- Normalize path separators for Windows
  if vim.fn.has("win32") == 1 then
    full_path = string.gsub(full_path, "/", "\\")
  end
  
  -- Create directory if it doesn't exist
  local dir = vim.fn.fnamemodify(full_path, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
  
  -- Create and open the file
  vim.cmd("edit " .. full_path)
  
  -- Add basic templates based on file extension
  M.add_file_template(full_path)
  
  print("Created: " .. full_path)
  
  -- Refresh file tree
  vim.cmd("NvimTreeRefresh")
end

-- Add basic templates for common file types
function M.add_file_template(filepath)
  local ext = vim.fn.fnamemodify(filepath, ":e")
  local basename = vim.fn.fnamemodify(filepath, ":t:r")
  
  if ext == "py" then
    -- Python template
    local lines = {
      '"""',
      basename .. '.py',
      '"""',
      '',
      '',
      'def main():',
      '    pass',
      '',
      '',
      'if __name__ == "__main__":',
      '    main()',
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {6, 4}) -- Position cursor in main function
    
  elseif ext == "lua" then
    -- Lua template
    local lines = {
      'local M = {}',
      '',
      '',
      'return M',
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {2, 0})
    
  elseif ext == "md" then
    -- Markdown template
    local title = string.gsub(basename, "_", " ")
    title = string.gsub(title, "-", " ")
    local lines = {
      '# ' .. title,
      '',
      '',
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {3, 0})
    
  elseif ext == "js" or ext == "ts" then
    -- JavaScript/TypeScript template
    local lines = {
      '// ' .. basename .. '.' .. ext,
      '',
      '',
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {3, 0})
  end
end

-- Get relative path from project root
function M.get_relative_path(filepath)
  local project_root = M.find_project_root()
  local relative = string.gsub(filepath, "^" .. vim.pesc(project_root .. "/"), "")
  return relative
end

-- Quick project setup for Python
function M.setup_python_project(project_name)
  local project_dir = vim.fn.getcwd() .. "/" .. project_name
  
  -- Create project structure
  local dirs = {
    project_dir,
    project_dir .. "/src",
    project_dir .. "/tests",
    project_dir .. "/docs",
  }
  
  for _, dir in ipairs(dirs) do
    vim.fn.mkdir(dir, "p")
  end
  
  -- Create basic files
  local files = {
    {project_dir .. "/README.md", "# " .. project_name .. "\n\n"},
    {project_dir .. "/requirements.txt", "# Add your dependencies here\n"},
    {project_dir .. "/.gitignore", "__pycache__/\n*.pyc\n*.pyo\n*.egg-info/\ndist/\nbuild/\n.venv/\n.env\n"},
    {project_dir .. "/src/main.py", 'def main():\n    print("Hello, ' .. project_name .. '!")\n\nif __name__ == "__main__":\n    main()\n'},
    {project_dir .. "/tests/__init__.py", ""},
    {project_dir .. "/tests/test_main.py", "import unittest\n\nclass TestMain(unittest.TestCase):\n    def test_example(self):\n        self.assertTrue(True)\n"},
  }
  
  for _, file_data in ipairs(files) do
    local file_path, content = file_data[1], file_data[2]
    local f = io.open(file_path, "w")
    if f then
      f:write(content)
      f:close()
    end
  end
  
  -- Change to project directory and open it
  vim.cmd("cd " .. project_dir)
  vim.cmd("NvimTreeRefresh")
  vim.cmd("NvimTreeOpen")
  vim.cmd("edit " .. project_dir .. "/src/main.py")
  
  print("Created Python project: " .. project_name)
end

return M
