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
  global let s:curr_pos  = col(".")
  let s:curr_line = line(".")
  let s:title_pos = s:curr_pos+3
endfunction

function! s:GetLineLenght()
  " TO-DO:
  " Needs to read filetype standard line length.
  let s:linelenght = 80
endfunction

function! s:FullWidth()
  call s:GetLineLenght()
  call s:GetCursorPos()

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
function! s:Separator()
  call s:GetCommentSymbol()
  call s:FullWidth()
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
endfunction

function! s:SmallSeparator()
  call s:GetCommentSymbol()
  call s:SmallWidth()
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
endfunction


" Separators with title
function! s:Title()
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

function! s:SmallTitle()
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
  inoremap <C-s> <C-o>:call s:Separator()<CR>
  inoremap <A-s> <C-o>:call s:SmallSeparator()<CR>
  inoremap <C-t> <C-o>:call s:Title()<CR>
  inoremap <A-t> <C-o>:call s:SmallTitle()<CR>
" Normal mode remap
  nnoremap <leader>iS :call s:Separator()<CR>
  nnoremap <leader>is :call s:SmallSeparator()<CR>
  nnoremap <leader>iT :call s:Title()<CR>
  nnoremap <leader>it :call s:SmallTitle()<CR>
