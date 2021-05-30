"--------------------------------------
"--------Normal Settings----------------
"--------------------------------------
syntax enable
set number relativenumber
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set incsearch
set expandtab
set smartindent
set scrolloff=10
"----------------------------
"------Plug installation-----
"-----------------------------

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim' 
Plug 'https://github.com/alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/fern.vim'
Plug 'metakirby5/codi.vim'
Plug 'mattn/emmet-vim'
Plug 'arthurxavierx/vim-caser'
Plug 'yuezk/vim-js'
Plug 'cocopon/iceberg.vim' 
Plug 'https://github.com/sirver/UltiSnips'
Plug 'https://github.com/tpope/vim-fugitive'
"Plug 'jmckiern/vim-shoot', { 'do': '\"./install.py\" geckodriver' }
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-eslint', 
  \ 'coc-css', 
  \ 'coc-html', 
  \ 'coc-spell-checker', 
  \ ]
"----------------------------
"--------Spell Check---------
"----------------------------
vmap <C-a> <Plug>(coc-codeaction-selected)
nma <C-a> <Plug>(coc-codeaction-selected)
"---------------------------
"-Default KeyBinfing Remap--
"---------------------------
nnoremap <C-o> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap <C-d> :bd<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-w> :w<CR>

"----------------------------
"------Theme Setting---------
"----------------------------
if (has("termguicolors"))
 set termguicolors
endif
colorscheme iceberg
let g:airline_theme = 'iceberg'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"----------------------------------
"--------Vim Closing tag-----------
"----------------------------------

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.json'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.json'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,js,json,jsx'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js,json'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'


" .............................................................................
" lambdalisue/fern.vim
" .............................................................................

" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

noremap <silent> <C-f> :Fern . -drawer -reveal=% -toggle -width=30<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> k <Plug>(fern-action-mark-toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
