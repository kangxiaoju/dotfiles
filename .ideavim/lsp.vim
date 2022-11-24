let g:WhichKeyDesc_Lsp = "g   Lsp"

let g:WhichKeyDesc_l_d = "gd   跳转声明"
nnoremap gd :action GotoDeclaration<CR>
vnoremap gd <Esc>:action GotoDeclaration<CR>

let g:WhichKeyDesc_l_i = "gi   跳转调用"
nnoremap gi :action GotoImplementation<CR>
vnoremap gi <Esc>:action GotoImplementation<CR>

" 需要AceJump 插件
let g:WhichKeyDesc_l_a = "<leader>la   光标跳转"
nnoremap <Leader>la :action AceLineAction<CR>
vnoremap <Leader>la <Esc>:action AceLineAction<CR>


let g:WhichKeyDesc_l_h = "gh   搜索方法调用"
nnoremap gh :action CallHierarchy<CR>
vnoremap gh <Esc>:action CallHierarchy<CR>
