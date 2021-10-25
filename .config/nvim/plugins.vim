if &compatible
  set nocompatible " Be iMproved
endif

let s:dein_path = '~/.cache/dein'

" Required:
" Add the dein installation directory into runtimepath
let &runtimepath = &runtimepath.','.s:dein_path.'/repos/github.com/Shougo/dein.vim'

if dein#load_state(s:dein_path)

  call dein#begin(s:dein_path)
  
  " Let dein manage dein
  call dein#add('~/.cache/dein'.'/repos/github.com/Shougo/dein.vim')
  call dein#add('wsdjeg/dein-ui.vim')
  
  " Add or remove your plugins here like this:
  " 主题
  call dein#add('dracula/vim', {'name': 'dracula'})
  call dein#add('sainnhe/sonokai')
  " 快捷键
  call dein#add('liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] })
  " 状态栏
  call dein#add('itchyny/lightline.vim')
  call dein#add('mengelbrecht/lightline-bufferline')
  " git状态栏
  call dein#add('APZelos/gitline.vim')
  " git插件
  call dein#add('tpope/vim-fugitive')
  " fcitx5自动切换中英文输入法
  call dein#add('520Matches/fcitx5.vim')
  " 注释
  call dein#add('tpope/vim-commentary')
  " 日志
  call dein#add('MTDL9/vim-log-highlighting')
  " 搜索
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-telescope/telescope.nvim') 
  " 首页
  call dein#add('mhinz/vim-startify')
  " 自动补全括号
  call dein#add('jiangmiao/auto-pairs')
  " 保留修改历史
  call dein#add('simnalamburt/vim-mundo')
  " 显示缩进
  call dein#add('Yggdroot/indentLine')
  " 多光标
  call dein#add('mg979/vim-visual-multi', {'branch': 'master'})
  " 打开内嵌终端
  call dein#add('skywind3000/vim-terminal-help')
  " 浏览tags
  call dein#add('liuchengxu/vista.vim')
  " lsp coc
  call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
  " emmet
  call dein#add('mattn/emmet-vim')
  " 颜色显示
  call dein#add('norcalli/nvim-colorizer.lua')
  " unicode图标支持
  call dein#add('ryanoasis/vim-devicons')
  " 彩虹括号
  call dein#add('luochen1990/rainbow')
  " tags 管理
  call dein#add('ludovicchabant/vim-gutentags')
  " 选中操作文本
  call dein#add('gcmt/wildfire.vim')
  call dein#add('machakann/vim-sandwich')
  " 显示寄存器内容
  call dein#add('junegunn/vim-peekaboo')
  " 语法支持
  call dein#add('artur-shaik/vim-javacomplete2')
  call dein#add('rust-lang/rust.vim')
  call dein#add('posva/vim-vue')
  call dein#add('honza/vim-snippets')
  call dein#add('pangloss/vim-javascript')
  call dein#add('iloginow/vim-stylus')
  call dein#add('othree/html5.vim')
  call dein#add('yuezk/vim-js')
  call dein#add('moll/vim-node')
  call dein#add('jparise/vim-graphql')
  call dein#add('groenewege/vim-less')
  call dein#add('hail2u/vim-css3-syntax')
  call dein#add('arzg/vim-sh')
  call dein#add('dart-lang/dart-vim-plugin')
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('hardcoreplayers/sql.vim')

  call dein#end()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
