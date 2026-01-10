" -----------------------------------------------------------------------------
"  Lightline Configuration
"  Author:      jessun.pro@gmail.com
"  Description: Statusline customization, Coc integration, and 'Stealth' theme logic.
"  Location:    ~/.config/vim/ui/lightline.vim
" -----------------------------------------------------------------------------


" =============================================================================
" 01. Diagnostic & Git Logic
" =============================================================================
" Helper: Fetch Coc diagnostic counts and format the output string.
function! s:GetCocCount(level, symbol) abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return a:symbol . '0' | endif
  
  let l:count = get(l:info, a:level, 0)
  return l:count > 0 ? a:symbol . l:count : a:symbol . '0'
endfunction

" [New] Fetch Coc Git Status (e.g., +1 ~2 -0)
function! LightlineCocGitStatus() abort
  return get(b:, 'coc_git_status', '')
endfunction

" Public wrappers for Lightline components.
function! LightlineCocErrors() abort
  return s:GetCocCount('error', 'E')
endfunction

function! LightlineCocWarnings() abort
  return s:GetCocCount('warning', 'W')
endfunction

function! LightlineCocInfos() abort
  return s:GetCocCount('information', 'I')
endfunction

function! LightlineCocHints() abort
  return s:GetCocCount('hint', 'H')
endfunction

" =============================================================================
" 02. Theme Customization (Nord Stealth Mode)
" =============================================================================
function! s:SetupLightlineNordExpanded() abort
  " Safety Check: Abort if the Nord palette isn't loaded yet.
  try
    let l:base_palette = g:lightline#colorscheme#nord#palette
  catch
    return
  endtry

  " Deep copy to avoid mutating the original theme.
  let l:new_palette = deepcopy(l:base_palette)

  " --- [Color Definitions] ---
  " Stealth: Dark grey text + transparent bg (for inactive elements).
  let l:stealth = [ '#4C566A', '#2E3440', 239, 0 ]
  " Active: Bright white text + dark bg (for the active tab).
  let l:active  = [ '#E5E9F0', '#2E3440', 255, 0 ]

  " --- [Override Logic] ---
  " 1. Force 'Stealth' mode on all Statusline segments.
  for l:mode in values(l:new_palette)
    for l:side in ['left', 'middle', 'right']
      if has_key(l:mode, l:side)
        call map(l:mode[l:side], 'l:stealth')
      endif
    endfor
  endfor

  " 2. Customize Tabline.
  if has_key(l:new_palette, 'tabline')
    let l:tp = l:new_palette.tabline
    let l:tp.tabsel = [ l:active ]
    let l:tp.left   = [ l:stealth ]
    let l:tp.middle = [ l:stealth ]
    let l:tp.right  = [ l:stealth ]
  endif

  " 3. Inject Coc Colors.
  let l:coc_colors = {
        \ 'error':   [ ['#E5E9F0', '#BF616A', 255, 167] ],
        \ 'warning': [ ['#2E3440', '#EBCB8B', 235, 220] ],
        \ 'info':    [ ['#E5E9F0', '#8FBCBB', 255, 109] ],
        \ 'hint':    [ ['#E5E9F0', '#4C566A', 255, 239] ]
        \ }

  for l:mode in ['normal', 'insert', 'visual', 'replace', 'terminal']
    if has_key(l:new_palette, l:mode)
      call extend(l:new_palette[l:mode], l:coc_colors)
    endif
  endfor

  " --- [Apply] ---
  let g:lightline#colorscheme#nord_expanded#palette = l:new_palette
  let g:lightline.colorscheme = 'nord_expanded'
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" =============================================================================
" 03. Main Configuration
" =============================================================================
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'coc_error', 'coc_warning', 'coc_info', 'coc_hint' ],
      \             [ 'gitbranch', 'coc_git_status', 'readonly', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_expand': {
      \   'coc_error': 'LightlineCocErrors',
      \   'coc_warning': 'LightlineCocWarnings',
      \   'coc_info': 'LightlineCocInfos',
      \   'coc_hint': 'LightlineCocHints',
      \   'coc_git_status': 'LightlineCocGitStatus',
      \   'gitbranch': 'gitbranch#name',
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'coc_error': 'error',
      \   'coc_warning': 'warning',
      \   'coc_info': 'info',
      \   'coc_hint': 'hint',
      \   'coc_git_status': 'middle',
      \   'buffers': 'tabsel'
      \ },
      \ }

" Display numbers in the buffer list.
let g:lightline#bufferline#show_number = 1

" =============================================================================
" 04. AutoCommands
" =============================================================================
augroup LightlineConfig
  autocmd!
  " Initialize custom theme.
  autocmd VimEnter * call s:SetupLightlineNordExpanded()
  " Refresh UI when diagnostics OR git status change.
  autocmd User CocDiagnosticChange,CocGitStatusChange call lightline#update()
augroup END

" =============================================================================
" End of file
" =============================================================================
