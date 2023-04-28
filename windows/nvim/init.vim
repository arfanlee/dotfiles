call plug#begin('C:\Users\Arfan Lee\AppData\Local\nvim\plugged')

" Icons
Plug 'ryanoasis/vim-devicons'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Intellisense
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'

" Rust linter
Plug 'simrat39/rust-tools.nvim'

" Themes
Plug 'rebelot/kanagawa.nvim'

" Statusline theme
Plug 'kdheepak/tabline.nvim'
Plug 'nvim-lualine/lualine.nvim'

" Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" Git plugin
Plug 'tpope/vim-fugitive'

" Python indent fix
Plug 'Vimjas/vim-python-pep8-indent'

" NERDTree
Plug 'preservim/nerdtree'

call plug#end()

" To have VIM jump to last position when reopen file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" NERDTree config.
autocmd StdinReadPre * let s:std_in=1
" Start NERDTree when Vim is started without file arguments.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Start NERDTree when Vim stats with a dir arg.
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

set guifont=JetBrains\ Mono:h14
set number
set relativenumber
set cursorline
set laststatus=2
set tabstop=4
set shiftwidth=4
set path+=** " pathing all files/directories on the machine
set wildmenu " display menu option with shift/S+shift to select
set hidden
set noshowmode
set mouse=a
set nowrap
set clipboard+=unnamedplus

" Neovide
let g:neovide_remember_window_size=v:true
let g:neovide_cursor_vfx_mode="torpedo"

"Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'kanagawa'
let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.subseparator = {'left': '', 'right': ''}
let g:lightline.component_function = {'filetype': 'MyFiletype', 'fileformat': 'MyFileformat'}
let g:lightline.tab = {'active':['filename', 'modified'], 'inactive': ['filename', 'modified'] }

" NERDTRee
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Built in :nohls macro key = <C-l>

" To open new tab without entering the command
nnoremap <silent> te :tabedit .<Return>

" To change tabs in vim
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" To close current tab
nnoremap <silent> tc :tabclose<Return> 

" Open buffer
nnoremap <S-b> :b<Space>

" Open finder Alt/Meta + f
nnoremap <silent> <M-f> :Files<Return>

" Quick command
nnoremap <silent> <Esc>q :q<Return>
nnoremap <silent> <C-s> :w<Return>

" NERDTree Toggle
nnoremap <silent> <C-f> :NERDTreeToggle<Return>

colorscheme kanagawa

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

luafile C:\Users\Arfan Lee\AppData\Local\nvim\lua\cmp-config.lua
luafile C:\Users\Arfan Lee\AppData\Local\nvim\lua\theme.lua
