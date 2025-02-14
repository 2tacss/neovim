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
	" Multi Languages Syntax Coloring
	Plug 'sheerun/vim-polyglot'
	" Linter
	Plug 'dense-analysis/ale'
	"
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Coc Intelphense
	Plug 'yaegassy/coc-intelephense'
	" Comment-out - `gc` makes single line, `gcc` make multiple lines in VISUAL mode
	Plug 'tpope/vim-commentary'
	" S" cs"' ds'
	Plug 'tpope/vim-surround'
	" auto brackets
	Plug 'jiangmiao/auto-pairs'
call plug#end()

" Color Scheme
	colorscheme onedark
" vim-airline
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'

" ALE Linter
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
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


""" KeyMap
nmap <F10> :NERDTreeToggle<CR>
nmap <F9> :TagbarToggle<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" NeoTerm
let g:neoterm_autoscroll=1
""" Run a Terminal
nmap <F8> :Tnew<CR>
""" Close
nmap <F7> :close<CR>
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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

