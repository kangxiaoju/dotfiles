" 主题 {{{
" --------
syntax on
colorscheme dracula
" }}}
" 基础配置 {{{
" --------
set formatoptions-=o         " disable comment-continuation (normal 'o'/'o')
set nowrap
set ic
" }}}

" 开启行号 {{{
" --------
set number
set relativenumber
highlight Normal guibg=NONE
highlight LineNr guifg=#9BB971
hi Normal ctermfg=252 ctermbg=none
" }}}

" 状态栏配置 {{{
" --------
let g:gitline_branch_name_prefix = " "
let g:gitline_file_count_prefix = " "
set showtabline=2
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = {
\ 0: '|0>', 1: '|1>', 2: '|2>', 3: '|3>', 4: '|4>',
\ 5: '|5>', 6: '|6>', 7: '|7>', 8: '|8>', 9: '|9>'}
let g:lightline                  = {
      \ 'colorscheme': 'one',
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'branchname', 'fetchstatus', 'filecount', 'filename', 'filestatus', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'filecount': 'gitline#FileCount',
      \   'branchname': 'gitline#BranchName',
      \   'filestatus': 'gitline#FileStatus',
      \   'fetchstatus': 'gitline#FetchStatus'
      \ },
      \ }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#enable_devicons = 1
" }}}

" 退出编辑后，自动关闭所有buffer {{{
" --------
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
" }}} 

" 设置快捷键 {{{
" --------
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
let g:which_key_map =  { 'name' : 'Leader'}
let g:which_key_localmap =  {'name' : 'LocalLeader'}
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
function! s:register_whichkey()
  let s:leader_key=substitute(get(g:,"mapleader","\\"), ' ', '<Space>', '')
  let s:localleader_key= get(g:,'maplocalleader',';')
  call which_key#register(s:leader_key, 'g:which_key_map')
  call which_key#register(s:localleader_key, 'g:which_key_localmap')
endfunction
call s:register_whichkey()
set timeoutlen=500
" }}}

" startify 艺术字 {{{
" --------
let g:startify_custom_header = startify#pad(split(system('figlet -w 100 Kael'), '\n'))
" }}}

" undo开启，并设置保存地址 {{{
" --------
set undofile
set undodir=~/.cache/vim/undo
" }}}

" tab变成4个空格 {{{
" --------
set ts=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
" }}}

" 缩进配置indentLine {{{
" --------
let g:indentLine_enabled = 1
let g:indentLine_char='┆'
let g:indentLine_fileTypeExclude = ['defx', 'denite', 'dashboard', 'tagbar', 'vista_kind', 'vista']
let g:indentLine_concealcursor = 'niv'
let g:indentLine_showFirstIndentLevel =1
" }}}

" vim寄存器和系统剪切板互用 {{{
" --------
set clipboard& clipboard+=unnamedplus
" }}}
" 着色器配置 {{{
" --------
set termguicolors
" }}}

" 彩色括号 {{{
" --------
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {
	\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'vue': {
  \     'parentheses': ['start=/{/ end=/}/ fold contains=@javaScript containedin=@javaScript', 'start=/(/ end=/)/ fold contains=@javaScript containedin=@javaScript', 'start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\	}
	\}
" }}}
" coc.nvim配置 {{{
" --------
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'
let g:coc_disable_transparent_cursor = 1

let g:coc_global_extensions =[
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-vimlsp',
    \ 'coc-snippets',
    \ 'coc-emmet',
    \ 'coc-pairs',
    \ 'coc-json',
    \ 'coc-highlight',
    \ 'coc-git',
    \ 'coc-emoji',
    \ 'coc-lists',
    \ 'coc-yaml',
    \ 'coc-tabnine',
    \ 'coc-gitignore',
    \ 'coc-yank',
    \ 'coc-explorer',
    \ 'coc-actions',
    \ 'coc-db',
    \ 'coc-spell-checker',
    \ 'coc-java',
    \ 'coc-vetur',
    \ 'coc-python',
    \ 'coc-rust-analyzer',
    \]

augroup MyAutoCmd
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

"Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:lsp_init(langs)
  let l:lsp={
    \'go':{'golang': {
          \ "command": "gopls",
          \ "rootPatterns": ["go.mod"],
          \ "disableWorkspaceFolders": "true",
          \ "filetypes": ["go"]
          \ }
          \ },
    \'dockerfile':{'dockerfile': {
          \ "command": "docker-langserver",
          \ "filetypes": ["dockerfile"],
          \ "args": ["--stdio"]
          \ }
          \ },
    \'sh':{'bash': {
          \ "command": "bash-language-server",
          \ "args": ["start"],
          \ "filetypes": ["sh"],
          \ "ignoredRootPaths": ["~"]
          \ }
          \ },
    \'c/cpp':{'ccls': {
        \ "command": "ccls",
        \ "rootPatterns": [".ccls", "compile_commands.json", ".git/", ".hg/"],
        \ "filetypes": ["c","cpp","objc","objcpp"],
        \ "initializationOptions": {
          \ "cache":{
            \ "directory": "/tmp/ccls"
        \ }
        \ }
        \ }
        \},
    \'haskell':{'haskell': {
        \ "command": "hie-wrapper",
        \ "rootPatterns": [".stack.yaml","cabal.config","package.yaml"],
        \ "filetypes": ["hs","lhs","haskell"],
        \ "initializationOptions":{},
        \ "settings":{
          \ "languageServerHaskell":{
            \ "hlintOn":"true",
            \ "maxNumberOfProblems":10,
            \ "completionSnippetsOn": "true"
        \ }
        \ }
        \ }
        \},
    \'rust':{'rust': {
        \ "command": "rust-analyzer",
        \ "filetypes": ["rust"],
        \ "rootPatterns": ["Cargo.toml"]
        \ }
        \},
    \}[a:langs]
  call coc#config('languageserver',l:lsp)
  exec 'autocmd BufWritePre *.'.a:langs. '    call s:silent_organizeImport()'
endfunction

function! s:silent_organizeImport()
  silent! call CocAction('runCommand', 'editor.action.organizeImport')
endfunction

command! -nargs=+ -bar LSP          call s:lsp_init(<args>)
" }}}

" 自动生成tags配置 {{{
" --------
let g:gutentags_cache_dir =  '~/.cache/tags'
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project','go.mod','.Cargo.toml','tsconfig.js','jsconfig.js']
let g:gutentags_generate_on_write = 0
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude_filetypes = [ 'defx', 'denite', 'vista', 'magit' ]
" }}}

" 记住文件上次打开位置 {{{
" --------
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
" }}}

" vista {{{
let g:vista#renderer#enable_icon = 1
let g:vista_disable_statusline = 1
let g:vista_default_executive = 'ctags'
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_vimwiki_executive = 'markdown'
let g:vista_executive_for = {
  \ 'vimwiki': 'markdown',
  \ 'pandoc': 'markdown',
  \ 'markdown': 'toc',
  \ 'yaml': 'coc',
  \ 'typescript': 'coc',
  \ 'typescriptreact': 'coc',
  \ }
" }}}

" java {{{
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" }}}
