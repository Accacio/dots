func! config#before() abort
   let g:mapleader  = ','
   " after this line, when you using <leader> to defind key bindings
   " the leader is ,
   " for example:
  noremap <Leader>y "*y  
  noremap <Leader>Y "+y
   " this mapping means using `,w` to save current file.
endf



func! config#after() abort

endf
