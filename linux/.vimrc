set clipboard+=unnamedplus
set cursorline
set fsync
set guifont=JetBrainsMono\ Nerd\ Font:h12
set hidden
set laststatus=2
set mouse=a
set noshowmode
set number
set path+=** " pathing all files/directories on the machine
set relativenumber
set shiftwidth=4
set tabstop=4
set wildmenu " display menu option with shift/S+shift to select
filetype plugin indent on

" To open new tab without entering the command
nnoremap <silent> te :tabedit<Return>:tabm<Return>:e .<Return>

" To change tabs in vim
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" To close current tab
nnoremap <silent> tc :tabclose<Return> 

" Open buffer
nnoremap <S-b> :b<Space>

" Open shell
nnoremap <F5> :shell<cr>

" To change option in auto complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" To remove highlights
nnoremap <silent> <Esc>n :nohls<Return>

" To have VIM jump to last position when reopen file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
