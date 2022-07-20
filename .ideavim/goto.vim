let g:WhichKeyDesc_Goto = "<leader>t   跳转"

let g:WhichKeyDesc_t_d = "<leader>td   跳转声明"
nnoremap <Leader>td :action GotoDeclaration<CR>
vnoremap <Leader>td <Esc>:action GotoDeclaration<CR>

let g:WhichKeyDesc_t_i = "<leader>ti   跳转调用"
nnoremap <Leader>ti :action GotoImplementation<CR>
vnoremap <Leader>ti <Esc>:action GotoImplementation<CR>

" 需要AceJump 插件
let g:WhichKeyDesc_t_a = "<leader>ta   光标跳转"
nnoremap <Leader>ta :action AceLineAction<CR>
vnoremap <Leader>ta <Esc>:action AceLineAction<CR>

