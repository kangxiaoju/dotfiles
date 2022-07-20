let g:WhichKeyDesc_Project = "<leader>p   项目"

let g:WhichKeyDesc_p_m = "<leader>pm   管理最近项目"
nnoremap <Leader>pm :action ManageRecentProjects<CR>
vnoremap <Leader>pm <Esc>:action ManageRecentProjects<CR>


let g:WhichKeyDesc_p_e = "<leader>pe 切换目录"
nnoremap <leader>pe :action ActivateProjectToolWindow<CR>
vnoremap <leader>pe <Esc>action ActivateProjectToolWindow<CR>

let g:WhichKeyDesc_p_b = "<leader>pb    项目build"
nnoremap <Leader>pb :action CompileDirty<CR>
vnoremap <Leader>pb <Esc>:action CompileDirty<CR>
