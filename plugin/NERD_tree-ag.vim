" ============================================================================
" File:        NERD_tree-ag.vim
" Description: Adds searching capabilities to NERD_Tree with the silver searcher
" Original Author:  Mohammad Satrio <wolfaeon at gmail dot com>
" Maintainer:  Taian Su<taiansu at gmail dot com>
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================


" don't load multiple times
if exists("g:loaded_nerdtree_ag")
    finish
endif

let g:loaded_nerdtree_ag = 1

" add the new menu item via NERD_Tree's API
call NERDTreeAddMenuItem({
    \ 'text': '(s)earch directory',
    \ 'shortcut': 's',
    \ 'callback': 'NERDTreeAg' })

function! NERDTreeAg()
    " get the current dir from NERDTree
    let cd = g:NERDTreeDirNode.GetSelected().path.str()

    " get the pattern
    let pattern = input("Enter the pattern: ")
    if pattern == ''
        echo 'Maybe another time...'
        return
    endif
    let old_shellpipe = &shellpipe
    try
      "a hack for *nix to ensure the grep output isnt echoed in vim
      let &shellpipe='&>'
      exec "Ag! ".pattern." ".cd
    finally
      let &shellpipe = old_shellpipe
    endtry
endfunction
