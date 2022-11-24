let g:WhichKeyDesc_Buffer = "<leader>f   搜索"

let g:WhichKeyDesc_f_w = "<leader>fw   搜索所有"
nnoremap <Leader>fw :action SearchEverywhere<CR>
vnoremap <Leader>fw <Esc>:action SearchEverywhere<CR>

let g:WhichKeyDesc_f_r = "<leader>fr   全局替换"
nnoremap <Leader>fr :action ReplaceInPath<CR>
vnoremap <Leader>fr <Esc>:action ReplaceInPath<CR>

let g:WhichKeyDesc_f_F = "<leader>fa   全局搜索"
nnoremap <Leader>fF :action FindInPath<CR>
vnoremap <Leader>fF <Esc>:action FindInPath<CR>

let g:WhichKeyDesc_f_A = "<leader>fA   搜索Action"
nnoremap <Leader>fA :action GotoAction<CR>
vnoremap <Leader>fA <Esc>:action GotoAction<CR>

let g:WhichKeyDesc_f_c = "<leader>fc   搜索Class"
nnoremap <Leader>fc :action GotoClass<CR>
vnoremap <Leader>fc <Esc>:action GotoClass<CR>

let g:WhichKeyDesc_f_f = "<leader>ff   搜索文件"
nnoremap <Leader>ff :action GotoFile<CR>
vnoremap <Leader>ff <Esc>:action GotoFile<CR>

let g:WhichKeyDesc_f_s = "<leader>fs   搜索Symbol"
nnoremap <Leader>fs :action GotoSymbol<CR>
vnoremap <Leader>fs <Esc>:action GotoSymbol<CR>

let g:WhichKeyDesc_f_b = "<leader>fb   缓冲区搜索"
nnoremap <Leader>fb :action Switcher<CR>
vnoremap <Leader>fb <Esc>:action Switcher<CR>
