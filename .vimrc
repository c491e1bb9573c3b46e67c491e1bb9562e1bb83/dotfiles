" disable netrw (ew)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" plugins
call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug 'romainl/vim-cool'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'matze/vim-move'
Plug 'Asheq/close-buffers.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'liuchengxu/vim-which-key'
Plug 'mbbill/undotree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
Plug 'puremourning/vimspector'
Plug 'romainl/vim-qf/'
Plug 'mhinz/vim-startify'
Plug 'terryma/vim-expand-region'
Plug 'svermeulen/vim-cutlass'
Plug '0x16e/vim-buftabline'
Plug '0x16e/vim-code-dark'
Plug '0x16e/vim-bbye'
Plug '0x16e/vim-commentary'
call plug#end()

" vim
syntax on
filetype plugin indent on
setglobal hlsearch
setglobal ignorecase
setglobal smartcase
setglobal incsearch
setglobal clipboard^=unnamed,unnamedplus
setglobal guifont=Iosevka\ Nerd\ Font\ Mono\ 15
setglobal guioptions-=mrL
setglobal guioptions-=T
setglobal wildmenu
setglobal wildoptions+=fuzzy
setglobal wildignore+=*.o
setglobal mouse=a
setglobal shortmess=a
setglobal completeopt-=preview
setglobal switchbuf=useopen
setglobal tabstop=4
setglobal shiftwidth=4
setglobal smarttab
setglobal smartindent
setglobal expandtab
setglobal cindent
setglobal cinoptions+=g0
setglobal hidden
setglobal termwinsize=10x0
setglobal splitbelow
setglobal pumheight=10
setglobal encoding=utf-8
setglobal guicursor+=i:ver100-Cursor
setglobal shell=/bin/zsh
let mapleader = "\<Space>"

colorscheme codedark

augroup vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC | call feedkeys("\<C-l>")
    " autocmd BufEnter * let s:empty_winnr = bufwinnr(str2nr(join(filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && getbufvar(v:val, "&filetype") !=? "startify"')))) | if s:empty_winnr != -1 | echom "sex" | endif
augroup END

" backup
setglobal noswapfile
setglobal nobackup
setglobal undofile
let &undodir = expand('~/.vim/undo')
if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif

" statusline
setglobal laststatus=2
setglobal statusline=[%n]\ %{expand('%:.')}
setglobal showtabline=2
setglobal titlestring=%{v:progname}\ %{tolower(empty(v:servername)?'':'--servername\ '.v:servername.'\ ')}%{fnamemodify(getcwd(),':~')}%{exists('$SSH_TTY')?'\ <'.hostname().'>':''}
setglobal iconstring=%{tolower(empty(v:servername)?v:progname\ :\ v:servername)}%{exists('$SSH_TTY')?'@'.hostname():''}

" gutter
setglobal signcolumn=yes
let &fillchars ..= ',eob: '

augroup terminal_no_sign
    autocmd!
    autocmd TerminalOpen * setlocal signcolumn=no
augroup END

" ycm
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_auto_hover = ''
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_enable_semantic_highlighting = 1
nmap <Leader>h <Plug>(YCMHover)
nmap <Leader>o <Plug>(YCMFindSymbolInDocument)
nmap <Leader>t <Plug>(YCMFindSymbolInWorkspace)
nnoremap <silent> <F12> <Cmd>YcmCompleter GoToDefinition <bar> YcmCompleter GoToInclude<CR>
nnoremap <silent> <Leader><F12> <Cmd>YcmCompleter GoToDeclaration<CR>
nnoremap <silent> <S-F12> <Cmd>YcmCompleter GoToReferences<CR>
nnoremap <F2> <Cmd>execute 'YcmCompleter RefactorRename' input('Rename to: ')<CR>
nnoremap <silent> <Leader>f <Cmd>YcmCompleter Format<CR>
nnoremap <silent> <Leader>. <Cmd>YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>m <Cmd>YcmDiags<CR>

augroup ycm_keep_quickfix
    autocmd!
    autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave
augroup END

call prop_type_add( 'YCM_HL_class', { 'highlight': 'LspCxxHlSymClass' } )
call prop_type_add( 'YCM_HL_struct', { 'highlight': 'LspCxxHlSymStruct' } )
call prop_type_add( 'YCM_HL_enum', { 'highlight': 'LspCxxHlSymEnum' } )
call prop_type_add( 'YCM_HL_namespace', { 'highlight': 'LspCxxHlSymNamespace' } )
call prop_type_add( 'YCM_HL_typeParameter', { 'highlight': 'LspCxxHlSymTypeParameter' } )

" rooter
let g:rooter_patterns = ['Makefile']
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1

" nerdtree
let g:NERDTreeWinSize = 30
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw = 0
nnoremap <silent> <Leader>b <Cmd>NERDTree<CR>

augroup nerdtree_autoclose
    autocmd!
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif
augroup END

