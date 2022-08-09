" disable netrw (ew)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

function! s:terminal_instance()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val) && "terminal" ==? getbufvar(v:val, "&buftype")'))
endfunction

" plugins
call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sheerun/vim-polyglot'
Plug 'romainl/vim-cool'
Plug 'junegunn/fzf',  { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-commentary'
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
Plug 'romgrk/doom-one.vim'
Plug 'romainl/vim-qf/'
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'legendaryzyper/vim-bclose'
Plug 'svermeulen/vim-cutlass'
call plug#end()

" vim
syntax on
filetype plugin indent on
set hlsearch
set ignorecase
set smartcase
set incsearch
set clipboard^=unnamed,unnamedplus
set guifont=Iosevka\ Nerd\ Font\ Mono\ 14
set guioptions-=mrL
set guioptions-=T
set wildmenu
set mouse=a
set shortmess=a
set completeopt-=preview
set switchbuf=useopen
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent
set expandtab
set cindent
set cinoptions+=g0
set hidden
set termwinsize=10x0
set splitbelow
set pumheight=10
set encoding=utf-8
set guicursor+=i:ver100-Cursor
set shell=/bin/zsh
let mapleader = " "
cd ~/Documents/tin
colorscheme doom-one
command! Vimrc e ~/.vimrc

" fix my problem with startify
let s:terminal_opened = 0
function! s:trigger()
    if empty(filter(range(1, bufnr('$')), 'buflisted(v:val) && "terminal" ==? getbufvar(v:val, "&buftype")'))
        if s:terminal_opened == 1
            let s:terminal_opened = 0
            if exists('#User#TerminalClose')
                execute 'doautocmd User TerminalClose'
            endif
        endif
    endif
endfunction
augroup startify_fix
    autocmd!
    autocmd TerminalOpen * let s:terminal_opened = 1
    autocmd BufEnter * call s:trigger()
    autocmd User TerminalClose if line2byte('.') == -1 && winnr('$') > 1 && empty(bufname()) | execute winnr('#') ' wincmd w' | execute 'Bdelete! nameless' | endif
augroup END

" backup
set noswapfile
set nobackup
set undofile
let &undodir = expand('~/.vim/undo')
if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif

" statusline
set laststatus=2

" gutter
set signcolumn=yes
hi signcolumn guibg=bg
let &fillchars ..= ',eob: '
augroup terminal_no_sign
    autocmd!
    autocmd TerminalOpen * setlocal signcolumn=no
augroup END

" ycm
hi ycmwarningsection gui=undercurl guisp=#B5CEA6
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_auto_hover = ''
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
nmap <Leader>h <Plug>(YCMHover)
nmap <Leader>o <Plug>(YCMFindSymbolInDocument)
nmap <Leader>t <Plug>(YCMFindSymbolInWorkspace)
nnoremap <silent> <F12> :<C-U>YcmCompleter GoToDefinition <bar> YcmCompleter GoToInclude<CR>
nnoremap <silent> <Leader><F12> :<C-U>YcmCompleter GoToDeclaration<CR>
nnoremap <silent> <S-F12> :<C-U>YcmCompleter GoToReferences<CR>
nnoremap <F2> :<C-U>YcmCompleter RefactorRename 
nnoremap <silent> <Leader>f :<C-U>YcmCompleter Format<CR>
nnoremap <silent> <Leader>. :<C-U>YcmCompleter FixIt<CR>
nnoremap <silent> <Leader>m :<C-U>YcmDiags<CR>
augroup ycm_keep_quickfix
    autocmd!
    autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave
augroup END

" rooter
let g:rooter_patterns = ['Makefile']
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1

" nerdtree
let g:NERDTreeWinSize = 30
let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden = 1
let NERDTreeHijackNetrw = 0
nnoremap <silent> <Leader>b :<C-U>NERDTree<CR>
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
nnoremap <silent> <Leader>p :<C-U>Files<CR>
nnoremap <silent> <Leader>kp :<C-u>Buffers<CR>

" lightline
let g:lightline = {
\ 'colorscheme': 'one',
\ 'component_function': {
\   'filename': "Lightlinefilename",
\ },
\ }
function! Lightlinefilename()
  return expand('%:.')
endfunction

" startify
let g:startify_change_to_dir = 0
let g:startify_bookmarks = ['~/.vimrc']
let g:startify_lists = [
\ { 'type': 'files', 'header': ['	Recent'] },
\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
\ ]
augroup startify_autoclose
    autocmd!
    autocmd BufEnter * if line2byte('.') == -1 && len(tabpagebuflist()) == 1 && empty(bufname()) | Startify | endif
augroup END

" buftabline
hi! link BufTabLineCurrent LightlineLeft_normal_0
hi! link BufTabLineHidden LightlineLeft_normal_1
hi BufTabLineFill guibg=bg
let g:buftabline_indicators = 1

" gitgutter
let g:gitgutter_map_keys = 0

" bclose
nnoremap <silent> <Leader>w :<C-U>Bclose<CR>

" close-buffers
nnoremap <silent> <Leader>kw :<C-U>Bdelete all<CR>

" c/c++ syntax highlight
let g:cpp_experimental_simple_template_highlight = 1

" general mappings
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap <Space> <Nop>
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D
nnoremap <silent> <Leader><PageUp> :<C-U>bp<CR>
nnoremap <silent> <Leader><PageDown> :<C-U>bn<CR>
tnoremap <C-W>p <C-W>"+
nnoremap <expr> <silent> <Leader>` <SID>terminal_instance() == 0 ? ':<C-U>term<CR>' : ''
nnoremap <silent> <Leader>\ :<C-U>vs<CR>

" augroup quickfix_if_error
"     autocmd!
"     autocmd QuickFixCmdPost [^l]* nested cwindow
"     autocmd QuickFixCmdPost    l* nested lwindow
" augroup END

" qf
let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

" project (mostly c++ and c)
let $CC = 'gcc'
let $CFLAGS = '-std=c11'
let $CXX = 'g++'
let $CXXFLAGS = '-std=c++17 -ggdb3 -O0 -pipe -static'
let $LDLIBS = '-lm'
augroup change_makeprg
    autocmd!
    autocmd BufNewFile,BufRead,DirChanged * if !empty(FindRootDirectory()) | let &makeprg = 'make' | else | let &makeprg = 'make %:.:r' | endif
augroup END
nnoremap <expr> <silent> <Leader>B !empty(FindRootDirectory()) ? ':<C-U>wa <bar> make<CR>' : ':<C-U>w <bar> make<CR>'
nnoremap <expr> <silent> <Leader><F5> <SID>terminal_instance() == 0 ? !empty(FindRootDirectory()) ? ':<C-U>term make run<CR>' : ':<C-U>term ./%:.:r<CR>' : ''
nnoremap <silent> <Leader><F7> :<C-U>w <bar> make %:.:r<CR>

" vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" numberline
set nu
augroup number_toggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"                | setlocal rnu        | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                                 | setlocal nornu      | endif
    autocmd BufEnter,WinEnter                         * if bufname("%:.:r") ==# '_ycm_filter_' | setlocal nonu nornu | endif
    autocmd TerminalOpen                              * setlocal nonu nornu
augroup END

" no idea lol
set diffexpr=MyDiff()
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
