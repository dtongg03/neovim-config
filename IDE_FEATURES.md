# 🚀 Neovim IDE Configuration - Trải nghiệm như VSCode/Cursor

## 📋 Tổng quan
Cấu hình này biến Neovim thành một IDE hiện đại với tất cả các tính năng bạn yêu cầu:

## ✨ Tính năng chính

### 🗂️ File Explorer (Neo-tree)
- **F2** hoặc **Space+e**: Toggle file explorer
- **Space+o**: Focus vào file explorer
- File explorer hiện đại như VSCode với:
  - Icons đẹp mắt
  - Git status indicators
  - Drag & drop support
  - Context menu với right-click

### 📑 Tab Management (Bufferline)
- **Click chuột** để chuyển file
- **Click X** hoặc **middle-click** để đóng file
- **Right-click** để đóng file
- **Ctrl+Tab/Ctrl+Shift+Tab**: Chuyển tab như browser
- **Ctrl+W**: Đóng file hiện tại
- Hiển thị diagnostics (errors/warnings) trên tab
- Pin files quan trọng

### 🖥️ Window Resizing (Như IDE thật)
- **Ctrl+Arrow keys**: Resize từng chút (2 pixel)
- **Ctrl+Shift+Arrow keys**: Resize nhanh (5 pixel)
- **Mouse drag**: Kéo thả để resize cửa sổ
- **Space+w**: Window management commands
  - `wv`: Vertical split
  - `wh`: Horizontal split
  - `wc`: Close window
  - `wo`: Only this window
  - `w=`: Equalize windows

### 💻 Terminal Management
- **F4**: Toggle PowerShell terminal chính
- **Ctrl+`**: Quick terminal toggle
- **Space+t**: Terminal options
  - `tf`: Floating terminal
  - `tv`: Vertical terminal
  - `th`: Horizontal terminal
- **Tab**: Chuyển qua lại giữa editor và terminal
- **Esc**: Thoát terminal mode
- Terminal có thể resize tự do với mouse

### 🧭 Navigation & Breadcrumb
- **Winbar**: Hiển thị file path ở đầu mỗi window
- **Barbecue**: VSCode-like breadcrumb navigation
- **Treesitter Context**: Hiển thị function/class hiện tại
- **Space+f**: Find files (như Ctrl+P trong VSCode)

### 🔍 Search & Quick Actions
- **Ctrl+F**: Find files
- **Ctrl+Shift+F**: Search in files
- **Ctrl+P**: Quick file open (như VSCode)
- **Ctrl+Shift+P**: Command palette
- **Space+f**: File operations
  - `fr`: Recent files
  - `fb`: Buffer list
  - `fg`: Git files

### 💾 Session Management
- **Space+s**: Session commands
  - `ss`: Restore session
  - `sl`: Restore last session
  - `sd`: Don't save current session
- Auto-save khi mất focus (như IDEs)

### 🎨 UI Enhancements
- Modern theme (Catppuccin)
- Smooth animations
- Better notifications
- Mouse support hoàn toàn
- Hover effects trên tabs
- Diagnostic indicators
- Git status trong file explorer

## 🎯 Keyboard Shortcuts Summary

### Basic (như editors khác)
- **Ctrl+S**: Save
- **Ctrl+N**: New file
- **Ctrl+Q**: Quit
- **Ctrl+W**: Close file
- **Ctrl+F**: Find files
- **Ctrl+Shift+F**: Search in files

### File Explorer
- **F2**: Toggle Neo-tree
- **F3**: Open folder
- **Space+e**: Toggle explorer
- **Space+o**: Focus explorer

### Terminal
- **F4**: Toggle terminal
- **Ctrl+`**: Quick terminal
- **Tab**: Editor ↔ Terminal
- **Esc**: Exit terminal mode

### Window Management
- **Ctrl+H/J/K/L**: Navigate windows
- **Ctrl+Arrow**: Resize windows
- **Ctrl+Shift+Arrow**: Fast resize

### Buffer/Tab Management
- **Ctrl+Tab**: Next buffer
- **Ctrl+Shift+Tab**: Previous buffer
- **Shift+Tab**: Next buffer (alternative)

## 🔧 Advanced Features

### Auto-commands
- Restore cursor position khi mở file
- Highlight khi copy text
- Auto-save khi mất focus
- Smart file type detection

### Mouse Support
- Click để chuyển tab
- Right-click context menu
- Drag để resize windows
- Scroll trong tất cả panels

### Session Persistence
- Tự động save session
- Restore workspace khi restart
- Remember window layout
- Preserve terminal states

## 🚀 Getting Started

1. Restart Neovim để install plugins mới
2. Chờ plugins download xong
3. Restart lại một lần nữa
4. Enjoy your new IDE experience!

## 💡 Tips
- Sử dụng mouse thoải mái như trong IDE thật
- F2 để mở file explorer, F4 cho terminal
- Tab để chuyển qua lại editor và terminal
- Ctrl+P để mở file nhanh
- Click X trên tab để đóng file
- Resize windows bằng cách drag mouse hoặc Ctrl+Arrow

Chúc bạn coding vui vẻ! 🎉
