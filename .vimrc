set nocompatible " Must be the first line
set nospell
filetype off

" Setup Bundle support
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

"set autoread

" Add an UnBundle command {
"function! UnBundle(arg, ...)
  "let bundle = vundle#config#init_bundle(a:arg, a:000)
  "call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
"endfunction

"com! -nargs=+         UnBundle
"\ call UnBundle(<args>)

call plug#begin()

" General
"Plug 'gmarik/vundle'
"Plug 'MarcWeber/vim-addon-mw-utils'     " Interpret a file by function and cache file automatically
"Plug 'tomtom/tlib_vim'
Plug 'terryma/vim-multiple-cursors'
"Plug 'jeetsukumaran/vim-buffergator'
Plug 'airblade/vim-rooter'                " Change current working directory automatically

" Theming
Plug 'vim-scripts/SyntaxAttr.vim'         " Display syntax highlighting attributes under cursor

" Collaboration
"Plug 'floobits/floobits-neovim'

" General programming
"Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'

" Snippets
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"Plug 'marijnh/tern_for_vim'
Plug 'cohama/lexima.vim'        " auto-close parens
"Plug 'honza/vim-snippets'

" Code auto completition
"Plug 'ervandew/supertab'
"Plug 'Valloric/YouCompleteMe'
Plug 'roxma/nvim-completion-manager' " async code completion
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}

" Manipulation
"Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-abolish'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim'

" Movement
"Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/restore_view.vim'

" Visual / Interface
Plug 'mhinz/vim-signify'
Plug 'godlygeek/csapprox'     " make gvim-only oclorschemes workin in terminal vim
Plug 'bling/vim-bufferline'   " show list of buffers in status line
"Plug 'flazz/vim-colorschemes' " vim colorschemes
Plug 'tpope/vim-unimpaired'   " handy bracket mappings

" Version Control
"Plug 'mattn/gist-vim'

" Markdown
"Plug 'plasticboy/vim-markdown'
"Plug 'tpope/vim-markdown'
"Plug 'jtratner/vim-flavored-markdown'
Plug 'rhysd/vim-gfm-syntax'

" Markup
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'slim-template/vim-slim'
Plug 'digitaltoad/vim-jade'
Plug 'digitaltoad/vim-pug'
Plug 'tpope/vim-haml'
Plug 'othree/html5.vim'
Plug 'mustache/vim-mustache-handlebars'

" Stylesheets
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" JavaScript
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
"Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
"Plug 'Shutnik/jshint2.vim'
"Plug 'wookiehangover/jshint.vim'
Plug 'briancollins/vim-jst'
Plug 'posva/vim-vue'
Plug 'sbdchd/neoformat'
"Plug 'flowtype/vim-flow'
Plug 'nikvdp/ejs-syntax'

" Other syntax highlighting/language support
Plug 'fatih/vim-go'
Plug 'vim-scripts/openscad.vim'
Plug 'gregjurman/vim-nc'
Plug 'elixir-lang/vim-elixir'

call plug#end()

" Settings
"--------------------------------------------------------------

"filetype plugin indent on
"syntax on

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Color scheme
set background=dark                     " Let vim know that the background is dark.
colorscheme dana                        " Set color scheme (needs to be after background setting)

set ttyfast
set lazyredraw
set history=1000                        " Sets how many lines of history VIM has to remember
set autoread                            " Set to auto read when a file is changed from the outside
set mouse=a                             " Enable mouse usage and hide it when typing
set mousehide
"set autochdir                           " Automatically change CWD
set shortmess+=filmnrxoOtT              " Shorten message
set list listchars=trail:·,tab:··       " Show extra whitespace
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
set noerrorbells                        " No annoying sound on errors
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
set expandtab
set shiftwidth=2
set softtabstop=2

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
let g:EditorConfig_verbose=0

" CtrlP open shortcut
let g:ctrlp_map = '<leader>f'

" Have NERDtree show hidden files
let NERDTreeShowHidden = 1

