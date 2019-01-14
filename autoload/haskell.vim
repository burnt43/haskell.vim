function! haskell#OpenOrFocusBuffer(buffer_name)
  let buffer_number = bufwinnr(a:buffer_name)

  if buffer_number >= 0
    execute buffer_number . "wincmd w"
    return 0
  else
    execute "split " . a:buffer_name
    return 1
  endif
endfunction

function! haskell#CompileAndRun()
  write

  let source_full_path = fnamemodify(bufname("%"), ":p")
  let bin_full_path    = fnamemodify(bufname("%"), ":p:r")

  call haskell#OpenOrFocusBuffer('__Haskell_Output__')

  normal! ggdG

  setlocal filetype=haskelloutput
  setlocal buftype=nofile

  " echom("compiling...")

  execute "silent read! ghc -dynamic " . source_full_path . " && " . bin_full_path
  normal! ggdd
endfunction
