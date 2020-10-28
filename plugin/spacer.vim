" spacer.vim - Spacer!
" Author:   Marcos Ferradas
" Version:  0.1

" Standard variable values in case there ar not externally defined
  let s:linelenght  = 80
  let s:sep_char    = "-"
  let s:comm_char   = "# "
  let s:curr_pos    = col(".")

" Local functions
function! s:GetCommentSymbol()
  let s:comm_char = split(&commentstring, '%s')[0]."\<space>"
endfunction

function! s:GetCursorPos()
  let s:curr_pos  = col(".")
  let s:curr_line = line(".")
  let s:title_pos = s:curr_pos+2
endfunction

function! s:GetLineLenght()
  " TO-DO:
  " Needs to read filetype standard line length.
  let s:linelenght = 80
endfunction

function! s:FullWidth()
  call s:GetLineLenght()
  call s:GetCursorPos()
  if s:curr_pos == 1
    let s:width = s:linelenght-(s:curr_pos+2)
  else
    let s:width = s:linelenght-(s:curr_pos+3)
  endif
endfunction

function! s:SmallWidth()
  call s:GetLineLenght()
  call s:GetCursorPos()
  if s:curr_pos == 1
    let s:width = 3*s:linelenght/4-(s:curr_pos+2)
  else
    let s:width = 3*s:linelenght/4-(s:curr_pos+3)
  endif
endfunction


" Seperators
function! Separator()
  call s:GetCommentSymbol()
  call s:FullWidth()
  set formatoptions-=cro
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
  set formatoptions=qlj
endfunction

function! SmallSeparator()
  call s:GetCommentSymbol()
  call s:SmallWidth()
  set formatoptions-=cro
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
  set formatoptions=qlj
endfunction


" Separators with title
function! Title()
  call s:GetCommentSymbol()
  call s:GetCursorPos()
  call s:FullWidth()
  let current_mode = mode()
  if current_mode == 'n'
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    call cursor(s:curr_line, s:title_pos)
    exe ":startreplace"
  elseif current_mode == 'v' | current_mode == 'V'
    " TO-DO:
    " Convert selected text to title
  endif
endfunction

function! SmallTitle()
  call s:GetCommentSymbol()
  call s:GetCursorPos()
  call s:SmallWidth()
  let current_mode = mode()
  if current_mode == 'n'
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    call cursor(s:curr_line, s:title_pos)
    exe ":startreplace"
  elseif current_mode == 'v' | current_mode == 'V'
    " TO-DO:
    " Convert selected text to title
  endif
endfunction


" Key mappings
" Insert mode remap
  inoremap <C-s> <C-o>:call Separator()<CR>
  inoremap <A-s> <C-o>:call SmallSeparator()<CR>
  inoremap <C-t> <C-o>:call Title()<CR>
  inoremap <A-t> <C-o>:call SmallTitle()<CR>
" Normal mode remap
  nnoremap <leader>iS :call Separator()<CR>
  nnoremap <leader>is :call SmallSeparator()<CR>
  nnoremap <leader>iT :call Title()<CR>
  nnoremap <leader>it :call SmallTitle()<CR>
