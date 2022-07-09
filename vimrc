" == From defaults.vim (start) ==
" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
" set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" == From vimrc_example.vim (start) ==
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" == From vimrc_example.vim (end) ==

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif
function! s:mkdir_p(folder)
    if !isdirectory(a:folder)
        echo "mkdir ".a:folder
        call mkdir(a:folder, "p", 0700)
    endif
    return a:folder 
endfunction

function! MaximizeWin(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfunction

" Setup backup, swap, and undo directories " the "//" at the end ensures file name uniqueness
let &directory=s:mkdir_p($HOME.'/.vim/temp/swap')
let &backupdir=s:mkdir_p($HOME.'/.vim/temp/back')
if has('nvim')
let &undodir=s:mkdir_p($HOME.'/.vim/temp/undo-nvim')
else
let &undodir=s:mkdir_p($HOME.'/.vim/temp/undo')
endif
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
    highlight Search ctermfg=black ctermbg=blue guifg=yellow guibg=blue
    highlight Comment term=bold gui=NONE guifg=#80a0ff
    highlight Statement term=bold gui=NONE guifg=#ffff60
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
    " let g:cide_shell_find     = 'C:/Program Files/Git/usr/bin/find.exe'
    " let g:cide_shell_sort     = 'C:/Program Files/Git/usr/bin/sort.exe'
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
Plugin 'tristar2001/indentLine'
" Enable vim configuration for rust
Plugin 'rust-lang/rust.vim'
" Enable go plugin for vim
if v:version > 800
Plugin 'fatih/vim-go'
endif
" buffer bye
Plugin 'moll/vim-bbye'
" vim session manager
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
" Pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'
" diff two directories 
Plugin 'will133/vim-dirdiff'
" markdown toc generator
Plugin 'mzlogin/vim-markdown-toc'
" A Git wrapper so awesome
Plugin 'tpope/vim-fugitive'
" Gitlab extension for fugitive.vim's :Gbrowse command 
Plugin 'shumphrey/fugitive-gitlab.vim'
" GitHub extension for fugitive.vim's :Gbrowse command 
Plugin 'tpope/vim-rhubarb'
" Bitbucket extension for fugitive.vim's :Gbrowse command 
Plugin 'tommcdo/vim-fubitive'
" capnp syntax highlighting
Plugin 'cstrahan/vim-capnp'

Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'puremourning/vimspector'
Plugin 'szw/vim-maximizer'
" Plugin 'neoclide/coc.nvim'
Plugin 'RishabhRD/popfix'
Plugin 'RishabhRD/nvim-lsputils'
Plugin 'dcharbon/vim-flatbuffers'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }

if has('nvim')
Plugin 'kyazdani42/nvim-web-devicons'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'sindrets/diffview.nvim'
else
Plugin 'ryanoasis/vim-devicons'
endif

Plugin 'AndrewRadev/linediff.vim'

call vundle#end()            " required

filetype plugin indent on    " required
" === Vundle setting end ===

if (has('nvim') && v:version >= 800) || (v:version > 800)
    " nvim(>=800) or vim(>800)
    packadd termdebug
    let g:termdebugger='my_termdebugger'
endif

" Set makeprg
set makeprg=make

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
highlight link MBEVisibleActive Title
highlight link MBEVisibleChanged DiffText
highlight link MBEChanged DiffChange
highlight link MBEVisibleActiveChanged Error

highlight MBEVisibleActiveNormal   guifg=black guibg=LightGreen ctermfg=black ctermbg=LightGreen
highlight wildmenu                 ctermfg=yellow ctermbg=blue guifg=yellow guibg=blue

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
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#formatter = 'default'

" https://medium.com/@slmeng/how-to-install-powerline-fonts-in-windows-b2eedecace58
let g:airline_powerline_fonts = 1
" let g:airline_theme = "badwolf"
" let g:airline_theme = "deus"
" let g:airline_theme = "base16"
let g:airline_theme = "jellybeans"

" indentLine configuration
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '.'
set listchars=tab:\|\ 
set list

set splitbelow
set splitright

map <Leader>B  :execute 'bufdo Bdelete'\|e#<CR>

function! QuoteN(t)
    let p0 = getpos(".")
    call append(p0[1], '```')
    call append(p0[1], '')
    call append(p0[1], '```'.a:t)
    call cursor(p0[1] + 2, 1)
endfunction

