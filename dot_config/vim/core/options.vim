" -----------------------------------------------------------------------------
"  Core Options
"  Author:      jessun.pro@gmail.com
"  Description: General editor behavior, performance tuning, and XDG file management.
"  Location:    ~/.config/vim/core/options.vim
" -----------------------------------------------------------------------------


" =============================================================================
" 01. General UI & Editing
" =============================================================================
" Encoding Detection:
" Try these encodings in order when reading a file.
" Essential for opening files with legacy encodings (like GBK/GB18030).
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8      " Default encoding for new files

" Tabline Display:
" Always show the tabline, even if there is only one tab.
" This keeps the UI consistent and prevents layout jumping.
set showtabline=2

" Enable mouse support in all modes.
" Useful for resizing splits or scrolling, even in a terminal.
set mouse=a

" Allow the editor to update the terminal window title.
set title

" Line Numbering: Hybrid mode.
" Shows absolute number for current line, relative for others.
" Crucial for efficient vertical motions (e.g., '10j' or '5k').
set number
set relativenumber

" Buffer Management:
" Allow hiding buffers with unsaved changes instead of forcing a write or error.
" Essential for a smooth workflow when switching between files.
set hidden

" Always show the sign column (left gutter) to prevent text shifting
" when git signs or linter errors appear.
set signcolumn=yes

" Window Splitting:
" Open new splits to the right and bottom, which feels more natural.
set splitright
set splitbelow

" Cursor line highlighting (Visual aid).
" Note: Can be disabled in 'Performance' section if rendering is slow.
set cursorline

" Visual Cues:
" Show invisible characters (tabs, trailing spaces) to detect formatting issues.
set list
set listchars=tab:\|\ ,trail:·,extends:»,precedes:«

" Disable default bracket matching highlighting to prevent cursor jumping/flickering.
set noshowmatch

" Command Line Height:
" Set to 2 lines to avoid 'Press ENTER' prompts for common messages.
set cmdheight=2
set showcmd

" Always show the status line (even if only one window is open).
set laststatus=2

" =============================================================================
" 02. Clipboard Integration
" =============================================================================
" Sync Vim's clipboard with the system clipboard.
" 'unnamedplus' uses the '+' register (standard on Linux/macOS).
" 'unnamed' uses the '*' register (standard on Windows).
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" =============================================================================
" 03. Formatting & Indentation
" =============================================================================
" Convert tabs to spaces. This is the de-facto standard for most modern codebases.
set expandtab

" Indentation dimensions: 4 spaces.
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Indentation Logic:
" - autoindent: Copy indent from previous line.
" - copyindent/preserveindent: Attempt to reuse existing whitespace structure.
" - nosmartindent: Disabled specifically to prevent conflicts with Python comments (#).
set autoindent
set copyindent
set preserveindent
set nosmartindent

" Text Wrapping:
" Disable hard wrapping (nowrap), but use 'breakindent' to visually indent
" wrapped long lines. This makes reading JSON or long HTML tags much easier.
set nowrap
set breakindent

" UX Constraints:
" - scrolloff: Keep the cursor vertically centered (999 lines padding).
" - sidescrolloff: Keep 5 columns of context when scrolling horizontally.
" - colorcolumn: Visual guide for the 80-character limit.
set scrolloff=999
set sidescrolloff=5
set colorcolumn=80

" Fix Backspace behavior to allow deleting over indents and line breaks.
set backspace=indent,eol,start

" =============================================================================
" 04. Search & Completion
" =============================================================================
" Search Behavior:
" - ignorecase + smartcase: Case insensitive unless capital letters are used.
" - incsearch: Show results while typing.
" - hlsearch: Highlight all matches.
set ignorecase
set smartcase
set incsearch
set hlsearch
set maxsearchcount=9999

" Tags Search Path:
" Look for specific tag files, searching upward (;) to the root.
set tags=./.tags;,.tags;,./tags;,tags;

" Completion Menu (Wildmenu):
" Enhance command-line tab completion (e.g., :e <Tab>).
" 'pum' enables the vertical popup menu instead of the horizontal list.
set completeopt=menu,menuone,noselect
set wildmenu
set wildmode=longest:full,full

