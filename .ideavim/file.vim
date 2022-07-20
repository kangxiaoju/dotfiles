let g:WhichKeyDesc_Files = "<leader>f    文件"

let g:WhichKeyDesc_f_s = "<leader>fs    文件内搜索"
nnoremap <Leader>fs :action Find<CR>
vnoremap <Leader>fs <Esc>:action Find<CR>

let g:WhichKeyDesc_f_r = "<leader>fr    文件内替换"
nnoremap <Leader>fr :action Replace<CR>
nnoremap <Leader>fr <Esc>:action Replace<CR>

let g:WhichKeyDesc_f_e = "<leader>fe    文件内重命名元素"
nnoremap <Leader>fe :action RenameElement<CR>
vnoremap <Leader>fe <Esc>:action RenameElement<CR>

let g:WhichKeyDesc_f_R = "<leader>fR    文件重命名"
nnoremap <Leader>fR :action RenameFile<CR>
vnoremap <Leader>fR <Esc>:action RenameFile<CR>

let g:WhichKeyDesc_f_c = "<leader>fc    文件格式化代码"
nnoremap <Leader>fc :action ReformatCode<CR>
vnoremap <Leader>fc <Esc>:action ReformatCode<CR>

let g:WhichKeyDesc_f_n = "<leader>fn    新建文件"
nnoremap <Leader>fn :action NewElement<CR>
vnoremap <Leader>fn <Esc>:action NewElement<CR>


