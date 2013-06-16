call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("terminfo")
  let &t_Co=16
  let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
  let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
else
  let &t_Co=16
  let &t_Sf="\<Esc>[3%dm"
  let &t_Sb="\<Esc>[4%dm"
endif

" Global
" ======
set nocompatible	" Forget compatibility with Vi. Who cares.
set autowrite		" Write the old file out when switching between files.
set hidden		  	" Switch between buffers without saving
set splitbelow		" Split windows below the current window.
set foldenable		" Enable code folding
set mousehide		" Hide mouse when typing
set autoread		" Set to auto read when a file is changed from the outside
set vb t_vb=		" Disable beeping

set clipboard=unnamed	" Share clipboard with OS

set encoding=utf-8
set fileencoding=utf-8

" Source the .vimrc file after saving it
"if has("autocmd")
"	autocmd bufwritepost .vimrc source $MYVIMRC
"endif

" Automatically change current directory to that of the file in the buffer
" Jag kommenterar ut denna för tillfället för att testa hur jag gillar det
"autocmd BufEnter * cd %:p:h

" Enable filetypes
" ----------------
filetype on
filetype plugin on
filetype indent on
syntax on

" Tab stuff
" ---------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " Space?
"set noexpandtab " Tab?

" Indent stuff
" ------------
set smartindent
set autoindent

" Better line wrapping
" --------------------
set wrap
set textwidth=79
set formatoptions=qrn1

" Layout?
" -------
set showcmd					" Show command in button right partion of the screen
set number					" Show lines numbers
" set relativenumber		" Prefer relative line numbering?
set ruler					" Display current cursor position in lower right corner.
set laststatus=2			" Always show the status line
" set linespace=3			" Prefer a slightly higher line height
set list					" Show linebrake and tab symbols
set listchars=tab:▸\ ,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs

" Search
" ------
set incsearch	" Set incremental searching
set hlsearch	" Highlight searching

" Autocompletion
" --------------
" For autocompletion
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set wildmode=list:longest
set completeopt=longest,menuone

" Put swap files in /tmp file
" ---------------------------
set backupdir=~/.tmp
set directory=~/.tmp



" Keyboard & Shortcuts
" ====================
let mapleader = ',' " Whant a different map leader than \
"set timeoutlen=500 " Ever notice a slight lag after typing the leader key + command? This lowers the timeout.

" Saves time
nmap <space> :
imap jj <esc>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Map a change directory to the desktop - Mac specific
" nmap <leader>d :cd ~/Desktop<cr>:e.<cr>
" Shortcut for editing .vimrc file in a new tab
nmap <leader>ev :tabedit $MYVIMRC<cr>
" Hard-wrap paragraphs of text
nnoremap <leader>q gqip
" Shortcut to fold tags with leader (usually \) + ft
nnoremap <leader>ft Vatzf
" Map code completion to , + tab
imap <leader><tab> <C-x><C-u>
" Delete all buffers (via Derek Wyatt)
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>
" Switch to the directory of the current file with <leader>cd
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Better zen coding mapping
imap <leader>t <C-e>

" Make word uppercase
imap <leader>u <esc>viwUea

" Javascript console.log debugging
nmap <leader>d Oconsole.log("DEBUGGING  <esc>:execute "normal! i" . ( line(".") )<cr>a");<esc>hh
vmap <leader>d yOconsole.log(<esc>pa);<esc>

" Load the current buffer in Firefox, Chrome or Safari
abbrev ff :! open -a firefox.app %:p<cr>
abbrev chr :! open -a Google\ Chrome %:p<cr>
abbrev safari :! open -a safari.app %:p<cr>

" Speed up buffer switching
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l

" Simple calculator (1+1<C-a> => 1+1=2)
ino <C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Use the arrows to switch buffer
map <right> :bn<cr>
map <left> :bp<cr>

" Scroll page up/down with gj/gk
nmap gj <C-f>
nmap gk <C-b>

" Automatically append closing characters
" http://vim.wikia.com/wiki/Automatically_append_closing_characters
inoremap {<CR>  {<CR>}<Esc>O
inoremap {<Tab> {  }<Esc>hi

" Move text with ctrl + up/down
" -----------------------------
" Bubble signle lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Buble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]



" Language specific
" =================
if has("autocmd")
	autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim,erb setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
	autocmd FileType markdown setlocal wrap linebreak nolist
	autocmd BufNewFile,BufRead *.rss setfiletype xml
	autocmd BufNewFile,BufRead Rakefile,Capfile,Gemfile,Termfile,Vagrantfile,config.ru set filetype=ruby
	autocmd BufRead,BufNewFile *.erb set filetype=erb.eruby.html " Make html.erb use html5.vim
  autocmd BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
endif

" Run current rubyfile
nmap <leader>r :w<cr>:!ruby %<cr>
abbrev irb :w<cr>:!irb -r ./%<cr>


" MacVim
" ======
if has("gui_macvim")
	" Set the color scheme. Change this to your preference.
	" Here's 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
	"colorscheme desert
  colorscheme codeschool

	" Set font type and size
	set guifont=Monaco:h12

	" Hide MacVim toolbar by default
	set go-=T

  " Make fullscreen take up entire screen
	set fuoptions=maxhorz,maxvert

  " Hide right-hand scrollbar
  set go-=r " Do I really want this??
  set go-=R " Do I really want this??

  " Hide left-hand scrollbar
  set go-=l 
  set go-=L 



" CUI
" ===
else
	" Set the color scheme. Change this to your preference.
	" Here's 100 to choose from: http://www.vim.org/scripts/script.php?script_id=625
	colorscheme desert256

	" Set font type and size
	set guifont=Monaco:h13
endif



" Plugins
" =======
" NERDTree
" --------
" Shortcut for NERDTreeToggle
"imap ,nt :NERDTreeToggle
nnoremap <F4> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"

" Show hidden files in NerdTree
" let NERDTreeShowHidden=1

" Autopen NERDTree and focus cursor in new document
" if has("gui_macvim")
"   autocmd VimEnter * NERDTree
"   autocmd VimEnter * wincmd p
" endif

" Zen Coding
" ----------
let g:user_zen_expandabbr_key = '<C-e>' " Change zen coding expand key to control + e
let g:user_zen_complete_tag = 1

" Gundo
" -----
nnoremap <F5> :NERDTreeClose<CR>:GundoToggle<CR>
let g:gundo_preview_bottom = 1

" Tagbar
" ------
nmap <F6> :TagbarToggle<CR>

" MiniBufExplorer
" ---------------
let g:miniBufExplSplitBelow=1
let g:miniBufExplorerMoreThanOne=4
let g:miniBufExplUseSingleClick=1

" Eclim
" -----
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

" SuperTab like snippets behavior. 
let g:SuperTabDefaultCompletionType = "context" 


" Abbreviations
" =============
" Helpful abbreviations
iab lorem Lorem ipsum dolor sit amet... Jag ska fylla i mer sen
iab llorem Lorem ipsum dolor sit amet... Lorem ipsum dolor sit amet... Jag ska fylla i mer sen

" Spelling corrects. Just for example. Add yours below.
iab teh the
iab Teh The
iab slef self
iab contetn content
iab reponse response
iab suer user
iab repsonse response
iab dependet dependent



" Test
" ====
" Opens a vertical split and switches over (\v)
" nnoremap <leader>v <C-W>v<C-w>l

" Set up an HTML5 template for all new .html files
" autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl

" Example for adding abbreviations - triggered by the spacebar.
"iabbrev mysite ftp://username@server/folder/

" Create dictionary for custom expansions
"set dictionary+=/Users/christian/.vim/dict/PHP.dict