function! QuoteV(t)
    let [l1, c1] = getpos("'<")[1:2]
    let [l2, c2] = getpos("'>")[1:2]
    if (c2 == 1)
        let l2 = l2 - 1
    endif
    call append(l2, '```')
    call append(l1 - 1, '```'.a:t)
endfunction

nnoremap <Leader>qr  :<c-u>call QuoteN('rust')<CR>
nnoremap <Leader>qc  :<c-u>call QuoteN('rc')<CR>
vnoremap <Leader>qr  :<c-u>call QuoteV('rust')<CR>
vnoremap <Leader>qc  :<c-u>call QuoteV('c')<CR>

au BufRead,BufNewFile *.csr set filetype=csrspec
au BufRead,BufNewFile *.lds set filetype=ld

" === vimspector
" packadd! vimspector # not needed if Plugin 'puremourning/vimspector' is present
let g:vimspector_enable_mappings = 'HUMAN'

" disable modifyOtherKeys
let &t_TI = ""
let &t_TE = ""

" Default vimspector keys of HUMAN mode
" F3            <Plug>VimspectorStop                        Stop debugging.
" F4            <Plug>VimspectorRestart                     Restart debugging with the same configuration.
" F5            <Plug>VimspectorContinue                    When debugging, continue. Otherwise start debugging.
" F6            <Plug>VimspectorPause                       Pause debuggee.
" F8            <Plug>VimspectorAddFunctionBreakpoint       Add a function breakpoint for the expression under cursor
" <leader>F8    <Plug>VimspectorRunToCursor                 Run to Cursor
" <F9           <Plug>VimspectorToggleBreakpoint            Toggle line breakpoint on the current line.
" <leader>F9    <Plug>VimspectorToggleConditionalBreakpoint Toggle conditional line breakpoint or logpoint on the current line.
" F10           <Plug>VimspectorStepOver                    Step Over
" F11           <Plug>VimspectorStepInto                    Step Into
" F12           <Plug>VimspectorStepOut                     Step out of current function scope

"additional key maps in case original ones were taken
nnoremap <C-F9>   <Plug>VimspectorToggleBreakpoint
nnoremap <C-F10>  <Plug>VimspectorStepOver
nnoremap <C-F11>  <Plug>VimspectorStepInto
nnoremap <C-F12>  <Plug>VimspectorStepOut
nnoremap <Leader><F11> <Plug>VimspectorUpFrame
nnoremap <Leader><F12> <Plug>VimspectorDownFrame
nnoremap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <Leader>dr :VimspectorReset<CR>
nnoremap <expr> <leader>de ':VimspectorEval '.expand('<cword>')
nnoremap <expr> <leader>dw ':VimspectorWatch '.expand('<cword>')
nnoremap <Leader>dwc :call MaximizeWin(g:vimspector_session_windows.code)<CR>
nnoremap <Leader>dwo :call MaximizeWin(g:vimspector_session_windows.output)<CR>
nnoremap <Leader>dws :call MaximizeWin(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <Leader>dwt :call MaximizeWin(g:vimspector_session_windows.tabpage)<CR>
nnoremap <Leader>dwv :call MaximizeWin(g:vimspector_session_windows.variables)<CR>
nnoremap <Leader>dww :call MaximizeWin(g:vimspector_session_windows.watches)<CR>
" nnoremap <Leader><C-C> :call system('xclip', @0)<CR>
vnoremap <silent><Leader><C-C> "yy <Bar> :call system('xclip -sel clipboard', @y)<CR>

" for visual mode, the visually selected text
xnoremap <Leader>di <Plug>VimspectorBalloonEval

" === LSP configuration
" (https://github.com/prabirshrestha/vim-lsp/blob/master/doc/vim-lsp.txt)
" let g:lsp_diagnostics_enabled=0  # Disable diagnostics
" let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GU
let g:lsp_diagnostics_echo_cursor = 1 " Enables echo of diagnostic error for the current line to status.
let g:lsp_diagnostics_virtual_text_enabled = 0

" === vim-maximizer
" let g:maximizer_set_default_mapping = 1
let g:maximizer_default_mapping_key = '<C-W>o'

" ===  netrw configuration
"
" Disable <CR> from left-click (to prevent left-click from entering directory)
au FileType netrw nmap <buffer> <LeftMouse> <LeftMouse>
" Map double-click to <CR>
au FileType netrw nmap <buffer> <2-LeftMouse> <LeftMouse><CR>
" Map CTRL-click to "mark file"
au FileType netrw nmap <buffer> <C-LeftMouse> <LeftMouse>mf
let g:session_autosave="no"

