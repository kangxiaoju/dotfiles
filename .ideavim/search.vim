let g:WhichKeyDesc_Buffer = "<leader>s   搜索"

let g:WhichKeyDesc_s_a = "<leader>se   搜索所有"
nnoremap <Leader>sa :action SearchEverywhere<CR>
vnoremap <Leader>sa <Esc>:action SearchEverywhere<CR>

let g:WhichKeyDesc_s_r = "<leader>sr   全局替换"
nnoremap <Leader>sr :action ReplaceInPath<CR>
vnoremap <Leader>sr <Esc>:action ReplaceInPath<CR>

let g:WhichKeyDesc_s_F = "<leader>sa   全局搜索"
nnoremap <Leader>sF :action FindInPath<CR>
vnoremap <Leader>sF <Esc>:action FindInPath<CR>

let g:WhichKeyDesc_s_A = "<leader>sA   搜索Action"
nnoremap <Leader>sA :action GotoAction<CR>
vnoremap <Leader>sA <Esc>:action GotoAction<CR>

let g:WhichKeyDesc_s_c = "<leader>sc   搜索Class"
nnoremap <Leader>sc :action GotoClass<CR>
vnoremap <Leader>sc <Esc>:action GotoClass<CR>

let g:WhichKeyDesc_s_f = "<leader>sf   搜索文件"
nnoremap <Leader>sf :action GotoFile<CR>
vnoremap <Leader>sf <Esc>:action GotoFile<CR>

let g:WhichKeyDesc_s_h = "<leader>sh   搜索方法调用"
nnoremap <Leader>sh :action CallHierarchy<CR>
vnoremap <Leader>sh <Esc>:action CallHierarchy<CR>

let g:WhichKeyDesc_s_s = "<leader>ss   搜索Symbol"
nnoremap <Leader>ss :action GotoSymbol<CR>
vnoremap <Leader>ss <Esc>:action GotoSymbol<CR>
