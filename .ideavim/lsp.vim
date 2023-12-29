let g:WhichKeyDesc_Lsp = "g   Lsp"

let g:WhichKeyDesc_g_d = "gd   跳转声明"
nnoremap gd :action GotoDeclaration<CR>
vnoremap gd <Esc>:action GotoDeclaration<CR>

let g:WhichKeyDesc_g_n = "gn   跳转调用"
nnoremap gn :action GotoImplementation<CR>
vnoremap gn <Esc>:action GotoImplementation<CR>

let g:WhichKeyDesc_g_h = "gh   搜索方法调用"
nnoremap gh :action CallHierarchy<CR>
vnoremap gh <Esc>:action CallHierarchy<CR>

let g:WhichKeyDesc_g_N = "gN   跳转下个报错处"
noremap gN :action GotoNextError<CR>
vnoremap gN <Esc>:action GotoNextError<CR>

let g:WhichKeyDesc_g_B = "gB   跳转上个报错处"
noremap gB :action GotoPreviousError<CR>
vnoremap gB <Esc>:action GotoPreviousError<CR>

let g:WhichKeyDesc_g_r = "gr   最近查看文件间相互跳转"
noremap gr :action RecentFiles<CR>
vnoremap gr <Esc>:action RecentFiles<CR>

let g:WhichKeyDesc_g_b = "gb   跳转到上一个入口"
noremap gb :action Back<CR>
vnoremap gb <Esc>:action Back<CR>

