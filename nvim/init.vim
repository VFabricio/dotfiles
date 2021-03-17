"GENERAL CONFIGURATIONS

fun! s:SyntaxStack()
	if !exists('*synstack')
		return
	endif
	return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command! -nargs=0 EchoHighlightingGroup echo s:SyntaxStack()

" This is my preferred mapping -- don't feel like you need to use this.
nnoremap <leader>0 :EchoHighlightingGroup<CR>

"Always save profiling information
profile start /home/fabricio/.config/nvim/profile.log
profile func *

"UTF-8 encoding
set encoding=UTF-8

"Reaching Esc sucks
inoremap kj <Esc>

"Leader
let mapleader="\\"

"Use system clipboard
set clipboard+=unnamedplus

"No exceeding 80 columns
set colorcolumn=81

"Disable compatibility with vi mode
set nocompatible

"Windows title is the name and path of the current document
set title

"No undo files polluting my filesystem
set noundofile nobackup noswapfile nowritebackup

"Let's use the system clipboard by default
set clipboard+=unnamedplus

"Spawn new windows below and on the right
set splitright
set splitbelow

"Disable highlighting of search results
set nohlsearch

"Turn on relative line numbers
set number relativenumber

"Indentation
set shiftwidth=2
set softtabstop=2
set expandtab

"Strip trailing whitespace before saving
autocmd BufWritePre * %s/\s\+$//e

"PLUGINS

"Allow filetype plugins
filetype plugin on

"Plug configuration
call plug#begin('~/.config/nvim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'dense-analysis/ale'
"  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'luochen1990/rainbow'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'ErichDonGubler/vim-sublime-monokai'
  Plug 'preservim/nerdtree'
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
"  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'leafgarland/typescript-vim'
  Plug 'neovimhaskell/haskell-vim'
  Plug 'FrigoEU/psc-ide-vim'
  Plug 'tpope/vim-fireplace'
  Plug 'vim-scripts/paredit.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
"  Plug 'ryanoasis/vim-devicons'
call plug#end()

"ALE Configuration
let g:ale_set_highlights = 0

let g:ale_linter_aliases = {
\   'svelte': ['javascript']
\}

let g:ale_linters = {
\  'javascript': ['eslint'],
\  'haskell': ['hie'],
\  'svelte': ['eslint'],
\  'purescript': ['purescript-language-server']
\}

let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'haskell': ['hie'],
\  'svelte': ['eslint'],
\  'purescript': ['purty']
\}

let g:ale_purescript_ls_config = {
\  'purescript': {
\    'addSpagoSources': v:true,
\    'addNpmPath': v:true,
\    'buildCommand': 'spago build -- --json-errors'
\  }
\}

"NerdTree toggle
map tt :NERDTreeToggle<CR>

"CHADTree
map <leader>c :CHADopen<CR>

"CtrlP configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {'dir': 'node_modules'}

"Rainbow configuration
let g:rainbow_active = 1

"vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\ue0b0"
let g:airline_right_sep = "\ue0b2"

"Syntax highlighting is nice
syntax on

"Nice colors
colorscheme dracula
set termguicolors

"Transparent gutter
highlight clear SignColumn

"FILETYPE SPECIFIC COMMANDS

"FILETYPE = tex
autocmd FileType tex call TexNewMathZone("D", "align", 1)
autocmd FileType tex set makeprg=pdflatex\ \-interaction\ batchmode\ %
autocmd FileType tex nnoremap <Leader>\ :make<CR>

" Coc config
let g:coc_disable_startup_warning = 1
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
"if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"From issue 1408
"autocmd CursorHold * silent if ! coc#util#has_float()
"  \| call CocActionAsync('doHover')
"\| endif