" Use popup menu for wildmenu (Vim 8.2+ or Neovim)
if has('patch-8.2.1978') || has('nvim')
  set wildoptions+=pum
endif

" Ignore compiled files and version control folders in search/completion.
set wildignore+=*.o,*.obj,*.pyc,*.class
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" =============================================================================
" 05. Performance & Safety
" =============================================================================
" Terminal Acceleration
set ttyfast
" Eliminate Escape key delay (10ms)
set ttimeout
set ttimeoutlen=10

" Reduce redraw frequency during macros/scripts for speed.
set lazyredraw

" Faster update time (100ms) for better GitGutter/LSP responsiveness.
" Default is 4000ms, which makes the UI feel sluggish.
set updatetime=100

" Memory Limits (Generous limits for modern machines)
set history=10000
set maxmem=1000000
set maxmemtot=2000000
set maxmempattern=20000

" Tmux/Terminal Fix:
" Disable Background Color Erase (BCE). Solves the 'ghosting' or wrong background
" color issues often seen in tmux or GNU screen.
set t_ut=

" Security:
" Prevent Vim from executing arbitrary code found in files (modelines).
set nomodeline
set nomodelineexpr
set secure

" Auto-save triggers:
" Write files when toggling buffers or compiling/making.
set autowrite
set writebackup
set noautowriteall

" =============================================================================
" 06. File Management (XDG Standards)
" =============================================================================
" Centralize Swap, Undo, and Backup files.
" This keeps your project directories clean and prevents polluting Git repos.

let s:state_dir = expand('$HOME/.local/state/vim')

" Ensure the directory exists
if !isdirectory(s:state_dir)
  call mkdir(s:state_dir, "p", 0700)
endif

" 1. Swap Files (// ends path to ensure unique filenames)
let &directory = s:state_dir . '/swap//'
if !isdirectory(&directory) | call mkdir(&directory, "p", 0700) | endif

" 2. Undo History (Persistent undo across restarts)
if has("persistent_undo")
  let &undodir = s:state_dir . '/undo//'
  if !isdirectory(&undodir) | call mkdir(&undodir, "p", 0700) | endif
  set undofile
endif

" 3. Backups (Disabled in favor of Git)
set nobackup

" =============================================================================
" 07. Logic & AutoCommands
" =============================================================================
" Folding: Indent-based folding is the most reliable for pure Vim.
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99

" Auto-read: Detect if the file was changed externally (e.g., by git checkout).
set autoread

augroup CoreAutoCmds
  autocmd!

  " Force check for external changes when gaining focus or switching buffers.
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

  " Enable relative numbers when entering Normal mode or gaining focus.
  " Checks if 'number' is enabled first to avoid affecting special buffers (like Help).
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != 'i' | set relativenumber | endif

  " Switch to absolute numbers when entering Insert mode or losing focus.
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif

  " Auto-create parent directories on save
  autocmd BufWritePre *
      \ if !isdirectory(expand("<afile>:p:h")) |
      \   call mkdir(expand("<afile>:p:h"), "p") |
      \ endif

  " Restore Cursor Position:
  " Jump to the last known cursor position when reopening a file.
  " Logic:
  " 1. line("'\"") > 1 : Last position is valid (not top of file).
  " 2. ... <= line("$") : Last position is within current file limits.
  " 3. &ft !~# 'commit' : Do NOT jump if it's a git commit message (start at top).
  autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g'\""
      \ | endif

  " Automatically rebalance window splits when the host terminal is resized.
  autocmd VimResized * wincmd =

  " Force help documentation to open in a vertical split (right side).
  "   " optimized for modern wide-screen displays.
  autocmd FileType help wincmd L

  " Map 'q' to close ephemeral buffers (Help, QuickFix, Netrw, Man pages) immediately.
  autocmd FileType help,qf,netrw,man nnoremap <buffer> <silent> q :close<CR>

augroup END

  " old version
  " autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" =============================================================================
" End of file
" =============================================================================
