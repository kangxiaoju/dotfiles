let g:WhichKeyDesc_Project = "<leader>p   项目"

let g:WhichKeyDesc_p_m = "<leader>pm   管理最近项目"
nnoremap <Leader>pm :action ManageRecentProjects<CR>
vnoremap <Leader>pm <Esc>:action ManageRecentProjects<CR>


let g:WhichKeyDesc_c_h = "<C-h> 切换目录"
nnoremap <C-h> :action ActivateProjectToolWindow<CR>
vnoremap <C-h> <Esc>action ActivateProjectToolWindow<CR>

let g:WhichKeyDesc_p_b = "<leader>pb    项目build"
nnoremap <Leader>pb :action CompileDirty<CR>
vnoremap <Leader>pb <Esc>:action CompileDirty<CR>

let g:WhichKeyDesc_p_t = "<leader>pt    禅模式"
nnoremap <Leader>pt :action ToggleDistractionFreeMode<CR>
vnoremap <Leader>pt <Esc>:action ToggleDistractionFreeMode<CR>

