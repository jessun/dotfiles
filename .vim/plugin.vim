" =================== File Info =====================
"  Author: jessun1990@gmail.com
"  Desc: plugins config of vim/nvim
"  Location: ~/.vim/plugin.vim
" ===================================================
"
" ================== Basic Config ==================
" auto download plug.vim
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

set rtp+=/usr/local/opt/fzf
" ===================================================
"
" ==================== Vim-plug =====================
call plug#begin('~/.vim/plugged')

" Basic plugin =================
if has('nvim')
else
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" UI ==========================
Plug 'sheerun/vim-polyglot'          " 语法高亮
Plug 'flazz/vim-colorschemes'        " 配色主题
" Plug 'overcache/NeoSolarized'
Plug 'itchyny/lightline.vim'         " 底部条
" Plug 'sainnhe/forest-night'

" general =====================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuttie/comfortable-motion.vim'
" Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'

" code ========================
Plug 'tommcdo/vim-fugitive-blame-ext' " git 信息
Plug 'tpope/vim-fugitive'             " git 相关
"Plug 'dense-analysis/ale'
Plug 'liuchengxu/vista.vim' " tag
Plug 'ap/vim-css-color'
Plug 'scrooloose/nerdcommenter'       " 注释
Plug 'tpope/vim-surround'             " 快捷操作

" coc.nvim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-marketplace', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-actions', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile && npm i -g bash-language-server', 'for': 'sh'}

" rust
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile', 'for': 'rust'}

" gopls
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile', 'for': 'go'}

" markdown
" Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" file ========================
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile', 'for': 'json'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile', 'for': 'yaml'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile', 'for': 'css'}
call plug#end()
" ===================================================
"
" ======== 'iamcco/markdown-preview.nvim' ===========
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0
let g:mkdp_browserfunc = 'g:open_browser'
" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0
" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0
" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0
" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" dfault: 0
let g:mkdp_open_to_the_world = 0
" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''
" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'google-chrome-unstable'
" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0
" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''
" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {'server': 'http://localhost:8080'},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = expand('~/.vim/github-markdown.css')
" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''
" use a custom port to start server or random for empty
let g:mkdp_port = ''
" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '${name}'
" ===================================================
"
" =============== 'ense-analysis/ale' ===============
" \   'rust': ['rustfmt']
" \   'go': ['gofmt', 'goimports', 'gomod'],
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['eslint'],
" \}
" \  'rust': ['rls', 'cargo', 'rustc']
" \  'go': ['gopls'],
" let g:ale_linters = {
" \  'javascript': ['eslint'],
" \}
" let g:ale_linters_explicit = 1
" let g:ale_completion_enabled = 0   " 自动补全
" let g:ale_completion_tsserver_autoimport = 1
" let g:ale_echo_msg_error_str = 'Err'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_echo_msg_warning_str = 'Wrn'
" let g:ale_fix_on_save = 0
" let g:ale_keep_list_window_open = 1
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_list_window_size = 3
" let g:ale_open_list = 1
" let g:ale_set_quickfix = 1
" let g:ale_rust_rls_executable = '~/.cargo/bin/'
" let g:ale_rust_rls_toolchain = 'nightly'
" let g:ale_set_highlights = 1
" let g:ale_sign_column_always = 1   "保持侧边栏可见
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
"
" " 跳转错误行快捷键，所以快捷键是Ctrl+k或j
" "nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" "nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <space>gg <Plug>(ale_go_to_definition)
" highlight ALEErrorSign ctermbg=NONE ctermfg=red
" highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
" ===================================================
" 
" ============='scrooloose/nerdcommenter' ===========
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" ===================================================
"
" ========================'fzf' =====================
command! -bang LS call fzf#run(fzf#wrap({'source': 'ls'}, <bang>0))

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }
" See `man fzf-tmux` for available options
" if exists('$TMUX')
"   let g:fzf_layout = { 'tmux': '-p90%,60%' }
" else
"   let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" endif

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" ===================================================
"
" ========================'fzf.vim' =====================
nmap <space><space> :<C-U><C-R>=printf("Files")<CR><CR>
nmap <space>/ :<C-U><C-R>=printf("RG")<CR><CR>
nmap <space>b :<C-U><C-R>=printf("Buffers")<CR><CR>
"
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
"
" Mapping selecting mappings
nmap <space><tab> <plug>(fzf-maps-n)
xmap <space><tab> <plug>(fzf-maps-x)
omap <space><tab> <plug>(fzf-maps-o)
"
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
"
" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
"
" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
"
" " Replace the default dictionary completion with fzf-based fuzzy completion
" inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
" " Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))
"
function! s:make_sentence(lines)
    return substitute(join(a:lines), '^.', '\=toupper(submatch(0))', '').'.'
