let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
let g:tagbar_ctags_bin = '/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'

call plug#begin()
	Plug 'joshdick/onedark.vim'
	Plug 'vim-airline/vim-airline'
	" :StripWhitespace
	Plug 'ntpeters/vim-better-whitespace'
	" Visualize identation line
	Plug 'Yggdroot/indentLine'
	" :NERDTreeToggle"
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	" CTag - :TagbarToggle
	Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
	" NeoTerm :Tnew
	Plug 'kassio/neoterm'
	" Tarinling
	Plug 'ntpeters/vim-better-whitespace'
	" Multi Languages Syntax Coloring
	Plug 'sheerun/vim-polyglot'
	" Linter
	Plug 'dense-analysis/ale'
	"Coc
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'neoclide/coc-tsserver', {'do': 'npm i package.json && npm i'}
	" Coc Intelphense
	Plug 'yaegassy/coc-intelephense'
	" Comment-out - `gc` makes single line, `gcc` make multiple lines in VISUAL mode
	Plug 'tpope/vim-commentary'
	" S" cs"' ds'
	Plug 'tpope/vim-surround'
	" auto brackets
	Plug 'jiangmiao/auto-pairs'
	" Git diff
	Plug 'airblade/vim-gitgutter'
	" SourceTree plugin: Diff per file with NerdTree
	Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
	" fugit
	Plug 'tpope/vim-fugitive'
	" Markdown Editor and Preview
	" Require following:
	" `Deno`: brew install deno
	" cd ~/.local/share/nvim/plugged/peek.nvim
	" Finally you can use vim commands `PeekOpen` and `PeekClose`.
	Plug 'toppair/peek.nvim', { 'do': 'deno task --quiet build:fast' }
call plug#end()

" peek.nvim の設定 "
lua << EOF
require('peek').setup({
  auto_load = true,        -- 別のマークダウンバッファに入るときに自動的にプレビューを読み込むかどうか
  close_on_bdelete = true, -- バッファを削除するときにプレビューウィンドウを閉じるかどうか
  syntax = true,           -- シンタックスハイライトを有効にする（パフォーマンスに影響します）
  theme = 'dark',          -- 'dark' または 'light'
  update_on_change = true,
  app = 'webview',         -- 'webview', 'browser', または特定のブラウザを指定
  filetype = { 'markdown' },-- マークダウンとして認識するファイルタイプのリスト
  -- update_on_change が true の場合に関連
  throttle_at = 200000,    -- このバイト数を超えるとスロットリングを開始
  throttle_time = 'auto',  -- 新しいレンダリングを開始する前に経過する必要のある最小時間（ミリ秒）
})
EOF

" peek.nvim のコマンド定義 "
command! PeekOpen lua require('peek').open()
command! PeekClose lua require('peek').close()



runtime! autoload/fugitive.vim

" Color Scheme
	colorscheme onedark
" vim-airline
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'
" Tariling
	let g:better_whitespace_enabled=1
	let g:strip_whitespace_on_save=1
	let g:strip_whitespace_on_save = 1
" ALE
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_fixers = {
		\   '*': ['remove_trailing_lines', 'trim_whitespace'],
  		\   'python': ['black', 'reorder-python-imports-black'],
  		\ }
" NeoTerm
	let g:neoterm_default_mod='belowright'
	let g:neoterm_autoscroll=1

""" Setup
	set syntax
	set nobackup
	set noswapfile
	set number
	set termguicolors
	set tabstop=4
	set shiftwidth=4
	set smartindent
	set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
	set list
	set cursorline
	set nocompatible
	set hlsearch
	nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
	set ignorecase
	set showmatch
	set cmdheight=2
	set display=lastline
	set foldenable
	set foldmethod=indent
	set foldlevel=1
	set updatetime=100

""" KeyMap
	nmap <F10> :NERDTreeToggle<CR>
	nmap <F9> :TagbarToggle<CR>
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	nmap <silent> <C-j> <Plug>(ale_next_wrap)
" NeoTerm
	let g:neoterm_autoscroll=1
""" Run a Terminal
	nmap <F8> :Tnew<CR>
""" Close Fold
	nmap <F7> zc
""" Open Fold
	nmap <F6> zO
""" Next Fold
	nmap <F2> zj
""" Back Fold
	nmap <F3> zk
	nmap <C-0> ysiw"

""" leave out terminal
	tnoremap <silent> <C-w> <C-\><C-n><C-w>
""" Run REPL
"""" Ctrl+n when in NORMAL mode - Run single line
"""" Ctrl+n when in VISUAL mode - Run multiple lines
	nnoremap <silent> <C-n> :TREPLSendLine<CR>j0
	vnoremap <silent> <C-n> V:TREPLSendSelection<CR>'>j0
" Coc Nvim
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

	autocmd BufWritePre *.py :%s/\s\+$//e

"autocmd CursorHold * silent call CocActionAsync('doHover')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

