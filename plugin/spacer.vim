" spacer.vim - Spacer!
" Author:   Marcos Ferradas
" Version:  0.1

" Standard variable values in case there ar not externally defined
  let linelenght  = 80
  let sep_char    = "-"
  let comm_char   = "# "
  let curr_pos    = col(".")

" Local functions
function! s:GetCommentSymbol()
  let com_char = split(&commentstring, '%s')[0]
endfunction

function! s:GetCursorPos()
  let curr_pos  = col(".")
  let curr_line = line(".")
  let title_pos = curr_pos+3
endfunction

function! s:GetLineLenght()
  " TO-DO:
  " Needs to read filetype standard line length.
  let linelenght = 80
endfunction

function! s:FullWidth()
  call s:GetLineLenght()
  call s:GetCursorPos()
  if curr_pos == 1
    let width = linelenght-(curr_pos+2)
  else
    let width = linelenght-(curr_pos+3)
  endif
endfunction

function! s:SmallWidth()
  call s:GetLineLenght()
  call s:GetCursorPos()
  if curr_pos == 1
    let width = 3*linelenght/4-(curr_pos+2)
  else
    let width = 3*linelenght/4-(curr_pos+3)
  endif
endfunction


" Seperators
function! Separator()
  call s:GetCommentSymbol()
  call s:FullWidth()
  exe ":normal a".comm_char.repeat(sep_char, width)."\<CR>"
endfunction

function! SmallSeparator()
  call s:GetCommentSymbol()
  call s:SmallWidth()
  exe ":normal a".comm_char.repeat(sep_char, width)."\<CR>"
endfunction


" Separators with title
function! Title()
  call s:GetCommentSymbol()
  call s:GetCursorPos()
  call s:FullWidth()
  let current_mode = mode()
  if current_mode == 'n'
    exe ":normal a".comm_char.repeat(sep_char, width)
    call cursor(curr_line, tittle_pos)
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
    exe ":normal a".comm_char.repeat(sep_char, width)
    call cursor(curr_line, tittle_pos)
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
