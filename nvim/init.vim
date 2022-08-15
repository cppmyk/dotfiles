call plug#begin()

"Directory tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Colochemes
Plug 'morhetz/gruvbox'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'joshdick/onedark.vim'

"Auto braces
Plug 'jiangmiao/auto-pairs'

"Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Valloric/YouCompleteMe'

"Full path finder
Plug 'kien/ctrlp.vim'

"Fast motion
Plug 'easymotion/vim-easymotion'

"Bottom info panel
Plug 'vim-airline/vim-airline'

Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-syntastic/syntastic'

"Search in files
Plug 'rking/ag.vim'

"Switch between .h and .c files
Plug 'vim-scripts/a.vim'

"Formatter
Plug 'rhysd/vim-clang-format'

Plug 'preservim/tagbar'

Plug 'catppuccin/nvim', {'as': 'catppuccin'}

Plug 'sevko/vim-nand2tetris-syntax'

call plug#end()

set exrc
set secure

syntax on
set background=dark
set number
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set nowrap
set nohlsearch
set hidden
set scrolloff=8
set colorcolumn=80
set noswapfile

:retab

set hlsearch
set incsearch

set visualbell

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Colorscheme
"colorscheme gruvbox
"let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
"lua << EOF
"require("catppuccin").setup()
"EOF
colorscheme catppuccin

" coc tab autocomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

"Ctags
"set tags=/tags,tags:$HOME

" --- Bad typing experience ----
"nnoremap <Space> <Nop>
let mapleader=","

"mappings
map <C-n> :NERDTreeToggle<CR>

nmap <F8> :TagbarToggle<CR>
" Compact togglebar size
let g:tagbar_compact = 1  
" Off name sorting
let g:tagbar_sort = 0

"Disable search highlight
"map <esc> :noh <CR>

"EasyMotion
"map <Leader> <Plug>(easymotion-prefix)
map <leader>s <Plug>(easymotion-s)

"Windows mappings
map <silent> <C-h> :call WinMove('h')<CR>                                               
map <silent> <C-j> :call WinMove('j')<CR>                                               
map <silent> <C-k> :call WinMove('k')<CR>                                               
map <silent> <C-l> :call WinMove('l')<CR>                                               
                     
function! WinMove(key)                                                                  
  let t:curwin = winnr()                                                                
  exec "wincmd ".a:key                                                                  
  if (t:curwin == winnr())                                                              
    if(match(a:key,'[jk]'))                                                             
     wincmd v                                                                          
    else                                                                                
     wincmd s                                                                          
    endif                                                                               
     exec "wincmd ".a:key                                                                
   endif                                                                                 
endfunction


"System clipboard mappings
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif



" Coc settings
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ CheckBackspace() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"g:clang_format#code_style = "google"
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
