set nocompatible " Must be the first line
filetype off

" Setup Bundle support
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Add an UnBundle command {
function! UnBundle(arg, ...)
  let bundle = vundle#config#init_bundle(a:arg, a:000)
  call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
endfunction

com! -nargs=+         UnBundle
\ call UnBundle(<args>)

" General
Plugin 'gmarik/vundle'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jeetsukumaran/vim-buffergator'

" Collaboration
Plugin 'floobits/floobits-neovim'

" General programming
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mattn/emmet-vim'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'marijnh/tern_for_vim'
Plugin 'cohama/lexima.vim'
"Plugin 'honza/vim-snippets'

" Manipulation
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'

" Movement
Plugin 'Lokaltog/vim-easymotion'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-scripts/restore_view.vim'

" Visual / Interface
Plugin 'mhinz/vim-signify'
Plugin 'godlygeek/csapprox'
Plugin 'bling/vim-bufferline'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-unimpaired'
 
" Version Control
Plugin 'mattn/gist-vim'

" Markdown
Plugin 'plasticboy/vim-markdown'

" Markup
Plugin 'amirh/HTML-AutoCloseTag'
Plugin 'slim-template/vim-slim.git'
Plugin 'tpope/vim-haml'
Plugin 'othree/html5.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'mustache/vim-mustache-handlebars'

" Stylesheets
Plugin 'groenewege/vim-less'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'

" JavaScript
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
"Plugin 'Shutnik/jshint2.vim'
"Plugin "wookiehangover/jshint.vim"
Plugin 'briancollins/vim-jst'
Plugin 'mxw/vim-jsx'

" Go lang
Plugin 'fatih/vim-go'

" OpenSCAD
Plugin 'vim-scripts/openscad.vim'


" Settings
"--------------------------------------------------------------

syntax on
filetype plugin indent on

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set background=dark                     " Let vim know that the background is dark.
colorscheme hybrid                      " Set color scheme (needs to be after background setting)
set history=1000                        " Sets how many lines of history VIM has to remember
set autoread                            " Set to auto read when a file is changed from the outside
set mouse=a                             " Enable mouse usage and hide it when typing
set mousehide
set shortmess+=filmnrxoOtT              " Shorten message
set list listchars=trail:·,tab:➪·       " Show extra whitespace
set smarttab                            " Be smart when using tabs ;)
set lbr                                 " Linebreak on 500 characters
set tw=500
set autoindent                          " Auto indent
set si                                  " Smart indent
set wrap                                " wrap lines
set so=7                                " Set 7 lines to the cursor - when moving vertically using j/k
set wildmenu                            " Turn on the WiLd menu
set showcmd                             " Shows commands being typed
set showmode
set ruler                               " Always show current position
set cmdheight=2                         " Height of the command bar
set hid                                 " A buffer becomes hidden when it is abandoned
set number                              " Set line numbers
set cursorline                          " Set line numbers
set backspace=eol,start,indent          " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                          " Ignore case when searching
set smartcase                           " When searching try to be smart about cases
set hlsearch                            " Highlight search results
set incsearch                           " Makes search act like search in modern browsers
set lazyredraw                          " Don't redraw while executing macros (good performance config)
set magic                               " For regular expressions turn magic on
set showmatch                           " Show matching brackets when text indicator is over them
set mat=2                               " How many tenths of a second to blink when matching brackets
set noerrorbells                        " No annoying sound on rrors
set novisualbell                        " No visual bell
set t_vb=
set tm=500
set encoding=utf8                       " Set utf8 as standard encoding and en_US as the standard language
set statusline+=%#warningmsg#           " syntastic settings
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set ffs=unix,dos,mac                    " Use Unix as the standard file type
set laststatus=2                        " Always show the status line
set viminfo^=%                          " Remember info about open buffers on close
set foldcolumn=0                        " No folding column
set foldenable                          " Auto fold code
set foldmethod=syntax
set foldlevelstart=20                   " Default to all folds open
set wildignore+=*/dist/*,*/tmp/*,*.zip  " CtrlP custom ignores

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l " Format the status line

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

function! MyFoldText()
    "let nl = v:foldend - v:foldstart + 1
    "let comment = substitute(getline(v:foldstart),"^ *","",1)
    let linetext = substitute(getline(v:foldstart),"^ *","",1)
    let txt = '+ ' . linetext
    return txt
endfunction
set foldtext=MyFoldText()


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Configure editor config:
let g:EditorConfig_core_mode = 'external_command'
let g:EditorConfig_verbose=1

" CtrlP open shortcut
let g:ctrlp_map = '<leader>f'

" Have NERDtree show hidden files
let NERDTreeShowHidden = 1

" Configure ack.vim to use ag: the silver searcher instead
let g:ackprg = 'ag --nogroup --nocolor --column'

" CtrP ignores
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Shortcut for Multiple Cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_seed_identifiers_with_syntax = 1 " Load keywords from given language

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<tab>' " '<enter>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"let g:UltiSnipsAddFiletypes jsx.js
"let g:UltiSnipsAddFiletypes jsx.html

let g:syntastic_auto_loc_list = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_mode_map={ 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['html'] }

" Configure vim-mustache-handlebars
let g:mustache_abbreviations = 1

" Folding settings
let javaScript_fold=1    " JavaScript
let perl_fold=1          " Perl
let php_folding=1        " PHP
let r_syntax_folding=1   " R
let ruby_fold=1          " Ruby
let sh_fold_enabled=1    " sh
let vimsyn_folding='af'  " Vim script
let xml_syntax_folding=1 " XML

" Emmet shortcut
let g:user_emmet_leader_key='<C-z>'

" Only show highlighted line when in active pane.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Set the color of folded text.
hi Folded ctermfg=242 ctermbg=232 guifg=242 guibg=232

" Syntastic error highlighting colors
hi SpellBad ctermfg=015 ctermbg=160 guifg=#ffffff guibg=#d70000
hi SpellCap ctermfg=015 ctermbg=160 guifg=#ffffff guibg=#d70000
highlight link SyntasticError SpellBad
highlight link SyntasticWarning SpellCap


"--------------------------------------------------------------
" Remaps
"--------------------------------------------------------------

" Fast saving
nmap <leader>w :w!<cr>

" Fast quitting
nmap <leader>q :wq<cr>

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
" nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
" nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><leader><o> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><leader><O> :set paste<CR>m`O<Esc>``:set nopaste<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" When you press <leader>r you can search and replace the selected text
"vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Shortcut for copying to clipboard.
vmap <leader>g :w !pbcopy<cr><cr>
vmap <leader>y "*y

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows/panes
map <C-j> <C-W>j
map <C-k> <C-W>k
nmap <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Run arbitrary shell commands.
map <leader>r :!

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sr zw
map <leader>s? z=

" Remap Space to toggle folding on and off
nnoremap <space> za

" Fold everything but current fold
map <leader>m zMzvzazO

" Create split panes
map <leader>v :vs<cr><C-l><cr>
map <leader>h :sp<cr><C-j><cr>

" Clear the CtrlP cache
map <leader>C :CtrlPClearCache<cr>

" Shortcut for search and replace.
map <leader>l :%s/

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Exit terminal mode into normal mode
tnoremap <leader>n <C-\><C-n>

" Exit inert mode with jj
imap jj <Esc>

" Custom NERDcommenter binding
nmap <leader><space> :call NERDComment("n","toggle")<CR>
vmap <leader><space> :call NERDComment("x","toggle")<CR>

"set omnifunc=syntaxcomplete#Complete

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
"map <leader>cc :botright cope<cr>
"map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
"map <leader>n :cn<cr>
"map <leader>p :cp<cr>



"--------------------------------------------------------------
" File Type Handling
"--------------------------------------------------------------

autocmd BufRead,BufNewFile *.es6 setfiletype javascript
" au FileType javascript call JavaScriptFold()
autocmd BufNewFile,BufRead *.html set foldmethod=indent
au BufRead,BufNewFile *.hbs set filetype=mustache
autocmd BufNewFile,BufRead *.md set spell

" Less/CSS/SCSS folding
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

" Run go-fmt on Go sournce code on save.
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

" With JavaScript, if .eslintrc is available, use that, otherwise default to standard.
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
