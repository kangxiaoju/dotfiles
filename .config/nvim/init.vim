" disable all keymaps of plugins
let g:thinkvim_disable_mappings = 0
" disable some plugins keymap
let g:thinkvim_disable_pmaping = []
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugins.vim'
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/main.vim'
execute 'source' fnamemodify(expand('<sfile>'), ':h').'/keybinds.vim'
luafile ~/.config/nvim/main.lua
