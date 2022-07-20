let g:WhichKeyDesc_View = "<leader>v   视图"

let g:WhichKeyDesc_v_r = "<leader>vr   run视图"
nnoremap <Leader>vr :action ChooseDebugConfiguration<CR>
vnoremap <Leader>vr <Esc>:action ChooseDebugConfiguration<CR>

let g:WhichKeyDesc_v_c = "<leader>vm   fileMenu视图"
nnoremap <Leader>vm :action FileMenu<CR>
vnoremap <Leader>vm <Esc>:action FileMenu<CR>

let g:WhichKeyDesc_v_v = "<leader>vv 左右视图"
nnoremap <leader>vv    :action SplitVertically<CR>
vnoremap <leader>vv    <Esc>:action SplitVertically<CR>

let g:WhichKeyDesc_v_H = "<leader>vH 上下视图"
nnoremap <leader>vH    :action SplitHorizontally<CR>
vnoremap <leader>vH    <Esc>:action SplitHorizontally<CR>

let g:WhichKeyDesc_v_h = "<leader>vh 光标左移动"
nnoremap <leader>vh    <C-w>h
vnoremap <leader>vh    <Esc><C-w>h

let g:WhichKeyDesc_v_j = "<leader>vj 光标下移动"
nnoremap <leader>vj    <C-w>j
vnoremap <leader>vj    <Esc><C-w>j

let g:WhichKeyDesc_v_k = "<leader>vk 光标上移动"
nnoremap <leader>vk    <C-w>k
vnoremap <leader>vk    <Esc><C-w>k

let g:WhichKeyDesc_v_l = "<leader>vl 光标右移动"
nnoremap <leader>vl    <C-w>l
vnoremap <leader>vl    <Esc><C-w>l

let g:WhichKeyDesc_v_u = "<leader>vu showUsages"
nnoremap <leader>vu    :action ShowUsages<CR>
vnoremap <leader>vu    <Esc>:action ShowUsages<CR>

let g:WhichKeyDesc_v_p = "<leader>vp 插件"
nnoremap <leader>vp    :action WelcomeScreen.Plugins<CR>
vnoremap <leader>vp    <Esc>:action WelcomeScreen.Plugins<CR>


