let g:WhichKeyDesc_Buffer = "<leader>s   搜索"

let g:WhichKeyDesc_s_a = "<leader>sa   搜索所有"
nnoremap <Leader>sa :action SearchEverywhere<CR>
vnoremap <Leader>sa <Esc>:action SearchEverywhere<CR>

let g:WhichKeyDesc_s_p = "<leader>sp   全局搜索"
nnoremap <Leader>sp :action FindInPath<CR>
vnoremap <Leader>sp <Esc>:action FindInPath<CR>

let g:WhichKeyDesc_s_A = "<leader>sA   搜索Action"
nnoremap <Leader>sA :action GotoAction<CR>
vnoremap <Leader>sA <Esc>:action GotoAction<CR>

let g:WhichKeyDesc_s_c = "<leader>sc   搜索Class"
nnoremap <Leader>sc :action GotoClass<CR>
vnoremap <Leader>sc <Esc>:action GotoClass<CR>

let g:WhichKeyDesc_s_f = "<leader>sf   搜索文件"
nnoremap <Leader>sf :action GotoFile<CR>
vnoremap <Leader>sf <Esc>:action GotoFile<CR>

let g:WhichKeyDesc_s_s = "<leader>ss   搜索Symbol"
nnoremap <Leader>ss :action GotoSymbol<CR>
vnoremap <Leader>ss <Esc>:action GotoSymbol<CR>

let g:WhichKeyDesc_s_b = "<leader>sb   缓冲区搜索"
nnoremap <Leader>sb :action Switcher<CR>
vnoremap <Leader>sb <Esc>:action Switcher<CR>

let g:WhichKeyDesc_s_w = "<leader>sw   文件内搜索文本"
nnoremap <Leader>sw :action Find<CR>
vnoremap <Leader>sw <Esc>:action Find<CR>
