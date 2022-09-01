call plug#begin('~/.config/nvim/plugged')

" Icons
Plug 'kyazdani42/nvim-web-devicons'

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
Plug 'joshdick/onedark.vim'
Plug 'rebelot/kanagawa.nvim'

" Statusline theme
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim'

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

set guifont=JetBrains\ Mono:h12
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
set clipboard^=unnamed,unnamedplus

" Neovide
let g:neovide_remember_window_size=v:true
let g:neovide_cursor_vfx_mode="torpedo"

" NERDTRee
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '

" Built in :nohls macro key = <C-l>

" To open new tab without entering the command
nnoremap <silent> <C-t> :tabedit .<Return>

" To change tabs in vim
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" To close current tab
nnoremap <silent> <C-w> :tabclose<Return> 

" Open buffer
nnoremap <S-b> :b<Space>
" Navigate through buffer
nnoremap <silent> <C-n> :bn<Return>
nnoremap <silent> <C-p> :bp<Return>

" Open finder Alt/Meta + f
nnoremap <silent> <M-f> :Files<Return>

" Quick command
nnoremap <silent> <Esc>q :q<Return>
nnoremap <silent> <C-s> :w<Return>

" NERDTree Toggle
nnoremap <silent> <C-f> :NERDTreeToggle<Return>

colorscheme kanagawa

luafile ~/.config/nvim/lua/plugins/cmp-config.lua
luafile ~/.config/nvim/lua/plugins/theme.lua
