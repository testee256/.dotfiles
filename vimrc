source $VIMRUNTIME/vimrc_example.vim

function! s:mkdir_p(folder)
    if !isdirectory(a:folder)
        echo "mkdir ".a:folder
        call mkdir(a:folder, "p", 0700)
    endif
    return a:folder 
endfunction

" Setup backup, swap, and undo directories " the "//" at the end ensures file name uniqueness
let &directory=s:mkdir_p($HOME.'/.vim/temp/swap')
let &backupdir=s:mkdir_p($HOME.'/.vim/temp/back')
let &undodir=s:mkdir_p($HOME.'/.vim/temp/undo')
set undofile

" Enable line number
set number

" Enable colorcolumn
set colorcolumn=80

" Setup tabstop and shiftwidth
set shiftwidth=4
set tabstop=4
set expandtab

" Disable vi compatible mode
set nocompatible
filetype off " required

" Setup windows-like CTRL-C and CTRL-V
if has("clipboard")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>		"+gP
    map <S-Insert>		"+gP

    cmap <C-V>		<C-R>+
    cmap <S-Insert>		<C-R>+
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

if 1
    exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
endif

set mouse=a

if &term =~ '^screen'
    " for split drag works under tmux
    set ttymouse=xterm2
endif

" Set wildmenu for auto completion
set wildmenu

" Set encoding
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1,gbk,gb18030,gk2312
if has("win32")
    set fileencoding=chinese
else
    set fileencoding=utf-8
endif

" Color scheme overriding
function! MyHighlights() abort
    hi Search term=reverse guibg=#808080 guifg=#00ffff
    hi Comment term=bold gui=NONE guifg=#80a0ff
    hi Statement term=bold gui=NONE guifg=#ffff60
    highlight Visual     cterm=NONE ctermbg=76  ctermfg=16  gui=NONE guibg=#5fd700 guifg=#000000
    highlight StatusLine cterm=NONE ctermbg=231 ctermfg=160 gui=NONE guibg=#ffffff guifg=#d70000
    hi String guifg=#00ff87
    " highlight Normal     cterm=NONE ctermbg=17              gui=NONE guibg=#00005f
    " highlight NonText    cterm=NONE ctermbg=17              gui=NONE guibg=#00005f
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

" C-IDE configuration
if has("win32")
    let g:cide_shell_find     = 'C:/Program Files/Git/usr/bin/find.exe'
    let g:cide_shell_sort     = 'C:/Program Files/Git/usr/bin/sort.exe'
    let g:cide_shell_date     = 'date /T'
else
    " let g:cide_shell_find   = 'find'
    " let g:cide_shell_sort   = 'sort'
    " let g:cide_shell_date   = 'date +\"%a %D %T.%3N\"'
endif
" let g:cide_shell_cscope   = 'cscope'
" let g:cide_shell_grep       = 'rg'
" if g:cide_shell_grep == 'rg'
"     let g:cide_grep_filespecs = ["-tcxx", "-tcpp", "-tc", "-tvim", "-tmatlab", '-g "*"']
" else
"     let g:cide_grep_filespecs = ['-G "Makefile|\.(c|cpp|h|hpp|cc|mk)$"', "--cpp", "-cc", "--matlab", "--vim", "-a", '-G "\.(Po)$"', '-G "\.(d)$"']
" endif

" Mini Buffer Explorer <minibufexpl.vim>
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplUseSingleClick = 1
let g:did_minibufexplorer_syntax_inits = 1  " prevent override of color settings
let g:miniBufExplMoreThanOne = 0 " Stop the -MiniBufExplorer- from opening automatically until more than one eligible buffer is available
let g:winManagerWindowLayout = "FileExplorer,TagsExplorer"

"Tag list
nnoremap <silent> <F8> :Tlist<CR>
nnoremap <silent> <F9> :TlistSync<CR>
set updatetime=1000

" === Vundle setting start ===
let $vundle_dir = $HOME.'/.vim/bundle/Vundle.vim'
if !isdirectory($vundle_dir)
    echo 'Installing vundle to '.$vundle_dir . '...'
    call system('git clone https://github.com/VundleVim/Vundle.vim.git '.$vundle_dir)
endif

