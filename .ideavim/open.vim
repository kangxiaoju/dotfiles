let g:WhichKeyDesc_Open = "<leader>o   打开"

let g:WhichKeyDesc_o_f = "<leader>of   打开文件"
nnoremap <Leader>of :action OpenFile<CR>
vnoremap <Leader>of <Esc>:action OpenFile<CR>

let g:WhichKeyDesc_o_t = "<leader>ot   打开终端"
noremap <Leader>ot :action ActivateTerminalToolWindow<CR>
vnoremap <Leader>ot <Esc>:action ActivateTerminalToolWindow<CR>

let g:WhichKeyDesc_o_s = "<leader>os   打开SelectIn"
nnoremap <Leader>os :action SelectIn<CR>
vnoremap <Leader>os <Esc>:action SelectIn<CR>

let g:WhichKeyDesc_o_i = "<leader>oi 插入模版"
nnoremap <leader>oi    :action InsertLiveTemplate<CR>
vnoremap <leader>oi    <Esc>:action InsertLiveTemplate<CR>