augroup nerdtree_fix
    autocmd!
    autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup END

if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" fzf
let g:fzf_layout = { 'up': '30%' }
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <silent> <Leader>p <Cmd>Files<CR>
nnoremap <silent> <Leader>kp :<C-u>Buffers<CR>

" qf
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0

" startify
let g:startify_change_to_dir = 0
let g:startify_bookmarks = ['~/.vimrc']
let g:startify_lists = [
\ { 'type': 'files', 'header': ['	Recent'] },
\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
\ ]
let s:startify_ascii_header = [
 \ '           ▟▙             ',
 \ '           ▝▘             ',
 \ ' ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖ ',
 \ ' ▝██  ██▘  ██  ██▛▜██▛▜██ ',
 \ '  ▜█▙▟█▛   ██  ██  ██  ██ ',
 \ '  ▝████▘   ██  ██  ██  ██ ',
 \ '    ▀▀     ▀▀  ▀▀  ▀▀  ▀▀ ',
 \ '',
 \]
let g:startify_custom_header = map(s:startify_ascii_header + startify#fortune#quote(), '"   ".v:val')

augroup startify_autoclose
    autocmd!
    autocmd BufEnter * if line2byte('$') == -1 && len(tabpagebuflist()) == 1 && empty(bufname()) | Startify | endif
augroup END

function! s:terminal_instance()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val) && "terminal" ==# getbufvar(v:val, "&buftype")'))
endfunction

let s:terminal_opened = 0
function! s:trigger()
    if s:terminal_instance() == 0 && s:terminal_opened == 1
        let s:terminal_opened = 0
        if exists('#User#TerminalClose')
            execute 'doautocmd User TerminalClose'
        endif
    endif
endfunction

augroup startify_fix
    autocmd!
    autocmd TerminalOpen * let s:terminal_opened = 1
    autocmd BufEnter * call s:trigger()
    autocmd BufEnter * if &filetype ==# 'startify' | execute 'Bdelete nameless' | endif
    autocmd User TerminalClose if line2byte('.') == -1 && winnr('$') > 1 && empty(bufname()) | execute winnr('#') ' wincmd w' | endif
augroup END

" buftabline
let g:buftabline_indicators = 1

" gitgutter
let g:gitgutter_map_keys = 0

" bbye
nnoremap <silent> <Leader>w <Cmd>Bbye<CR>

" close-buffers
nnoremap <silent> <Leader>kw <Cmd>Bdelete all<CR>

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" general mappings
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap <Space> <Nop>
nnoremap Y y$
nnoremap <silent> <Leader><PageUp> <Cmd>bp<CR>
nnoremap <silent> <Leader><PageDown> <Cmd>bn<CR>
tnoremap <C-W>p <C-W>"+
nnoremap <expr> <silent> <Leader>` <SID>terminal_instance() == 0 ? '<Cmd>term<CR>' : ''
nnoremap <silent> <Leader>\ <Cmd>vs<CR>

" project (mostly c++ and c)
let $CC = 'gcc'
let $CFLAGS = '-std=c11'
let $CXX = 'g++'
let $CXXFLAGS = '-std=c++17 -ggdb3 -O0 -pipe -static'
let $LDLIBS = '-lm'
nnoremap <expr> <silent> <Leader>B !empty(FindRootDirectory()) ? '<Cmd>wa <bar> make<CR>' : '<Cmd>w <bar> make %:.:r<CR>'
nnoremap <expr> <silent> <Leader><F5> <SID>terminal_instance() == 0 ? !empty(FindRootDirectory()) ? '<Cmd>term make run<CR>' : '<Cmd>term ./%:.:r<CR>' : ''
nnoremap <silent> <Leader><F7> <Cmd>w <bar> execute '!' . $CXX . ' ' . $CXXFLAGS . ' ' . $LDLIBS . ' ' . expand('%') . ' ' . '-o' . ' ' . expand('%:.:r')<CR>

" numberline
setglobal nu
augroup number_toggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"                | setlocal rnu        | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                                 | setlocal nornu      | endif
    autocmd BufEnter,WinEnter                         * if bufname("%:.:r") ==# '_ycm_filter_' | setlocal nonu nornu | endif
    autocmd TerminalOpen                              *						                     setlocal nonu nornu
augroup END

" no idea lol
setglobal diffexpr=MyDiff()
function! MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg1 = substitute(arg1, '!', '\!', 'g')
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg2 = substitute(arg2, '!', '\!', 'g')
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let arg3 = substitute(arg3, '!', '\!', 'g')
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			if empty(&shellxquote)
				let l:shxq_sav = ''
				set shellxquote&
			endif
			let cmd = '"' . $VIMRUNTIME . '\diff"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	let cmd = substitute(cmd, '!', '\!', 'g')
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	if exists('l:shxq_sav')
		let &shellxquote=l:shxq_sav
	endif
endfunction
