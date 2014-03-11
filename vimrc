set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-rails.git'
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'nono/vim-handlebars'
Bundle 'ervandew/supertab'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'tComment'
Bundle 'Syntastic'

filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack/Ag
"
" Adds :Ack/:Ag complete w/ quick fix. I prefer to use :Ag! which does not
" open
" the first thing it finds automatically.
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'

map <leader>a :Ag!<space>
map <leader>A :Ag! <C-R><C-W><CR>

" Use ag for search, it's much faster than ack.
" See https://github.com/ggreer/the_silver_searcher
" on mac: brew install the_silver_searcher
let g:agprg = 'ag --nogroup --nocolor --column --smart-case'

" Backups and swap
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set expandtab
set list listchars=tab:▸\ ,trail:·,eol:¬
set number
set guioptions-=T

" Clear whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" hamlc is haml
au BufRead,BufNewFile *.hamlc set ft=haml

" Clear search query
nnoremap <silent><esc> :noh<return><esc>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=longest,list
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/javascripts/compiled,*.css,tmp,*.orig,*.jpg,*.png,*.gif,log,solr,.sass-cache,.jhw-cache,bundler_stubs,build,error_pages


syntax enable
set background=dark
colorscheme grb256

" Powerline settings
let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'short'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping for window navigation
"
" If you're in tmux it'll keep going to tmux splits if you hit the end of
" your vim splits.
"
" For the tmux side see:
" https://github.com/aaronjensen/dotfiles/blob/e9c3551b40c43264ac2cd21d577f948192a46aea/tmux.conf#L96-L102
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" don't delay when you hit esc in terminal vim, this may make arrow keys not
" work well when ssh'd in
set ttimeoutlen=5
