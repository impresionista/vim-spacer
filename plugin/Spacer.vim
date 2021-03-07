" -----------------------------------------------------------------------------
" Spacer.vim - Spacer!
" Author:   Marcos Ferradas
" Version:  0.1
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" Standard variable values in case there ar not externally defined
" -----------------------------------------------------------------------------
let s:linelenght  = 80
let s:sep_char    = "-"
let s:comm_char   = "# "
let s:curr_pos    = col(".")


" -----------------------------------------------------------------------------
" Local functions
" -----------------------------------------------------------------------------
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


" -----------------------------------------------------------------------------
" Seperators
" -----------------------------------------------------------------------------
function! Spacer#Separator()
  call s:GetCommentSymbol()
  call s:FullWidth()
  set formatoptions-=cro
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
  set formatoptions=qlj
endfunction

function! Spacer#SmallSeparator()
  call s:GetCommentSymbol()
  call s:SmallWidth()
  set formatoptions-=cro
  exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)."\<CR>"
  set formatoptions=qlj
endfunction


" -----------------------------------------------------------------------------
" Titles
" -----------------------------------------------------------------------------
function! Spacer#Title()
  call s:GetCommentSymbol()
  call s:GetCursorPos()
  call s:FullWidth()
  let current_mode = mode()
  if current_mode == 'n'
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    call cursor(s:curr_line, s:title_pos)
    exe ":startreplace"
  elseif current_mode == 'v' | current_mode == 'V'
    exe "\"sd"
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    call cursor(s:curr_line, s:title_pos)
    let tlenght = strlen(@s)
    exe "normal ".tlenght."x\"sP"."l"."r "
    exe current_mode
  endif
endfunction

function! Spacer#SmallTitle()
  call s:GetCommentSymbol()
  call s:GetCursorPos()
  call s:SmallWidth()
  let current_mode = mode()
  if current_mode == 'n'
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    call cursor(s:curr_line, s:title_pos)
    exe ":startreplace"
  elseif current_mode == 'v' | current_mode == 'V'
    exe "\"sd"
    exe ":normal a".s:comm_char.repeat(s:sep_char, s:width)
    call cursor(s:curr_line, s:title_pos)
    let tlenght = strlen(@s)
    exe "normal ".tlenght."x\"sP"."l"."r "
    exe current_mode
  endif
endfunction


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
  nnoremap <leader>iS :call Spacer#Separator()<CR>
  nnoremap <leader>is :call Spacer#SmallSeparator()<CR>
  nnoremap <leader>iT :call Spacer#Title()<CR>
  nnoremap <leader>it :call Spacer#SmallTitle()<CR>
