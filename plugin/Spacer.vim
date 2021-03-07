" -----------------------------------------------------------------------------
" Spacer.vim - Spacer!
" Version:  0.1
" Author:   Marcos Ferradas <marcosferradas@gmail.com>
"           https://gitlab.com/impresionista/vim-spacer
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" Standard variable values in case there ar not externally defined
" -----------------------------------------------------------------------------
let s:linelength  = 80
let s:sep_char    = "-"
let s:comm_char   = "# "
let s:curr_pos    = col(".")


" -----------------------------------------------------------------------------
" Local functions
" -----------------------------------------------------------------------------
function! s:GetCommentSymbol()
  let s:comm_char = split(&commentstring, '%s')[0]."\<space>"
endfunction

function! s:GetCursorPos(posindex)
  let s:curr_pos  = col(a:posindex)
  let s:curr_line = line(a:posindex)
  let s:title_pos = s:curr_pos+2
  echo s:curr_line s:curr_pos
endfunction

function! s:GetLineLength()
  " TO-DO:
  " Needs to read filetype standard line length.
  let s:linelength = 80
endfunction

function! s:FullWidth(posindex)
  call s:GetLineLength()
  call s:GetCursorPos(a:posindex)
  if s:curr_pos == 1
    let s:width = s:linelength-(s:curr_pos+2)
  else
    let s:width = s:linelength-(s:curr_pos+3)
  endif
endfunction

function! s:SmallWidth(posindex)
  call s:GetLineLength()
  call s:GetCursorPos(a:posindex)
  if s:curr_pos == 1
    let s:width = 3*s:linelength/4-(s:curr_pos+2)
  else
    let s:width = 3*s:linelength/4-(s:curr_pos+3)
  endif
endfunction


" -----------------------------------------------------------------------------
" Seperators
" -----------------------------------------------------------------------------
function! Spacer#Separator()
  call s:GetCommentSymbol()
  call s:FullWidth(".")
  set formatoptions-=cro
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
  set formatoptions=qlj
endfunction

function! Spacer#SmallSeparator()
  call s:GetCommentSymbol()
  call s:SmallWidth(".")
  set formatoptions-=cro
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
  set formatoptions=qlj
endfunction


" -----------------------------------------------------------------------------
" Titles
" -----------------------------------------------------------------------------
function! Spacer#Title() range
  let current_mode = mode()
  call s:GetCommentSymbol()
  if current_mode == 'n'
    echo current_mode
    call s:GetCursorPos(".")
    call s:FullWidth(".")
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    exe cursor(s:curr_line, s:title_pos)
    exe ":startreplace"
  elseif current_mode == 'v' | current_mode == 'V'
    " echo current_mode
    " call s:GetCursorPos("'<")
    " call s:FullWidth("'<")
    " exe "\"sd"
    " let tlength = strlen(@s)
    " exe ":normal a".s:comm_char.repeat(s:sep_char, s:width).cursor(s:curr_line, s:title_pos).tlength."x\"sP"."l"."r "
    " exe current_mode
  endif
endfunction

function! Spacer#SmallTitle() range
  let current_mode = mode()
  call s:GetCommentSymbol()
  if current_mode == 'n'
    echo current_mode
    call s:GetCursorPos(".")
    call s:SmallWidth(".")
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width).cursor(s:curr_line, s:title_pos)
    exe ":startreplace"
  elseif current_mode == 'v' | current_mode == 'V'
    " echo current_mode
    " call s:GetCursorPos("'<")
    " call s:SmallWidth("'<")
    " exe "\"sd"
    " let tlength = strlen(@s)
    " exe ":normal a".s:comm_char.repeat(s:sep_char, s:width).cursor(s:curr_line, s:title_pos).tlength."x\"sP"."l"."r "
    " exe current_mode
  endif
endfunction


" Titulo Piola

" -----------------------------------------------------------------------------
" Key mappings
" -----------------------------------------------------------------------------
" Insert mode remap
  inoremap <C-s> <C-o>:call Spacer#Separator()<CR>
  inoremap <A-s> <C-o>:call Spacer#SmallSeparator()<CR>
  inoremap <C-t> <C-o>:call Spacer#Title()<CR>
  inoremap <A-t> <C-o>:call Spacer#SmallTitle()<CR>

" Normal mode remap
  nnoremap <leader>iS :call Spacer#Separator()<CR>
  nnoremap <leader>is :call Spacer#SmallSeparator()<CR>
  nnoremap <leader>iT :call Spacer#Title()<CR>
  nnoremap <leader>it :call Spacer#SmallTitle()<CR>

" Visual/Select mode remap
  vnoremap <leader>iS :call Spacer#Separator()<CR>
  vnoremap <leader>is :call Spacer#SmallSeparator()<CR>
  vnoremap <leader>iT :call Spacer#Title()<CR>
  vnoremap <leader>it :call Spacer#SmallTitle()<CR>
