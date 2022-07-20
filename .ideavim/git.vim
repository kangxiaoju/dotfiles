let g:WhichKeyDesc_Git = "<leader>g   Git"

let g:WhichKeyDesc_g_p = "<leader>gp   Git pull"
nnoremap <Leader>gp :action Vcs.UpdateProject<CR>
vnoremap <Leader>gp <Esc>:action Vcs.UpdateProject<CR>

let g:WhichKeyDesc_g_P = "<leader>gP   Git push"
nnoremap <Leader>gP :action Vcs.Push<CR>
vnoremap <Leader>gP <Esc>:action Vcs.Push<CR>

let g:WhichKeyDesc_g_b = "<leader>gb   Git Branches"
nnoremap <Leader>gb :action Git.Branches<CR>
vnoremap <Leader>gb <Esc>:action Git.Branches<CR>

let g:WhichKeyDesc_g_h = "<leader>gh   Git History"
nnoremap <Leader>gh :action Vcs.ShowTabbedFileHistory<CR>
vnoremap <Leader>gh <Esc>:action Vcs.ShowTabbedFileHistory<CR>

let g:WhichKeyDesc_g_c = "<leader>gc   Git commit"
nnoremap <Leader>gc :action Vcs.Show.Local.Changes<CR>
vnoremap <Leader>gc <Esc>:action Vcs.Show.Local.Changes<CR>

let g:WhichKeyDesc_g_a = "<leader>ga   Git Annotate"
nnoremap <Leader>ga :action Annotate<CR>
vnoremap <Leader>ga <Esc>:action Annotate<CR>


let g:WhichKeyDesc_g_l = "<leader>gl   Git Log"
nnoremap <Leader>gl :action Vcs.Show.Log<CR>
vnoremap <Leader>gl <Esc>:action Vcs.Show.Log<CR>

