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

" C-IDE configuration
if has("win32")
    let g:cide_shell_find     = 'C:/Program Files/Git/usr/bin/find.exe'
    let g:cide_shell_date     = 'date /T'
else
    " let g:cide_shell_find     = 'C:/Program Files/Git/usr/bin/find.exe'
    " let g:cide_shell_date     = 'date /T'
endif
" let g:cide_shell_cscope   = 'cscope'
" let g:cide_shell_ag       = 'ag'
" let g:cide_grep_filespecs = ['-G "Makefile|\.(c|cpp|h|hpp|cc|mk)$"', "--cpp", "-cc", "--matlab", "--vim", "-a", '-G "\.(Po)$" --hidden', '-G "\.(d)$" --hidden']

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
" Enable vim markdown
Plugin 'godlygeek/tabular'
" Enable tag list
Plugin 'vim-scripts/taglist.vim'
" Enable markdown
Plugin 'plasticboy/vim-markdown'
" Enable mini buffer explorer
Plugin 'fholgado/minibufexpl.vim'
" Enable jellybeans color scheme
Plugin 'nanotech/jellybeans.vim'
call vundle#end()            " required
filetype plugin indent on    " required
" === Vundle setting end ===

packadd termdebug
let g:termdebugger='gdb2.bat'

" Set makeprg
set makeprg=make2

" Enable true-color
set termguicolors

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
hi CursorLine guibg=#444444 gui=none

" Turn off scrolloff
let &scrolloff = 0

if has("gui_running")
    " Enable tear off menu
    set guioptions+=t
    " set lines=55
    " set columns=153
    " winpos 27 27
    set guifont=DejaVu\ Sans\ Mono\ 11,Lucida_Console:h9
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
hi MBEVisibleActiveNormal guifg=bg guibg=LightGreen

" The following hack is to Disable cursorline for Minibufexpl window
" https://github.com/fholgado/minibufexpl.vim/issues/115
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

let g:tlist_markdown_settings = 'markdown;h:Headlins'

