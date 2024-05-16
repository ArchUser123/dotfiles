call plug#begin()
	Plug 'tomasiser/vim-code-dark'
	Plug 'girishji/vimcomplete'
	Plug 'github/copilot.vim'
	Plug 'nanotech/jellybeans.vim'
	Plug 'vimsence/vimsence'
	Plug 'preservim/nerdtree'
	Plug 'xavierd/clang_complete'
	Plug 'tmsvg/pear-tree'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ayu-theme/ayu-vim'
	Plug 'davidhalter/jedi-vim'
	Plug 'google/vim-maktaba'
	Plug 'google/vim-codefmt'
call plug#end()

set t_Co=256
set t_ut=
colorscheme jellybeans
set nu

" Define a custom command :runcpp to run C++ code in a terminal
command! -nargs=+ -complete=file Runcpp call s:RunCpp(<f-args>)

" Function to run C++ code in a terminal
function! s:RunCpp(...) abort
    " Save the current buffer
    let l:current_buffer = bufnr('%')
    let l:current_window = winnr()

    " Get the command to execute
    let l:command = 'clear && ' . join(a:000, ' ')

    " Execute the command in a new tab
    silent execute 'tabnew'
    silent execute 'terminal ++close ++rows=' . &lines . ' ++cols=' . &columns . ' ' . l:command

    " Switch to terminal mode
    startinsert

    " Define a function to return to Vim when pressing Esc
    nnoremap <silent> <buffer> <Esc> <Cmd>q!<CR>

    " Switch back to the previous buffer and window when the terminal is closed
    au TerminalClose * ++nested call s:SwitchToVim()
endfunction

" Function to switch back to Vim when the terminal is closed
function! s:SwitchToVim() abort
    " Switch back to the previous buffer and window
    execute 'buffer' l:current_buffer
    execute l:current_window . 'wincmd w'
endfunction

set ts=4 sw=4

set termguicolors
let ayucolor="dark"
nnoremap <silent> t :NERDTree<CR>


augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,typescript,arduino AutoFormatBuffer clang-format
  autocmd FileType clojure AutoFormatBuffer cljstyle
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType elixir,eelixir,heex AutoFormatBuffer mixformat
  autocmd FileType fish AutoFormatBuffer fish_indent
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType haskell AutoFormatBuffer ormolu
  " Alternative for web languages: prettier
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType jsonnet AutoFormatBuffer jsonnetfmt
  autocmd FileType julia AutoFormatBuffer JuliaFormatter
  autocmd FileType kotlin AutoFormatBuffer ktfmt
  autocmd FileType lua AutoFormatBuffer luaformatterfiveone
  autocmd FileType markdown AutoFormatBuffer prettier
  autocmd FileType ocaml AutoFormatBuffer ocamlformat
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType ruby AutoFormatBuffer rubocop
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType swift AutoFormatBuffer swift-format
  autocmd FileType vue AutoFormatBuffer prettier
augroup END
