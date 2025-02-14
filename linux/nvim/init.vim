" Plugin Manager: vim-plug
call plug#begin('~/.config/nvim/plugged')

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Surrounding pairs
Plug 'jiangmiao/auto-pairs'
Plug 'kylechui/nvim-surround'

" Indentation guide
Plug 'lukas-reineke/indent-blankline.nvim'

" LSP and autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'

" Rust tools
Plug 'simrat39/rust-tools.nvim'

" Themes
Plug 'rebelot/kanagawa.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

" Tabline
Plug 'akinsho/bufferline.nvim'

" Git integration
Plug 'tpope/vim-fugitive'

" Markdown support
Plug 'gabrielelana/vim-markdown'

" Python indentation
Plug 'Vimjas/vim-python-pep8-indent'

" File explorer
Plug 'preservim/nerdtree'

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

" Jump to last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" NERDTree configuration
autocmd StdinReadPre * let s:std_in=1
" Start NERDTree when Vim is started without file arguments.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Start NERDTree when Vim stats with a dir arg.
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Set color scheme
colorscheme kanagawa

" General settings
set clipboard+=unnamedplus
set cursorline
set fsync
set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h12
set hidden
set laststatus=2
set mouse=a
set noshowmode
set number
set path+=**
set relativenumber
set shiftwidth=4
set tabstop=4
set wildmenu
setlocal scrolloff=999

" Neovide settings
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_smooth_blink = v:true
let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_cursor_animate_in_insert_mode = v:true
let g:neovide_cursor_vfx_particle_phase = 3

" NERDTree settings
let g:NERDTreeDirArrowCollapsible = '󰁊'
let g:NERDTreeDirArrowExpandable = '󰁙'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeChDirMode = 0
set autochdir

" Markdown settings
let g:markdown_mapping_switch_status = '<C-m>'

" Key mappings
inoremap <C-Del> <C-o>dw
nnoremap <silent> <C-t> :tabedit .<Return>
nnoremap <silent> <C-x> :bd<Return>
nnoremap <S-b> :b<Space>
nnoremap <silent> <C-Tab> :bn<Return>
nnoremap <silent> <C-S-Tab> :bp<Return>
nnoremap <silent> <Esc>q :q<Return>
nnoremap <silent> <C-s> :w<Return>
nnoremap <silent> <C-f> :NERDTreeToggle<Return>
nnoremap <silent> <leader>sv :source $MYVIMRC<Return>

" Load Lua configurations
luafile ~/.config/nvim/lua/cmp-config.lua
luafile ~/.config/nvim/lua/theme.lua
