" -----------------------------------------------------------------------------
"  Plugins & Mappings
"  Author:      jessun.pro@gmail.com
"  Description: All-in-one file for Plugin Management, Settings, and Keybindings.
"  Location:    ~/.config/vim/core/plugins.vim
" -----------------------------------------------------------------------------


" =============================================================================
" 01. Bootstrap Logic (XDG Compliant)
" =============================================================================

" Coc.nvim Settings
" reset coc.nvim config and data directory
let g:coc_config_home = expand('~/.config/vim')
let g:coc_data_home = expand('~/.local/share/vim/coc')

" Define the data directory for plugins (separate from config).
let s:data_dir = expand('~/.local/share/vim')
execute 'set runtimepath+=' . s:data_dir
" Define the path for the plugin manager script.
let s:plug_script = s:data_dir . '/autoload/plug.vim'

" Check if vim-plug is installed. If not, download it automatically.
if empty(glob(s:plug_script))
  echo "Installing Vim-Plug to XDG data directory..."
  execute 'silent !curl -fLo ' . s:plug_script . ' --create-dirs ' .
      \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  
  " Reload paths to ensure Vim recognizes the new script immediately.
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" =============================================================================
" 02. Plugin List
" =============================================================================
" Install plugins to ~/.local/share/vim/plugged
call plug#begin(s:data_dir . '/plugged')

" --- Basics & Essentials ---
" A collection of language packs (syntax/indent) loaded on demand.
Plug 'sheerun/vim-polyglot'
" A universal set of defaults that everyone can agree on.
Plug 'tpope/vim-sensible'
" Comment stuff out with 'gcc' or 'gc'.
Plug 'tpope/vim-commentary'
" Auto-detect indent settings (tabs vs spaces)
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" --- UI & Themes ---
" Status line (Configuration in ui/lightline.vim).
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'mengelbrecht/lightline-bufferline'
" Display marks in the sign column
" Workflow: use `or' to jump to the word or line
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-peekaboo'
" Theme 
Plug 'nordtheme/vim'

" --- Fuzzy Finding (FZF) ---
" The core fzf binary.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Vim integration for fzf.
Plug 'junegunn/fzf.vim'

" --- Search & Replace ---

" --- Intellisense (LSP) ---
" The engine (Configuration in coc/config.vim).
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
" FZF integration for Coc (symbols, diagnostics).

" --- Temporarily Disabled ---
"Plug 'Yggdroot/indentLine'
"Plug 'junegunn/vim-easy-align'
"Plug 'justinmk/vim-sneak'
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

" --- We have better choice ---
"Plug 'airblade/vim-gitgutter'
"Plug 'farmergreg/vim-lastplace'
"Plug 'preservim/nerdtree'
"Plug 'preservim/tagbar'
"Plug 'dyng/ctrlsf.vim'
"
"Plugin 'puremourning/vimspector'
" TESTING:
call plug#end()

" --- Coc.nvim plugins ---
let g:coc_global_extensions = [ 
            \ 'coc-dictionary', 
            \ 'coc-emoji',
            \ 'coc-explorer',
            \ 'coc-extension-codemod',
            \ 'coc-git',
            \ 'coc-go',
            \ 'coc-highlight',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-lua',
            \ 'coc-marketplace',
            \ 'coc-rust-analyzer',
            \ 'coc-snippets',
            \ 'coc-spell-checker',
            \ 'coc-syntax',
            \ 'coc-tag',
            \ 'coc-translator',
            \ 'coc-vimlsp',
            \ 'coc-word',
            \ 'coc-yank',
            \]

" =============================================================================
" 03. General Plugin Settings
" =============================================================================
" -- Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" --- Polyglot Settings ---
" Enable syntax highlighting for embedded languages in Markdown.
let g:markdown_fenced_languages = ['vim', 'help', 'json', 'python', 'bash', 'go', 'rust']

" --- FZF Settings ---
" Ensure the dictionary exists to avoid errors
if !exists('g:fzf_vim') | let g:fzf_vim = {} | endif
let g:fzf_vim.preview_window = ['up,60%', 'ctrl-/']
let g:fzf_vim.tags_command = 'ctags -f .tags -R .'

" Auto-open Quickfix window
" Sometimes FZF fills the list but doesn't open the window.
" This autocmd ensures the window pops up immediately after populating.
augroup FZFCmds
  autocmd!
  autocmd QuickFixCmdPost *[^l] cwindow
  autocmd QuickFixCmdPost l* lwindow

  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" -----------------------------------------------------------------------------
" Workflow: Batch Refactoring via FZF & Quickfix
" -----------------------------------------------------------------------------
" 1. Search: Run `:Rg OldName` to find matches.
" 2. Select: Inside FZF, use <Tab> to multi-select items or <Alt-a> to select all.
" 3. Export: Press <Enter> to populate the Quickfix list with selections.
" 4. Action: Execute the batch replacement command:
"    :cdo s/OldName/NewName/g | update

" Layout: Open FZF in a floating window (requires Vim 8.2+ or Neovim).
let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'yoffset': 1.0 } }

" History: Save command history to a persistent file.
let g:fzf_history_dir = expand('~/.local/state/fzf-history')

