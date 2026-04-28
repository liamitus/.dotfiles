" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" "zo" to open folds, "zc" to close, "zn" to disable.

" Plugins {{{

call plug#begin('~/.vim/plugged')

" Status bar & UI
Plug 'vim-airline/vim-airline'

" Tim Pope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish'

" Navigation & search
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Editing
Plug 'preservim/nerdcommenter'
Plug 'FooSoft/vim-argwrap'

" Git
Plug 'airblade/vim-gitgutter'

" Linting & completion
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Languages
Plug 'elzr/vim-json'
Plug 'ap/vim-css-color'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

" Colors
Plug 'jnurmine/Zenburn'

call plug#end()

syntax on
filetype plugin indent on

" }}}

" Basic Settings {{{

set shell=zsh
set termguicolors

let g:zenburn_transparent=1
colorscheme zenburn
hi Normal guibg=NONE ctermbg=NONE

" Splits, buffers, undo
set splitright
set hidden
set history=500
if exists('&undofile') | set undofile | endif

" Spelling
set dictionary+=/usr/share/dict/words thesaurus+=$HOME/.thesaurus

" Editing
set backspace=indent,eol,start
set expandtab tabstop=2 shiftwidth=2 softtabstop=2
set foldlevelstart=2

" 80-col indicator
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Word splitting
set iskeyword+=-

" Netrw (:Ex, :Vex, :Sex, :Tex)
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
set wildignore+=.*\.swp$,.*\.un\~$,.*\.swo$

" Use pyenv's python3 for nvim if available, otherwise fall back to system
if filereadable(expand('$HOME/.pyenv/shims/python3'))
  let g:python3_host_prog = expand('$HOME/.pyenv/shims/python3')
endif

" }}}

" Plugin Settings {{{

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" ALE
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_fixers = { 'javascript': ['eslint'] }

" fzf
set rtp+=/opt/homebrew/opt/fzf
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" CtrlP
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" }}}

" Backups {{{

set directory=$HOME/.backups/swaps,$HOME/.backups,$HOME/tmp,.
set backupdir=$HOME/.backups/backups,$HOME/.backups,$HOME/tmp,.
if exists('&undodir')
  set undodir=$HOME/.backups/undofiles,$HOME/.backups,$HOME/tmp,.
endif

" }}}

" Autocommands {{{

au BufWritePost init.vim source %
au BufWritePost .vimrc source %
au FileType html,htmldjango,css,sass,javascript,coffee,python,ruby,eruby setl foldmethod=indent foldenable
au FileType python let b:python_highlight_all=1

" }}}

" Key Mappings {{{

let mapleader = "\<Space>"

" Edit this vimrc
nnoremap <leader>, :tabedit $MYVIMRC<CR>

" Toggles
nnoremap <leader>l :setlocal number!<CR>
nnoremap <leader>L :setlocal rnu!<CR>
nnoremap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap <leader>p :set paste!<CR>

" File ops
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>y gg"+yG

" Git
nnoremap <leader>b :Git blame<CR>

" Search
nnoremap <leader>/ :Ag<CR>

" Argument wrapping
nnoremap <leader>a :ArgWrap<CR>

" File browser
nnoremap <leader>e :Ex<CR>
nnoremap <leader>x :Sex<CR>
nnoremap <leader>t :Tex<CR>
nnoremap <leader>v :Vex<CR>

" Wrapped-line motion
nnoremap j gj
nnoremap k gk

" Bash-style cmdline editing
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Clear search highlighting
nnoremap \q :nohlsearch<CR>

" Buffer navigation
nnoremap <C-e> :e#<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap ; :CtrlPBuffer<CR>
nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>

" Move line up/down
noremap <silent> <C-k> :call <SID>swap_up()<CR>
noremap <silent> <C-j> :call <SID>swap_down()<CR>

" Strip trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Substitute current search
nmap <expr> m  ':%s/' . @/ . '//g<LEFT><LEFT>'

" React Native shortcut
nmap S a style={styles.}<LEFT>

" Python: drop a breakpoint
nnoremap <Leader>d Obreakpoint() # <------- VERY OBVIOUSLY A BREAKPOINT<C-c>
nnoremap <Leader>D Ofrom pprint import pprint; breakpoint() # <------- VERY OBVIOUSLY A BREAKPOINT<C-c>

" ALE navigation/fix
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)
nmap <F6> <Plug>(ale_fix)

" Semshi (Python)
nmap <silent> <leader>rr :Semshi rename<CR>
nmap <silent> <Tab>     :Semshi goto name next<CR>
nmap <silent> <S-Tab>   :Semshi goto name prev<CR>
nmap <silent> <leader>c :Semshi goto class next<CR>
nmap <silent> <leader>C :Semshi goto class prev<CR>
nmap <silent> <leader>f :Semshi goto function next<CR>
nmap <silent> <leader>F :Semshi goto function prev<CR>
nmap <silent> <leader>ee :Semshi error<CR>
nmap <silent> <leader>ge :Semshi goto error<CR>

" }}}

" Custom Functions {{{

function! s:swap_lines(n1, n2)
  let line1 = getline(a:n1)
  let line2 = getline(a:n2)
  call setline(a:n1, line2)
  call setline(a:n2, line1)
endfunction

function! s:swap_up()
  let n = line('.')
  if n == 1 | return | endif
  call s:swap_lines(n, n - 1)
  exec n - 1
endfunction

function! s:swap_down()
  let n = line('.')
  if n == line('$') | return | endif
  call s:swap_lines(n, n + 1)
  exec n + 1
endfunction

" }}}

set tags=tags
