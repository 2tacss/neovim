let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
let g:tagbar_ctags_bin = '/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'

call plug#begin()
	" HTML close tag
	Plug 'alvan/vim-closetag'
	Plug 'joshdick/onedark.vim'
	Plug 'vim-airline/vim-airline'
	" :StripWhitespace
	Plug 'ntpeters/vim-better-whitespace'
	" Visualize identation line
	Plug 'Yggdroot/indentLine'
	" :NERDTreeToggle"
	Plug 'scrooloose/nerdtree'
	" SourceTree plugin: Diff per file with NerdTree
	Plug 'xuyuanp/nerdtree-git-plugin'
	" CTag - :TagbarToggle
	Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
	" NeoTerm :Tnew
	Plug 'kassio/neoterm'
	" Multi Languages Syntax Coloring
	"Plug 'sheerun/vim-polyglot'
	" Linter
	"Plug 'dense-analysis/ale'
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
	" fugit
	Plug 'tpope/vim-fugitive'
	Plug 'tommcdo/vim-exchange'
	" Markdown Editor and Preview
	" Require following:
	" `Deno`: brew install deno
	" cd ~/.local/share/nvim/plugged/peek.nvim
	" Finally you can use vim commands `PeekOpen` and `PeekClose`.
	Plug 'toppair/peek.nvim', { 'do': 'deno task --quiet build:fast' }
	" Show indent lines with colored
	Plug 'lukas-reineke/indent-blankline.nvim'
	" Parser
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	" Folding
	"Plug 'eddiebergman/nvim-treesitter-pyfold'
call plug#end()

" peek.nvim "
command! PeekOpen lua require('peek').open()
command! PeekClose lua require('peek').close()

" fugitive.vim
runtime! autoload/fugitive.vim

let g:exchange_no_mappings=1
nmap cx <Plug>(Exchange)
vmap X <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)

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
	let g:ale_linters = {
	\   'python': [],
	\}
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_fixers = {
		\'*': ['remove_trailing_lines', 'trim_whitespace'],
		\'python': ['black', 'reorder-python-imports-black'],
	\}
" NeoTerm
"	let g:neoterm_default_mod='belowright'
"	let g:neoterm_autoscroll=1

" Setup
	set syntax
	set nowrap
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
	set updatetime=100
" Fold Setup
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()
"	set foldenable
"	set foldlevelstart=99
set foldenable
set foldmethod=indent
set foldlevel=1


let g:NERDTreeForcedFocus = 1
let g:NERDTreeMaintainCursorPos = 1

" KeyMap
function! NERDTreeFocusAction()
	" NERDTreeを切り替え
	NERDTreeToggle

	" もしツリーが開いた状態なら（ウィンドウ番号が取得できれば）
	let l:nt_winnr = bufwinnr('tNERD_tree_')
	if l:nt_winnr != -1
		" timer_startの中で直接 wincmd w を実行します。
		" 特殊記号を使わないため E15 エラーを物理的に回避できます。
		call timer_start(100, {-> execute(l:nt_winnr . 'wincmd w')})
	endif
endfunction

" F9の割り当て
nnoremap <silent> <F9> :call NERDTreeFocusAction()<CR>
	nmap <F10> :TagbarToggle<CR>
	nmap <silent> <C-k> <Plug>(ale_previous_wrap)
	nmap <silent> <C-j> <Plug>(ale_next_wrap)
" NeoTerm
	let g:neoterm_autoscroll=1
" Run a Terminal
	nmap <F8> :Tnew<CR>
" Open Fol
	nmap <F7> zO
" Close Fold
	nmap <F6> zc
" Next Fold
	nmap <F12> zj
" Back Fold
"	nmap <F3> zk
	nmap <C-0> ysiw"

" leave out terminal
" ---------------------------------------------------------
" 1. Ctrl-w 1回でペイン切り替え (通常・ターミナル両対応)
" ---------------------------------------------------------
nnoremap <C-w> <C-w>w
tnoremap <silent> <C-w> <C-\><C-n><C-w>w

" Run REPL
" Ctrl+n when in NORMAL mode - Run single line
" Ctrl+n when in VISUAL mode - Run multiple lines
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


" created at
nnoremap <F5> "=strftime(" @%Y/%m/%d")<CR>P
" final at
nnoremap <F4> "=strftime(" ^%Y/%m/%d")<CR>P
" finished at
nnoremap <F3> "=strftime(" *%Y/%m/%d")<CR>P
" remove at
nnoremap <F2> "=strftime(" &%Y/%m/%d")<CR>

" Flake8 View
nmap <F11> :CocDiagnostics<CR>P

augroup ObjCpp
  autocmd!
  autocmd FileType objcpp,mm setl omnifunc=coc#completion#complete
  autocmd FileType objcpp,mm nnoremap <silent> gd :CocDefinition<CR>
  autocmd FileType objcpp,mm nnoremap <silent> K :CocHover<CR>
  autocmd FileType objcpp,mm nnoremap <silent> gr :CocReferences<CR>
augroup END

lua << EOF

-------------------
---		Peek	---
-------------------
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

------------------------
--- indent-blankline ---
------------------------
local highlight = {
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
    "RainbowYellow",
    "RainbowRed",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }


-----------------------
--- nvim-treesitter ---
-----------------------
--require('nvim-treesitter-pyfold').setup({ enable = true })
require('nvim-treesitter.configs').setup({
  ensure_installed = { "python" },
  highlight = { enable = true },
  indent = { enable = true },
  --fold = {
  --  enable = true,
  --  foldexpr = 'nvim_treesitter#foldexpr()',
  --  },
})
EOF

" setlocal foldmethod=expr
" setlocal foldexpr=nvim_treesitter#foldexpr()


