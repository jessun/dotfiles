" https://github.com/neoclide/coc.nvim
" Custom color ================================================================
hi CocNord guifg='#D8DEE9' guibg='#3B4252'


" Coc extensions list =========================================================
let g:coc_global_extensions = [ 
            \ 'coc-dictionary', 
            \ 'coc-emoji',
            \ 'coc-extension-codemod',
            \ 'coc-highlight',
            \ 'coc-tag',
            \ 'coc-snippets',
            \ 'coc-syntax',
            \ 'coc-word',
            \ 'coc-lists',
            \ 'coc-git',
            \ 'coc-marketplace',
            \ 'coc-spell-checker',
            \ 'coc-yank',
            \ 'coc-translator',
            \ 'coc-go',
            \ 'coc-json',
            \ 'coc-sumneko-lua',
            \ 'coc-rust-analyzer',
            \]


" SemanticTokens ==============================================================
" Tokens types that current Language Server supported:
" hi CocSemNamespace guifg='#EBCB8B'
" hi CocSemType guifg="#81A1C1"
" hi CocSemClass guifg="#81A1C1"
" hi CocSemEnum guifg="#81A1C1"
" hi CocSemInterface guifg="#81A1C1"
" hi CocSemStruct guifg="#81A1C1"
" hi CocSemTypeParameter guifg="#81A1C1"
" hi CocSemParameter guifg="#5E81AC"
" hi CocSemVariable guifg='#d8dee9'
" hi CocSemProperty guifg="#5E81AC"
" hi CocSemEnumMember 
" hi CocSemEvent
" hi CocSemMethod guifg="#8FBCBB"
" hi CocSemMacro guifg="#81A1C1"
" hi CocSemModifier guifg="#88C0D0"
" hi CocSemComment guifg="#434C5E"
" hi CocSemString guifg="#A3BE8C"
" hi CocSemNumber guifg="#B48EAD"
" hi CocSemRegexp guifg="#8FBCBB"
" hi CocSemDecorator guifg="#88C0D0"
" hi CocSemOperator guifg="#81A1C1"
"
" Tokens modifiers that current Language Server supported:
" hi CocSemDeclaration guifg='#8FBCBB'
" hi CocSemDefinition guifg='#81A1C1'
" hi CocSemFunction guifg='#81A1C1'
" hi CocSemReadonly guifg='#81A1C1'
" hi CocSemStatic guifg='#BF616A'
" hi CocSemDeprecated guifg='#BF616A'
" hi CocSemAbstract guifg='#D08770'
" hi CocSemAsync guifg='#EBCB8B'
" hi CocSemModification guifg='#88C0D0'
" hi CocSemDocumentation guifg='#B48EAD'
" hi CocSemDefaultLibrary guifg='#88C0D0'
hi CocHighlightText guibg='#B48EAD' guifg='#2E3440'
hi CocErrorHighlight guibg='#BF616A'  guifg='#d8dee9'
hi CocWarnHighlight guibg='#EBCB8B'  guifg='#d8dee9'
hi CocSemLifetime  guifg='#EBCB8B'
" hi CocSemKeyword guifg='#88C0D0'
" hi CocSemFunction guifg='#81A1C1'


" Coc-snippets ================================================================
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

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" Coc-lists ===================================================================
"Q: How to make grep easier?
"A: Create custom command like:
" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

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
nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>


" Coc-git =====================================================================
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)


nmap cb <Plug>(coc-git-keepboth)
omap cb <Plug>(coc-git-keepboth)

nmap co <Plug>(coc-git-keepcurrent)
omap co <Plug>(coc-git-keepcurrent)

nmap ct <Plug>(coc-git-keepincoming)
omap ct <Plug>(coc-git-keepincoming)


" Coc-yank ====================================================================
nnoremap <silent> <space>y  :<C-u>CocList yank<cr>


" Coc-translator ==============================================================
" NOTE: do NOT use `nore` mappings
" popup
nmap <Leader>ct <Plug>(coc-translator-p)
vmap <Leader>ct <Plug>(coc-translator-pv)
" echo
" nmap <Leader>e <Plug>(coc-translator-e)
" vmap <Leader>e <Plug>(coc-translator-ev)
" replace
" nmap <Leader>r <Plug>(coc-translator-r)
" vmap <Leader>r <Plug>(coc-translator-rv)

" Coc-go ======================================================================
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Coc-spell-checker ============================================================
call coc#config('cSpell.dictionaryDefinitions', [
  \ { "name" : "actiontech", "path": expand("$HOME/.config/nvim/dicts/actiontech.txt") },
  \ { "name" : "personal", "path": expand("$HOME/.config/nvim/dicts/pvt.txt") }
  \])



" Coc =========================================================================
inoremap <silent><expr> <C-u> coc#refresh() " 触发补全

nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

xmap <leader>cs  <Plug>(coc-codeaction-selected)
nmap <leader>cs  <Plug>(coc-codeaction-selected)

xmap <leader>ca  <Plug>(coc-codeaction)
nmap <leader>ca  <Plug>(coc-codeaction)

xmap <silent> <leader><leader> :<C-u>CocList --auto-preview files<CR>
nmap <silent> <leader><leader> :<C-u>CocList --auto-preview files<CR>
xmap <silent> <leader>/ :<C-u>CocList --interactive --auto-preview grep<CR>
nmap <silent> <leader>/ :<C-u>CocList --interactive --auto-preview grep<CR>
xmap <silent> <leader>b   :CocList --auto-preview buffers<CR>
nmap <silent> <leader>b   :CocList --auto-preview buffers<CR>
xmap <silent> <leader>k :CocList maps<CR>
nmap <silent> <leader>k :CocList maps<CR>
xmap <silent> <leader>m :CocList marks<CR>
nmap <silent> <leader>m :CocList marks<CR>

nnoremap <silent> <leader>* :exe 'CocList --interactive --auto-preview --input='.expand('<cword>').' grep'<CR>

nnoremap <silent><nowait> <leader>cd  :<C-u>CocList --auto-preview diagnostics<cr>

xmap <leader>cc  :CocList commands<CR>
nmap <leader>cc  :CocList commands<CR>

xmap <leader>cm  :CocList --auto-preview marks<CR>
nmap <leader>cm  :CocList --auto-preview marks<CR>

" xmap <leader>k  :CocList --auto-preview maps<CR>
" nmap <leader>k  :CocList --auto-preview maps<CR>

xmap <leader>co  :CocOutline<CR>
nmap <leader>co  :CocOutline<CR>

nnoremap <silent><nowait> <leader>cr :<C-u>CocListResume<CR>
nmap <leader>cr <Plug>(coc-refactor)

" nmap <expr> <silent> 'w <SID>select_current_word()
" function! s:select_current_word()
"   if !get(b:, 'coc_cursors_activated', 0)
"     return "\<Plug>(coc-cursors-word)
"   endif
"   return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
" endfunc

autocmd CursorHold * silent call CocActionAsync('highlight')

