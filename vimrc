" General
"--------------------------------------------------------------

" Load bundle config
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Sets how many lines of history VIM has to remember
set history=1000

" Set to auto read when a file is changed from the outside
set autoread

" Enable mouse usage and hide it when typing
"set mouse=a
"set mousehide

" Shorten message
set shortmess+=filmnrxoOtT

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :wq<cr>


" VIM user interface
"--------------------------------------------------------------

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Shows commands being typed
set showcmd

set showmode

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

set ruler                       " Always show current position
set cmdheight=2                 " Height of the command bar
set hid                         " A buffer becomes hidden when it is abandoned
set number                      " Set line numbers
set cursorline                  " Set line numbers
set backspace=eol,start,indent  " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                  " Ignore case when searching
set smartcase                   " When searching try to be smart about cases
set hlsearch                    " Highlight search results
set incsearch                   " Makes search act like search in modern browsers
set lazyredraw                  " Don't redraw while executing macros (good performance config)
set magic                       " For regular expressions turn magic on
set showmatch                   " Show matching brackets when text indicator is over them
set mat=2                       " How many tenths of a second to blink when matching brackets
set noerrorbells                " No annoying sound on rrors
set novisualbell
set t_vb=
set tm=500

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])


" Colors and Fonts
"--------------------------------------------------------------

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Let vim know that the background is dark.
set background=dark

" Set the color of highlighted lines.
"hi CursorLine ctermbg=236 guibg=236

" Set the line number color.
"hi LineNr ctermfg=236

" Set the highlight color for search matches.
"hi Search ctermbg=246 guibg=246 

" Only show highlighted line when in active pane.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Set the color of folded text.
hi Folded ctermfg=242 ctermbg=232 guifg=242 guibg=232


" Files, backups and undo
"--------------------------------------------------------------
"
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


" Text, tab and indent related
"--------------------------------------------------------------

"set expandtab        " Use spaces instead of tabs
set smarttab         " Be smart when using tabs ;)
"set shiftwidth=4     " 1 tab == 4 spaces
"set tabstop=2

" Show extra whitespace
set list listchars=trail:·,tab:➪·

set lbr              " Linebreak on 500 characters
set tw=500
set autoindent       " Auto indent
set si               " Smart indent
set wrap             " wrap lines

" Run go-fmt on Go sournce code on save.
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
" nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
" nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><leader><o> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><leader><O> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Configure editor config:
let g:EditorConfig_core_mode = 'external_command'
let g:EditorConfig_verbose=1


" Visual mode related
"--------------------------------------------------------------
"
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Shortcut for copying to clipboard.
vmap <leader>g :w !pbcopy<cr><cr>


" Moving around, tabs, windows and buffers
"--------------------------------------------------------------

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

" CtrlP fuzzy search mapping
"let g:ctrlp_map = '<Leader>f'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_show_hidden = 1

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find . -type f -not \\( -ipath '*/node_modules/*' -prune \\) -not \\( -ipath './.*/*' -prune \\) -not \\( -iname '*.log' \\) -not \\( -iname '*.DS_Store' \\)", "", ":e")<cr>

" Have NERDtree show hidden files
let NERDTreeShowHidden = 1

" CtrP ignores
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
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

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Folding
" Add a bit extra margin to the left
set foldcolumn=1 
" Auto fold code
set foldenable
set foldmethod=syntax "indent

" Default to all folds open
set foldlevelstart=20

let javaScript_fold=1    " JavaScript
let perl_fold=1          " Perl
let php_folding=1        " PHP
let r_syntax_folding=1   " R
let ruby_fold=1          " Ruby
let sh_fold_enabled=1    " sh
let vimsyn_folding='af'  " Vim script
let xml_syntax_folding=1 " XML

" Less/CSS/SCSS folding
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

" Remap Space to toggle folding on and off
nnoremap <Space> za

" Create split panes
map <leader>v :vs<cr><C-l><cr>
map <leader>h :sp<cr><C-j><cr>

" Clear the CtrlP cache
map <leader>C :CtrlPClearCache<cr>

" Shortcut for search and replace.
map <leader>l :%s/


" Status line
"--------------------------------------------------------------

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


" Editing mappings
"--------------------------------------------------------------

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

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Exit inert mode with jj
imap jj <Esc>

" Shortcut for Multiple Cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Tabularize
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" Git mappings"
"nmap <Leader>gd :Gdiff<cr>
"nmap <Leader>gb :Gblame<cr>

" Custom NERDcommenter binding
nmap <leader><space> :call NERDComment("n","toggle")<CR>
vmap <leader><space> :call NERDComment("x","toggle")<CR>


" vimgrep searching and cope displaying
"--------------------------------------------------------------

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>G :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
"map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Ultisnip
let g:UltiSnipsExpandTrigger="<tab>"

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


" Spell checking
"--------------------------------------------------------------

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>sr zw
map <leader>s? z=

" Enable spellcheck on markdown files.
autocmd BufNewFile,BufRead *.md set spell


" Misc
"--------------------------------------------------------------

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
"map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>

" Run arbitrary shell commands.
map <leader>r :!

" Configure ack.vim to use ag: the silver searcher instead
let g:ackprg = 'ag --nogroup --nocolor --column'


" Helper functions
"--------------------------------------------------------------

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

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
"command! Bclose call <SID>BufcloseCloseIt()
"function! <SID>BufcloseCloseIt()
   "let l:currentBufNum = bufnr("%")
   "let l:alternateBufNum = bufnr("#")

   "if buflisted(l:alternateBufNum)
     "buffer #
   "else
     "bnext
   "endif

   "if bufnr("%") == l:currentBufNum
     "new
   "endif

   "if buflisted(l:currentBufNum)
     "execute("bdelete! ".l:currentBufNum)
   "endif
"endfunction


" JavaScript
"--------------------------------------------------------------

" au FileType javascript call JavaScriptFold()


" Markup
"--------------------------------------------------------------

