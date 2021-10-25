" 编辑模式移动键盘
inoremap <C-o> <Esc>o
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
" ctrl + s 保存文件
imap <C-S> <ESC>:w<CR>
map <C-S> :w<CR>

let s:enable_whichkey = dein#tap('vim-which-key')

function! s:load_windowmap() abort
  "switch window
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  " window
  nnoremap <Leader><TAB> <C-O><CR>
  nnoremap <leader>ws :<C-u>sp<CR>
  nnoremap <leader>wv :<C-u>vs<CR>
  nnoremap <leader>wh <C-w>h
  nnoremap <leader>wj <C-w>j
  nnoremap <leader>wk <C-w>k
  nnoremap <leader>wl <C-w>l
  nnoremap <leader>wH <C-w>H
  nnoremap <leader>wJ <C-w>J
  nnoremap <leader>wK <C-w>K
  nnoremap <leader>wL <C-w>L
  nnoremap <leader>wx <C-w>x
  nnoremap <leader>wc <C-w>c
  nnoremap <leader>wo <C-w>o
  nnoremap <leader>wR <C-w>R
  if s:enable_whichkey
    let g:which_key_map.w = { 'name': '+window'}
    let g:which_key_map['<Tab>'] = 'switch to last buffer'
    let g:which_key_map.w.s = 'horizontal split'
    let g:which_key_map.w.v = 'vertical split'
    let g:which_key_map.w.h = 'jump left window'
    let g:which_key_map.w.j = 'jump bottom window'
    let g:which_key_map.w.k = 'jump top window'
    let g:which_key_map.w.l = 'jump right window'
    let g:which_key_map.w.H = 'move window to left'
    let g:which_key_map.w.J = 'move window to bottom'
    let g:which_key_map.w.K = 'move window to top'
    let g:which_key_map.w.L = 'move window to right'
    let g:which_key_map.w.x = 'swap window'
    let g:which_key_map.w.c = 'close window'
    let g:which_key_map.w.o = 'close other window'
    let g:which_key_map.w.R = 'spin window'
  endif
  " settings to resize split window
  nmap <C-w>[ :vertical resize -3<CR>
  nmap <C-w>] :vertical resize +3<CR>
endfunction

function! s:load_telescopemap() abort
  if dein#tap('telescope.nvim')
    nnoremap <silent> <Leader>fa :<C-u>Telescope live_grep<CR>
    nnoremap <silent> <Leader>fm :<C-u>Telescope marks<CR>
    nnoremap <silent> <Leader>fb :<C-u>Telescope buffers<CR>
    nnoremap <silent> <Leader>ft :<C-u>Telescope tags<CR>
    "like emacs counsel-find-file
    nnoremap <silent> <Leader>ff :<C-u>Telescope find_files<CR>
    nnoremap <silent> <Leader>fg :<C-u>Telescope git_files<CR>
    nnoremap <silent> <Leader>fr :<C-u>Telescope registers<CR>
    nnoremap <silent> <Leader>fh :<C-u>Telescope command_history<CR>
    nnoremap <silent> <Leader>fc :<C-u>Telescope current_buffer_fuzzy_find<CR>
    nnoremap <silent> <Leader>fT :<C-u>Telescope current_buffer_tags<CR>
    " let g:which_key_map.b.b = 'Buffer List'
    if s:enable_whichkey
      let g:which_key_map.f = { 'name': '+Find'}
      let g:which_key_map.f.a = 'Find Word'
      let g:which_key_map.f.m = 'Find Marks'
      let g:which_key_map.f.b = 'Find Buffers'
      let g:which_key_map.f.t = 'Find tags'
      let g:which_key_map.f.f = 'Find File'
      let g:which_key_map.f.g = 'Find files with git'
      let g:which_key_map.f.r = 'Find 寄存器'
      let g:which_key_map.f.h = 'Find history'
      let g:which_key_map.f.c = 'Find buffer str'
      let g:which_key_map.f.T = 'Find buffer tags'
    endif
  endif
