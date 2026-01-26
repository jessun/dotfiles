" -----------------------------------------------------------------------------
"  Theme & Visuals
"  Author:      jessun.pro@gmail.com
"  Description: Colors, fonts, syntax highlighting, and UI appearance logic.
"  Location:    ~/.config/vim/ui/theme.vim
" -----------------------------------------------------------------------------


" =============================================================================
" 01. Basic Appearance
" =============================================================================
" Enable 24-bit RGB color in the terminal (True Color).
" Required for modern themes like Nord to render correctly.
if has('termguicolors')
  set termguicolors
endif
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Set the default background tone.
set background=dark

" Enable syntax highlighting.
if has('syntax')
  syntax on
endif

" =============================================================================
" 02. Font Configuration (GUI Clients)
" =============================================================================
" Logic: Iterate through a preferred list of fonts and apply the first one found.
" This ensures the config works across different machines (e.g., Work vs Home)
" without manual intervention.

if has("gui_running")
  " 1. Define font preference order.
  let s:font_list = [
        \ "JetBrainsMono Nerd Font",
        \ "BerkeleyMonoTrial Nerd Font Mono",
        \ "Menlo"
        \ ]

  " 2. Define font size.
  let s:font_size = "h22"

  " 3. Attempt to set font.
  for s:font in s:font_list
    try
      " Command format: set guifont=Font\ Name:h22
      " We escape spaces in the font name to satisfy Vim's syntax.
      let s:cmd = "set guifont=" . escape(s:font, ' ') . ":" . s:font_size
      execute s:cmd

      " If successful (no error thrown), stop searching.
      break
    catch /^Vim\%((\a\+)\)\=:E596/
      " Error E596: Invalid font. Skip to the next font in the list.
      continue
    catch
      " Ignore other unexpected errors and continue.
      continue
    endtry
  endfor
endif

" =============================================================================
" 03. Colorscheme Loading Strategy
" =============================================================================
" Logic: Try loading themes in order of preference.
" This prevents startup errors if a plugin (e.g., 'nord') is not yet installed.

let s:preferred_colorschemes = ['nord', 'habamax', 'slate', 'sorbet']

for s:scheme in s:preferred_colorschemes
  try
    execute 'colorscheme ' . s:scheme

    " If successful, stop searching.
    break
  catch /^Vim\%((\a\+)\)\=:E185/
    " Error E185: Cannot find color scheme. Try the next one.
    continue
  endtry
endfor

" ============================================================================="
" Fix Search Highlighting Persistence"
" ============================================================================="
augroup NordSearchFix
  autocmd!
  autocmd ColorScheme * highlight Search ctermfg=255 ctermbg=237 cterm=bold,nocombine guifg=#4c566a guibg=#ECEFF4 gui=bold,nocombine
  autocmd ColorScheme * highlight IncSearch ctermfg=235 ctermbg=214 cterm=bold,nocombine guifg=#4c566a guibg=#ECEFF4 gui=bold,nocombine
augroup END
" =============================================================================
" End of file
" =============================================================================