" Colors: Match FZF colors to the current Vim color scheme.
let $FZF_DEFAULT_OPTS = '--bind ctrl-n:down,ctrl-p:up'
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }


" --- Coc.nvim Settings ---
" Source coc.nvim default config
call SourceIfExists([expand(g:plug_home . '/coc.nvim/doc/coc-example-config.vim')])
autocmd CursorHold * silent call CocActionAsync('highlight')

" =============================================================================
" 02. General Key Mappings
" ============================================================================= 

" --- Coc.nvim ---
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" multiple cursors
nmap <expr> <silent> <C-x> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

noremap <silent><nowait> <leader>ce <Cmd>CocCommand explorer<CR>
noremap <silent><nowait> <leader>cd :<C-u>CocList --auto-preview diagnostics<cr>  
noremap <silent><nowait> <leader>cc :CocList commands<CR>
noremap <silent><nowait> <leader>c/ :<C-u>CocList --interactive --auto-preview grep<CR>
xmap <silent> <leader>cm :CocList maps<CR>
nmap <silent> <leader>cm :CocList maps<CR>
xmap <silent> <leader>ck :CocList marks<CR>
nmap <silent> <leader>ck :CocList marks<CR>
xmap <silent> <leader>cf :<C-u>CocList --auto-preview files<CR>
nmap <silent> <leader>cf :<C-u>CocList --auto-preview files<CR>
xmap <silent> <leader>cb :CocList --auto-preview buffers<CR>
nmap <silent> <leader>cb :CocList --auto-preview buffers<CR>
xmap <silent> <leader>co :CocList --auto-preview outline<CR>
nmap <silent> <leader>co :CocList --auto-preview outline<CR>
xmap <silent> <leader>cs  <Plug>(coc-codeaction-selected)
nmap <silent> <leader>cs  <Plug>(coc-codeaction-selected)
xmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>ca  <Plug>(coc-codeaction)
nnoremap <silent> [a :<C-u>CocPrev<CR>
nnoremap <silent> ]a :<C-u>CocNext<CR>
inoremap <silent><expr> <C-j> coc#refresh() " 触发补全

" --- coc-snippets ---
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" --- coc-git ---
nnoremap [h <Plug>(coc-git-prevchunk)
nnoremap ]h <Plug>(coc-git-nextchunk)
nnoremap <silent> [c <Plug>(coc-git-prevconflict)
nnoremap <silent> ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer
xmap ag <Plug>(coc-git-chunk-outer)
nmap cb <Plug>(coc-git-keepboth)
omap cb <Plug>(coc-git-keepboth)
nmap co <Plug>(coc-git-keepcurrent)
omap co <Plug>(coc-git-keepcurrent)
nmap ct <Plug>(coc-git-keepincoming)
omap ct <Plug>(coc-git-keepincoming)

" --- coc-translate ---
nmap <Leader>ct <Plug>(coc-translator-p)
vmap <Leader>ct <Plug>(coc-translator-pv)

" --- Fzf ---
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fm :<C-u>Maps<CR>
nnoremap <silent> <leader>f/ :Rg<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
" imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd',{'window': { 'width': 1, 'height': 0.3, 'yoffset': -1 }} )
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
imap <c-x><c-l> <plug>(fzf-complete-line)

" --- Keymaps ---
" <F2>: Show full path and copy to system clipboard
nnoremap <silent> <F2> :let @+ = expand("%:p") <bar> echo "Copied path: " . expand("%:p")<CR>
nnoremap <silent> <BS> :nohlsearch<cr>
" Buffer Switching (Alternate File)
nnoremap \ <C-^>
" Visual Motions (Wrapped lines)
nmap j gj
nmap k gk
" Search Centering
nnoremap n nzz
nnoremap N Nzz
" Window Navigation (Ctrl + h/j/k/l)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Clipboard (System)
"vnoremap <leader>y "+y
"nnoremap <leader>y "+y
"nnoremap <leader>p "+p
"vnoremap <leader>p "+p

"Q: How to grep by motion?
"A: Create custom keymappings like:
vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

"Q: How to grep current word in current buffer?
"A: Create kep-mapping like:

noremap <silent><nowait> <leader>e <Cmd>CocCommand explorer<CR>
noremap <silent><nowait> <F3> <Cmd>CocCommand explorer<CR>
noremap <silent><nowait> <leader>b <Cmd>CocList --auto-preview buffers<CR>
noremap <silent><nowait> <leader>d <Cmd>CocList --auto-preview diagnostics<CR>
noremap <silent><nowait> <leader><leader> :<C-u>CocList --auto-preview files<CR>
noremap <silent><nowait> <leader>W :exe 'CocList --interactive --auto-preview --normal --input='.expand('<cword>').' grep --ignore-case --regexp'<CR>
noremap <silent><nowait> <leader>w :exe 'CocList --interactive --auto-preview --normal --input='.expand('<cword>').' words'<CR>
noremap <silent><nowait> <leader>/ :<C-u>CocList --interactive --auto-preview grep --ignore-case --regexp<CR>
noremap <silent><nowait> <leader>y :<C-u>CocList --interactive yank<CR>
noremap <silent><nowait> <leader>m :<C-u>Maps <CR>

" =============================================================================
" End of file
" =============================================================================