endfunction
"
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"
inoremap <expr> <c-x><c-s> fzf#vim#complete({
  \ 'source':  'cat /usr/share/dict/words',
  \ 'reducer': function('<sid>make_sentence'),
  \ 'options': '--multi --reverse --margin 15%,0',
  \ 'left':    20})

"
let g:fzf_preview_window = 'right:60%'
" " [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
"
" " [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
"
" " [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R -f ./.tags'
"
" " [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
"
" ====================================================
"
" ================== 'vim-easy-align' ================
" 让代码更加易于纵向排版，以=或,符号对齐，使用:Tab /=即按等号对齐
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <space>aip)
nmap ga <Plug>(EasyAlign)
" ====================================================
"
" ================ 'neoclide/coc.nvim' ================
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <space>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <space>f  <Plug>(coc-format-selected)
nmap <space>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<space>aap` for current paragraph
xmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <space>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <space>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.go :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>x  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent> <space>r  :<C-u>CocListResume<CR>
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent><nowait> <space>m  :CocCommand document.renameCurrentWord<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
nnoremap <space>rf <Plug>(coc-refactor)
" ====================================================
"
" ============== 'liuchengxu/vista.vim' ==============
nnoremap <silent> <space>v :Vista!!<CR>
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = [">", ">>>>>>"]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
"
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 0

autocmd FileType vista nnoremap <buffer> <silent> aa :<c-u>call vista#cursor#FoldOrJump()<CR>
" ====================================================
"
" ================ 'Yggdroot/leaderF' ================
" don't show the help in normal mode
" let g:Lf_GtagsAutoGenerate = 1
" let g:Lf_Gtagslabel = 'native-pygments'
" let g:Lf_HideHelp = 1
" let g:Lf_IgnoreCurrentBufferName = 1
" let g:Lf_PreviewInPopup = 1
" let g:Lf_ShowDevIcons = 0
" let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
" let g:Lf_ShortcutF = "<C-p>"
" let g:Lf_UseCache = 1
" let g:Lf_UseVersionControlTool = 0
" let g:Lf_WindowPosition = 'popup'
" if has('mac')
"    let g:Lf_Ctags = '/usr/local/bin/ctags'
" endif
" " :leaderfFile 搜索当前目录下所有文件
" " :leaderfMru 搜索最常用文件
" noremap <space>fb :<C-U><C-R>=printf("leaderf buffer %s", "")<CR><CR>
" noremap <space>fm :<C-U><C-R>=printf("leaderf mru %s", "")<CR><CR>
" noremap <space>ft :<C-U><C-R>=printf("leaderf bufTag %s", "")<CR><CR>
" noremap <space>fl :<C-U><C-R>=printf("leaderf line %s", "")<CR><CR>
" noremap <C-B> :<C-U><C-R>=printf("leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR><CR>
" noremap <C-F> :<C-U><C-R>=printf("leaderf! rg -e %s ", expand("<cword>"))<CR><CR>
" " search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>leaderf! rg --recall<CR>
" " should use `leaderf gtags --update` first
" noremap <space>fr :<C-U><C-R>=printf("leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <space>fd :<C-U><C-R>=printf("leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <space>fo :<C-U><C-R>=printf("leaderf! gtags --recall %s", "")<CR><CR>
" noremap <space>fn :<C-U><C-R>=printf("leaderf gtags --next %s", "")<CR><CR>
" noremap <space>fp :<C-U><C-R>=printf("leaderf gtags --previous %s", "")<CR><CR>
"
""nmap <space>p :<C-U><C-R>=printf("leaderf rg --fuzzy")<CR><CR>
""nmap <space>p :<C-U><C-R>=printf("leaderf rg --regexMode")<CR><CR>
" highlight Lf_hl_match gui=bold guifg=Blue cterm=bold ctermfg=21
" highlight Lf_hl_matchRefine  gui=bold guifg=Magenta cterm=bold ctermfg=201
" let g:Lf_PopupPalette = {
"     \  'light': {
"     \      'Lf_hl_match': {
"     \                'gui': 'NONE',
"     \                'font': 'NONE',
"     \                'guifg': 'NONE',
"     \                'guibg': '#303136',
"     \                'cterm': 'NONE',
"     \                'ctermfg': 'NONE',
"     \                'ctermbg': '236'
"     \              },
"     \      'Lf_hl_cursorline': {
"     \                'gui': 'NONE',
"     \                'font': 'NONE',
"     \                'guifg': 'NONE',
"     \                'guibg': '#303136',
"     \                'cterm': 'NONE',
"     \                'ctermfg': 'NONE',
"     \                'ctermbg': '236'
"     \              }
"     \      }
"     \  }
" ====================================================
"
" ============= 'Xuyuanp/scrollbar.nvim' =============
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
augroup end
let g:scrollbar_right_offset = 0
let g:scrollbar_shape = {
  \ 'head': ' ',
  \ 'body': ' ',
  \ 'tail': '',
  \ }
let g:scrollbar_highlight = {
  \ 'head': 'LineNr',
  \ 'body': 'LineNr',
  \ 'tail': 'LineNr',
  \ }
let g:scrollbar_excluded_filetypes = ['nerdtree']
" ====================================================
"
" ============= 'itchyny/lightline.vim' ==============
function! LightlineFilename()
  return expand('%:p')
endfunction

function! BuffGitStatus() abort
  let gitstatus = get(b:, 'coc_git_status', '')
  return gitstatus
endfunction

function! ProGitStatus() abort
  let gitstatus = get(g:, 'coc_git_status', '')
  return gitstatus
endfunction

function! LightlineGitBlame()
  let blame = get(b:, 'coc_git_blame', '')
  return winwidth(0) > 120 ? blame : ''
endfunction

let g:lightline = {
   \ 'colorscheme': 'wombat',
   \ 'active': {
   \    'left': [
   \        ['mode', 'paste', 'gitbranch', 'buffgitstatus', 'progitstatus'],
   \     ],
   \    'right': [
   \        ['filetype','fileformat', 'fileencoding','lineinfo', 'percent'],
   \        ['coc_warning'],
   \        ['blame']
   \     ],
   \ },
   \ 'component_function': {
   \   'blame': 'LightlineGitBlame',
   \   'filename': 'LightlineFilename',
   \   'cocstatus': 'coc#status',
   \   'buffgitstatus': 'BuffGitStatus',
   \   'progitstatus': 'ProGitStatus',
   \ },
   \ 'component_expand': {
   \   'coc_error'        : 'LightlineCocErrors',
   \   'coc_warning'      : 'LightlineCocWarnings',
   \   'coc_info'         : 'LightlineCocInfos',
   \   'coc_hint'         : 'LightlineCocHints',
   \   'coc_fix'          : 'LightlineCocFixes',
    \ }, 
\ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }
let g:lightline.tabline = {'left': [['filename']], 'right': [['coc_error']]}

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf('%s:%s', a:sign, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', 'ERR')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', 'WARN')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', 'INFO')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', 'HINT')
endfunction

" let g:lightline#bufferline#show_number  = 1
" let g:lightline#bufferline#shorten_path = 1
" let g:unite_force_overwrite_statusline = 1
let g:vimfiler_force_overwrite_statusline = 1
let g:vimshell_force_overwrite_statusline = 1

autocmd BufEnter ALELint call lightline#update()
autocmd User CocDiagnosticChange call lightline#update()
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
" ====================================================
"
" ================'neoclide/coc-list' ==============
" grep word under cursor
function! s:GrepArgs(...)
  let list = ['-S', '--smart-case', '-i', '--ignore-case', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <space>* :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
vnoremap <space>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <space>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

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
" ====================================================
"
" ================'neoclide/coc-git' =================
" navigate chunks of current buffer
nmap g[ <Plug>(coc-git-prevchunk)
nmap g] <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gh <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
" ====================================================
"
" ================== Reset Config ===================
" 移除左侧到波浪线
function! RemoveWavyline()
    hi NonText guifg=bg
endfunction
"
" 隐藏波浪线
set guifont=JetBrains\ Mono:h17
if has("gui_running") " GUI
    if has("gui_macvim") " MacVim
        autocmd BufEnter * call RemoveWavyline()
    elseif " Linux Or Windows Gvim

    endif
else " Terminal
    colorscheme mod8
    if has('mac') " MacOS iterm2 or termial
        colorscheme mod8
        " colorscheme lucario
        " colorscheme nord
        " colorscheme nordisk
        " colorscheme cobalt2
        " colorscheme materialtheme
        " colorscheme hybrid_material
        " colorscheme hybrid_reverse
    endif " Linux termial
endif
" ===================================================
"
" ============ 'weirongxu/coc-explorer' =============
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" Use preset argument to open it
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floatingLeftside<CR>

" List all presets
nmap <space>el :CocList explPresets<CR>
nmap <space>d :CocCommand explorer<CR>
" ===================================================
"
" ============ 'voldikss/coc-bookmark' ==============
" nmap <space>m :CocList bookmark<CR>
" nmap mj <Plug>(coc-bookmark-next)
" nmap mk <Plug>(coc-bookmark-prev)
" nmap m, <Plug>(coc-bookmark-toggle)
" ===================================================
"
" ============ 'neoclide/coc-snippets' ==============
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" ===================================================
"
" ============== 'iamcco/coc-actions' ===============
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <space>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <space>a :<C-u>set operatorfunc=SID>cocActionsOpenFromSelected<CR>
" ====================================================
"
" ================== 'golang/highlight' =================
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
" ===================================================
"
" ================== 'yuttie/comfortable-motion.vim' =================
let g:comfortable_motion_friction = 150
let g:comfortable_motion_air_drag = 4.0
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
"
" ===================================================
"
" ==================== 'Key Map' ====================
" === scrooloose/nerdcommenter' 
" <space>cc 注释掉在可视模式下选择的当前行或文本
" <space>cn 与cc相同，但强制嵌套。
" <space>c<space> 切换所选行的注释状态。如果最上面的选定行被注释，则所有选定的行均未注释，反之亦然。
" <space>cm 仅使用一组多部分定界符注释给定的行。
" <space>ci 分别切换所选行的注释状态。
" <space>cs 用漂亮的块格式布局注释掉选定的行。
" <space>cy 与cc相同，除了首先删除注释行。
" <space>c$ 注释当前行从光标到行尾。
" <space>cA 在行尾添加注释定界符，并在它们之间进入插入模式。
" <space>ca 切换到另一组定界符。
" <space>cl 与<space>cc 相同，除了定界符在左侧对齐
" <space>cb 与<space>cc 相同，除了定界符在两侧对齐
"
" === junegunn/fzf
" :Files 列出当前目录下所有文件
" :GitFiles 等同 `$git status`
" :GFiles? 等同 `$ git status"`
" :Buffers 列出所有的 buffers
" :Colors  列出所有的配色方案
" :Ag 使用 Ag 命令进行搜索
" :Rg 使用 Rg 命令进行搜索
" :Lines 按行搜索所有打开的buffers
" :BLines 按行搜索当前打开的buffers
" :Tags Tags in the project (ctags -R)
" :BTags Tags in the current buffer
" :Marks Marks
" :Windows Windows
" :Locate 等同 Locate
" :History 'v:oldfiles and open buffers'
" :History: 命令历史
" :History/ 搜索历史
" :Snippets Snippets(https://github.com/SirVer/ultisnips)
" :Commits 浏览 git commits 历史
" :BCommits 浏览当前 buffer 的 git commits 历史
" :Maps normal mode 下的按键映射
" :Helptags
" :Filetypes
" :GGrep 等同 `git grep`
" 上述命令大多支持`CTRL-T`(new tab)， `CTRL-X`(new split)， `CTRL-V`(new vertical split)
" 如果命令后面加上感叹号(!)，就变成全屏显示
" nmap <space><tab> <plug>(fzf-maps-n) 不知如何使用
" xmap <space><tab> <plug>(fzf-maps-x) 不知如何使用
" omap <space><tab> <plug>(fzf-maps-o) 不知如何使用
"
" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word) 插入单词
" imap <c-x><c-f> <plug>(fzf-complete-path) 插入路径
" imap <c-x><c-l> <plug>(fzf-complete-line) 插入行
" imap <c-x><c-k> 单词补全
" imap <c-x><c-s> 单词补全造句
"
" === 'vim-easy-align'
" xmap ga visual mode 下对齐
" nmap ga normal mode 下对齐
"
" === 'neoclide/coc.nvim'
" <space>f 等同:Rg
" nmap [g coc 诊断信息下一个
" nmap ]g coc 诊断信息上一个
" nmap gd 跳转到定义处
" nmap gs 跳转到定义处，split
" nmap gv 跳转到定义处，vsplit
" nmap gt 跳转到定义处，tab
" nmap gy 跳转到类型定义处
" nmap gi 跳转到实现处
" nmap gr 查找引用处
" nnoremap K 显示文档
" nmap ;rn 单词重命名
" nmap <space>f 格式化
" xmap <space>f 格式化
" xmap <space>a 选择
" nmap <space>a 选择
" nmap <space>ac 将 cocAction 在当前行应用
" nmap <space>qf 自动修复当前行
" xmap if 选区，表示函数，函数内部文本
" omap if 选区，表示函数，函数内部文本
" xmap af 选区，表示函数，全部函数文本
" omap af 选区，表示函数，全部函数文本
" :Format 格式化
" :Fold 折叠
" :OR 自动 import 依赖
" noremap <space>a coc 诊断
" noremap <space>e coc 插件列表
" noremap <space>d coc-explorer 窗口
" noremap <space>c coclist commands 列表
" noremap <space>o coclist outline 
" noremap <space>s coclist -I symbols
" noremap <space>j CocNext
" noremap <space>k CocPrev
" noremap <space>r CocListResume
" noremap <space>y vim 内置粘贴板
"
" ==='liuchengxu/vista.vim' 
" nnoremap <space>v :Vista!!
"
" ==='neoclide/coc-list' 
" noremap <space>W 搜索单词，范围为当前目录下所有文本
" noremap <space>w 搜索单词，范围为当前 buffer
" noremap <space>g 搜索单词，同 :RG
"
" ==='neoclide/coc-git' 
" nmap g[ coc-git-prevchunk
" nmap g] coc-git-nextchunk
" nmap gs coc-git-chunkinfo
" nmap gc coc-git-commit
" omap ig coc-git-chunk-inner
" xmap ig coc-git-chunk-inner
" omap ag coc-git-chunk-outer
" xmap ag coc-git-chunk-outer
"
" === 'weirongxu/coc-explorer'
" nmap <space>ed :CocCommand explorer --preset .vim<CR> 显示 ~/.vim 目录
" nmap <space>ef :CocCommand explorer --preset floatingLeftside<CR> 左侧浮动窗口打开 floatingLeftside
" nmap <space>el :CocList explPresets<CR>
"
" === 'neoclide/coc-snippets'
" imap <C-l> <Plug>(coc-snippets-expand)
" vmap <C-j> <Plug>(coc-snippets-select)
" let g:coc_snippet_next = '<c-j>'
" let g:coc_snippet_prev = '<c-k>'
" imap <C-j> <Plug>(coc-snippets-expand-jump)
"
" === 'iamcco/coc-actions'
" xmap <silent> <space>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" nmap <silent> <space>a :<C-u>set operatorfunc=SID>cocActionsOpenFromSelected<CR>
" ===================================================e
"
" map <Leader> <Plug>(easymotion-prefix)
" " <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
"
" " s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)
"
" " Move to line
" map <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)
"
" " Move to word
" map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
" function! s:incsearch_config(...) abort
"   return incsearch#util#deepextend(deepcopy({
"   \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
"   \   'keymap': {
"   \     "\<CR>": '<Over>(easymotion)'
"   \   },
"   \   'is_expr': 0
"   \ }), get(a:, 1, {}))
" endfunction
"
" noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
" noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
" noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))



let g:comfortable_motion_friction = 100
let g:comfortable_motion_air_drag = 4
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

let g:neovide_refresh_rate=140
let g:neovide_no_idle=v:true
let g:neovide_cursor_trail_length=1

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
