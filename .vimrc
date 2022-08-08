" disable netrw (ew)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

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
Plug 'ap/vim-buftabline'
Plug 'itchyny/lightline.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'mhinz/vim-startify'
call plug#end()

" vim settings
syntax on
filetype plugin indent on
set hlsearch
set ignorecase
set smartcase
set incsearch
set clipboard^=unnamed,unnamedplus
set guifont=Iosevka\ Nerd\ Font\ Mono\ 14
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=L
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

" backup settings
set noswapfile
set nobackup
set undofile
let &undodir = expand('~/.vim/undo')
if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif

" statusline settings
set laststatus=2

" gutter settings
set signcolumn=yes
hi signcolumn guibg=bg
let &fillchars ..= ',eob: '
autocmd TerminalOpen * setlocal signcolumn=no

" ycm settings
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
autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave

" rooter settings
let g:rooter_patterns = ['Makefile']
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1

let g:startify_change_to_dir = 0

" nerdtree settings
let g:NERDTreeWinSize = 30
let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden = 1
let NERDTreeHijackNetrw = 0
nnoremap <silent> <Leader>b :<C-U>NERDTree<CR>
autocmd BufEnter,WinEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif
augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" fzf settings
let g:fzf_layout = { 'up': '30%' }
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <silent> <Leader>p :<C-U>Files<CR>
nnoremap <silent> <Leader>kp :<C-u>Buffers<CR>

" lightline settings
let g:lightline = {
\ 'colorscheme': 'one',
\ 'component_function': {
\   'filename': 'Lightlinefilename',
\ },
\ }
function! Lightlinefilename()
  return expand('%:.')
endfunction

" startify settings
let g:startify_custom_header = [
\ "                 ________  ++    _______",
\ "                /VVVVVVVV\\++++  /VVVVVVV\|",
\ "                \\VVVVVVVV/++++++\\VVVVVVV|",
\ "                 |VVVVVV|++++++++/VVVVV/'",
\ "                 |VVVVVV|++++++/VVVVV/'",
\ "                +|VVVVVV|++++/VVVVV/'+",
\ "              +++|VVVVVV|++/VVVVV/'+++++",
\ "            +++++|VVVVVV|/VVVVV/'+++++++++",
\ "              +++|VVVVVVVVVVV/'+++++++++",
\ "                +|VVVVVVVVV/'+++++++++",
\ "                 |VVVVVVV/'+++++++++",
\ "                 |VVVVV/'+++++++++",
\ "                 |VVV/'+++++++++",
\ "                 'V/'   ++++++",
\ "                          ++",
\ "               Vim is love, Vim is life."
\ ]
let g:startify_bookmarks = ['~/.vimrc']
let g:startify_lists = [
	\ { 'type': 'files', 'header': ['	Recent'] },
	\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
	\ ]
autocmd BufEnter * if line2byte('.') == -1 && len(tabpagebuflist()) == 1 && empty(bufname()) | Startify | endif

" buftabline settings
hi! link BufTabLineCurrent LightlineLeft_normal_0
hi! link BufTabLineHidden LightlineLeft_normal_1
hi BufTabLineFill guibg=bg
let g:buftabline_indicators = 1

" gitgutter settings
let g:gitgutter_map_keys = 0

" bufkill settings
let g:BufKillCreateMappings = 0
let g:BufKillActionWhenBufferDisplayedInAnotherWindow = 'kill'
nnoremap <silent> <Leader>w :<C-U>BW<CR>

" close-buffers settings
nnoremap <silent> <Leader>kw :<C-U>Bdelete all<CR>

" c/c++ syntax highlight settings
let g:cpp_experimental_simple_template_highlight = 1

" mappings
nnoremap <silent> <Leader><PageUp> :<C-U>bp<CR>
nnoremap <silent> <Leader><PageDown> :<C-U>bn<CR>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap <Space> <Nop>
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
nnoremap c "_c
nnoremap C "_C
vnoremap d "_d
vnoremap c "_c
tnoremap <C-W>p <C-W>"+
nnoremap <Leader>` :<C-U>term<CR>
nnoremap <Leader>\ :<C-U>vs<CR>

" location/quickfix list settings
augroup openquickfixwindowaftermake
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END
function! Quitlast()
    if &buftype == "quickfix"
        if winnr('$') < 2
            q
        endif
    endif
endfunction
autocmd BufEnter,WinEnter * call Quitlast()

" project settings (mostly c++ and c)
let $CC = 'gcc'
let $CFLAGS = '-std=c11'
let $CXX = 'g++'
let $CXXFLAGS = '-std=c++17 -ggdb3 -O0 -pipe -static'
let $LDLIBS = '-lm'
autocmd BufNewFile,BufRead,DirChanged * if !empty(FindRootDirectory()) | let &makeprg = 'make' | else | let &makeprg = 'make %:.:r' | endif
nnoremap <expr> <silent> <Leader>B !empty(FindRootDirectory()) ? ':<C-U>wa <bar> make<CR>' : ':<C-U>w <bar> make<CR>'
nnoremap <silent> <Leader><F7> :<C-U>w <bar> make %:.:r<CR>
nnoremap <expr> <silent> <Leader><F5> !empty(FindRootDirectory()) ? ':<C-U>term make run<CR>' : ':<C-U>term ./%:.:r<CR>'

" vimspector settings
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" numberline settings
set nu
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"            | setlocal rnu        | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                             | setlocal nornu      | endif
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