endfunction

function! s:load_vista() abort
  if dein#tap('vista.vim')
    nnoremap <silent> <Leader>v :<C-u>Vista!!<CR>
    if s:enable_whichkey
      let g:which_key_map.v = 'Vista'
    endif
  endif
endfunction

function! s:load_coc() abort
  if dein#tap('coc.nvim')
    nnoremap <silent> <Leader>e :<C-u>CocCommand explorer<CR>
    if s:enable_whichkey
      let g:which_key_map.e = 'Open CocCommand explorer'
    endif
  endif
endfunction

function! s:load_buffet() abort
  nnoremap  ]b :<C-u>bp<CR>
  nnoremap  [b :<C-u>bn<CR>
  nnoremap <silent> <Leader>bd :bp<bar>bd #<CR>
  nnoremap <silent> <Leader>bk :bd<CR>
  nnoremap <silent> <Leader>bb :<C-u>Telescope buffers<CR>
  nmap <Leader>1 <Plug>lightline#bufferline#go(1)
  nmap <Leader>2 <Plug>lightline#bufferline#go(2)
  nmap <Leader>3 <Plug>lightline#bufferline#go(3)
  nmap <Leader>4 <Plug>lightline#bufferline#go(4)
  nmap <Leader>5 <Plug>lightline#bufferline#go(5)
  nmap <Leader>6 <Plug>lightline#bufferline#go(6)
  nmap <Leader>7 <Plug>lightline#bufferline#go(7)
  nmap <Leader>8 <Plug>lightline#bufferline#go(8)
  nmap <Leader>9 <Plug>lightline#bufferline#go(9)
  nmap <Leader>0 <Plug>lightline#bufferline#go(10)
  if s:enable_whichkey
    let g:which_key_map.b = { 'name': '+buffer' }
    let g:which_key_map.b.d = 'keep current buffer'
    let g:which_key_map.b.k = 'remove all buffers'
    let g:which_key_map.b.b = 'show all buffers'
    let g:which_key_map.1 = 'select buffer-1'
    let g:which_key_map.2 = 'select buffer-2'
    let g:which_key_map.3 = 'select buffer-3'
    let g:which_key_map.4 = 'select buffer-4'
    let g:which_key_map.5 = 'select buffer-5'
    let g:which_key_map.6 = 'select buffer-6'
    let g:which_key_map.7 = 'select buffer-7'
    let g:which_key_map.8 = 'select buffer-8'
    let g:which_key_map.9 = 'select buffer-9'
    let g:which_key_map.0 = 'select buffer-0'
  endif
endfunction

let s:plugins = {
  \ 'windowmap':'window','telescopemap':'telescope.nvim','vista':'vista.vim','coc':'coc.vim','buffet':'buffet'
  \ }

function! s:load_plugins_keybinds(pmap) abort
  for key in keys(a:pmap)
    try
      exec 'call s:load_'.key.'()'
    catch /.*/
      echo 'Load plugins keybinds error:' . v:exception
    finally
    endtry
  endfor
endfunction

function! s:get_key(value,pmap) abort
  for [key,val] in items(a:pmap)
    if val ==? a:value
      return key
    endif
  endfor
  return ''
endfunction

function! s:load_keybinds(plugins) abort
  let pmap = copy(a:plugins)
  while g:thinkvim_disable_mappings
    return
  endwhile
  if empty(g:thinkvim_disable_pmaping)
    call s:load_plugins_keybinds(pmap)
  else
    for i in g:thinkvim_disable_pmaping
      if index(values(pmap),i) >= 0
        let key = s:get_key(i, pmap)
        call remove(pmap,key)
      endif
    endfor
    call s:load_plugins_keybinds(pmap)
  endif
endfunction

call s:load_keybinds(s:plugins)