" set the runtime path to include Vundle and initialize
set rtp+=$vundle_dir/
" if has("win32")
"     call vundle#begin('$HOME/.vim/bundle/')
" else
call vundle#begin()
" endif
Plugin 'VundleVim/Vundle.vim'
" Enable C-IDE
Plugin 'tristar2001/vim-cide'
" Enable airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Enable vim markdown
Plugin 'godlygeek/tabular'
" Enable tag list
Plugin 'vim-scripts/taglist.vim'
" Enable markdown
Plugin 'plasticboy/vim-markdown'
" Enable mini buffer explorer (forked from 'fholgado/minibufexpl.vim')
" Plugin 'tristar2001/minibufexpl.vim'
" Enable jellybeans color scheme
Plugin 'nanotech/jellybeans.vim'
" Enable indentLine
Plugin 'Yggdroot/indentLine'
" Enable vim configuration for rust
Plugin 'rust-lang/rust.vim'
" Enable go plugin for vim
if v:version > 800
Plugin 'fatih/vim-go'
endif
" buffer bye
Plugin 'moll/vim-bbye'
call vundle#end()            " required
filetype plugin indent on    " required
" === Vundle setting end ===

if v:version > 800
    packadd termdebug
    let g:termdebugger='gdb2.bat'
endif

" Set makeprg
set makeprg=make2

" Enable true-color
" set termguicolors

" Set colorschme
try 
  colorscheme jellybeans
  catch
  try 
    colorscheme torte
    catch
  endtry
endtry

" Set cursor line
set cursorline
hi clear CursorLine
" hi CursorLine guibg=#444444 gui=none ctermbg=darkgray cterm=none
hi CursorLine gui=underline cterm=underline term=underline

" Turn off scrolloff
let &scrolloff = 0

if has("gui_running")
    " Enable tear off menu
    set guioptions+=t
    " set lines=55
    " set columns=153
    " winpos 27 27
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10,Source\ Code\ Pro\ for\ Powerline\ 10,Lucida\ Console\ 9,DejaVu\ Sans\ Mono\ 11
    elseif has("gui_macvim")
        set guifont=Droid\ Sans\ Mono\ for\ Powerline:h10,Source\ Code\ Pro\ for\ Powerline:h10,Lucida\ Console:h9,DejaVu\ Sans\ Mono:h11
    elseif has("gui_win32")
        set guifont=Droid\ Sans\ Mono\ for\ Powerline:h10,Source\ Code\ Pro\ for\ Powerline:h10,Lucida\ Console:h9,DejaVu\ Sans\ Mono:h11
    endif
    highlight LineNr guifg=#808080
else
    highlight LineNr ctermfg=grey
    " cannot change font
endif

" Set MBE colors (show all available groups with :hi)
" This is must be done after all plugins are loaded
hi link MBEVisibleActive Title
hi link MBEVisibleChanged DiffText
hi link MBEChanged DiffChange
hi link MBEVisibleActiveChanged Error

hi MBEVisibleActiveNormal   guifg=black guibg=LightGreen ctermfg=black ctermbg=LightGreen
hi wildmenu                 ctermfg=yellow ctermbg=blue guifg=yellow guibg=blue
hi search                   ctermfg=yellow ctermbg=blue guifg=yellow guibg=blue

" The following hack is to Disable cursorline for Minibufexpl window
" https://github.com/fholgado/minibufexpl.vim/issues/115
function! s:MyWinEnter()
    if !exists('w:mark_CursorLineDisable')
        setlocal cursorline
        " setlocal number
    end
endfunction

function! s:MyWinLeave()
    if !exists('w:mark_CursorLineDisable')
        setlocal nocursorline
        " setlocal nonumber
    end
endfunction

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * call s:MyWinEnter()
  au WinLeave * call s:MyWinLeave()
augroup END

let g:tlist_markdown_settings = 'markdown;h:Headlins'

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" let s = synID(line('.'), col('.'), 1) | echo synIDattr(s, 'name') . ' -> ' . synIDattr(synIDtrans(s), 'name')
" echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" vim-markdown settings
function! VimMarkdownToggleConceal()
    let g:vim_markdown_conceal = 1 - g:vim_markdown_conceal
    exe "e"
endfunction
" Do not automatically insert bulletpoints
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
" Enable markdown math
" let g:vim_markdown_math=1
" Disable vim markdown conceal
let g:vim_markdown_conceal = 0
" Disable vim markdown conceal code blocks
let g:vim_markdown_conceal_code_blocks = 0
nnoremap <silent> <F11> :call VimMarkdownToggleConceal()<CR>

" ---- mswin stuff
" Set behavior for mouse and selection.
behave mswin
" Do not include end-of-line in yank/copy
nmap $ g_

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" https://medium.com/@slmeng/how-to-install-powerline-fonts-in-windows-b2eedecace58
let g:airline_powerline_fonts = 1
let g:airline_theme = "badwolf"

" indentLine configuration
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '.'
set listchars=tab:\|\ 
set list

set splitbelow
set splitright

