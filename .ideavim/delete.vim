let g:WhichKeyDesc_Delete = "<leader>d   删除"

let g:WhichKeyDesc_d_o = "<leader>do   删除多余引用类"
nnoremap <Leader>do :action OptimizeImports<CR>
vnoremap <Leader>do <Esc>:action OptimizeImports<CR>