" vim-jsx configuration
let g:jsx_ext_required = 0

" vim-javascript configuration
let g:javascript_plugin_flow = 1

" Facebook Flow type checking
let g:flow#enable = 0

" Configure ack.vim to use ag: the silver searcher instead
let g:ackprg = 'ag --nogroup --nocolor --column'

" CtrP ignores
let g:ctrlp_custom_ignore = '\v[\/](build|coverage|dist|tmp|log|node_modules)$|(\.(DS_Store|git))$'
let g:ctrlp_working_path_mode = 0

" nvim-completition-manager
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" UltiSnips configuration
let g:UltiSnipsExpandTrigger        = "<tab>"
let g:UltiSnipsJumpForwardTrigger   = "<tab>"
let g:UltiSnipsJumpBackwardTrigger  = "<Plug>(ultisnips_backward)"
let g:UltiSnipsListSnippets         = "<Plug>(ultisnips_list)"
let g:UltiSnipsRemoveSelectModeMappings = 0

" This is optional if you're using NCM
inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
inoremap <c-n> <c-r>=UltiSnips#ExpandSnippet()<cr>

" Shortcut for Multiple Cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

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
"let xml_syntax_folding=1 " XML

" Emmet configuration
let g:user_emmet_leader_key='<C-z>'
let g:user_emmet_settings = {'html':{'quote_char':"'",},}

" Only show highlighted line when in active pane.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Set the color of folded text.
hi Folded ctermfg=242 ctermbg=232 guifg=242 guibg=232

" Spelling colors
hi SpellBad ctermfg=015 ctermbg=160 guifg=#ffffff guibg=#d70000
hi SpellCap ctermfg=015 ctermbg=160 guifg=#ffffff guibg=#d70000

" Syntastic error highlighting colors
"highlight link SyntasticError SpellBad
"highlight link SyntasticWarning SpellCap


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
"map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Shortcut for copying to clipboard.
vmap <leader>g :w !pbcopy<cr><cr>
vmap <leader>y "*y

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

nnoremap <silent><leader><o> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><leader><O> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Paste from clipboard
map <leader>p "*P"<cr>

" Run arbitrary shell commands.
map <leader>r :!

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Navigate around to mispelled words
map <leader>sn ]s
map <leader>sp [s
" Add to dictionary
map <leader>sa zg
map <leader>sr zw
" Show spelling options
map <leader>s? z=

" Remap Space to toggle folding on and off
nnoremap <space> za

" Fold everything but current fold
map <leader>m zMzvzazO
map <leader>M zR

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

" Display the current syntax highlighting name is under the cursor (for theming)
map <leader>hi :call SyntaxAttr()<CR>

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

" Automatically change CWD
"autocmd BufEnter * silent! lcd %:p:h
" au FileType javascript call JavaScriptFold()
autocmd BufNewFile,BufRead *.html set foldmethod=indent
autocmd BufRead,BufNewFile *.hbs set filetype=mustache
autocmd BufRead,BufNewFile *.es6 set filetype=javascript
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *.md set spell
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
autocmd BufNewFile,BufRead *.nc,*.ngc setlocal nospell ft=ngc syntax=ngc

" Run go-fmt on Go sournce code on save.
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Use prettier-standard
"autocmd FileType javascript set formatprg=prettier-standard

" Use prettier with custom config
"autocmd FileType javascript set formatprg="prettier --stdin" "prettier-with-opts
"autocmd BufWritePre *.js Neoformat
"autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat
"let g:neoformat_try_formatprg = 1
"let g:neoformat_only_msg_on_error = 1
"let g:neoformat_verbose = 1

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
"func! DeleteTrailingWS()
  "exe "normal mz"
  "%s/\s\+$//ge
  "exe "normal `z"
"endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Use github flavored markdown by default
"augroup markdown
    "au!
    "au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
"augroup END

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Turn off syntax highlighting on large files
autocmd BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif
