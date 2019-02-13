" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

" filetype on
filetype plugin on

" set leader key
let mapLeader = " "

" check if minpac is available
if exists('*minpac#init')
	call minpac#init()

	" install NERD commenter
	call minpac#add('scrooloose/nerdcommenter')

	" install fzf
	call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
	call minpac#add('junegunn/fzf.vim')

	" haskell indenter
	call minpac#add('itchyny/vim-haskell-indent')

	" google code formatter
	call minpac#add('google/vim-maktaba')
	call minpac#add('google/vim-codefmt')
	call minpac#add('google/vim-glaive')
	call minpac#add('lpenz/vim-codefmt-haskell')

	" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Add other plugins here.

	" vim-polyglot syntax highlighting for various file types and languages
	call minpac#add('sheerun/vim-polyglot')

	" Generate statuslines for tmux.
	call minpac#add('edkolev/tmuxline.vim', {'type': 'opt'})

	" Apply indentation from .editorconfig files.
	call minpac#add('editorconfig/editorconfig-vim')

	" Statusline
    	call minpac#add('itchyny/lightline.vim')
    	call minpac#add('cocopon/lightline-hybrid.vim')

	" Switch to absolute line numbers for buffers that are not selected.
    	call minpac#add('jeffkreeftmeijer/vim-numbertoggle')

	" Hardtime - get learnt
	call minpac#add('takac/vim-hardtime')

	" Focus events & clipboard for tmux
	call minpac#add('roxma/vim-tmux-clipboard')

	" Autocompletion/linting.
    	call minpac#add('w0rp/ale')
    	call minpac#add('maximbaz/lightline-ale')

	" Easy navigation between vim splits and tmux panes.
    	call minpac#add('christoomey/vim-tmux-navigator')

	" Improvements to netrw.
    	call minpac#add('tpope/vim-vinegar')

        " Generate ctags for projects.
	call minpac#add('ludovicchabant/vim-gutentags')

	"  Show Git changes in the sign column.
	call minpac#add('mhinz/vim-signify')

	" Wrapper for Git.
	call minpac#add('tpope/vim-fugitive')

	" GitHub extension for `vim-fugitive`.
    	call minpac#add('tpope/vim-rhubarb')

	if has("unix")
		" Helper functions for unix commands (`mkdir`, `mv`, etc.)
		call minpac#add('tpope/vim-eunuch')
	endif

	if has('nvim')
		" Neovim terminal utilities.
	        call minpac#add('vimlab/split-term.vim')
	endif

	" Detect indentation heuristically.
    	call minpac#add('tpope/vim-sleuth')

	" Improved incremental search - hides search highlighting after moving cursor.
    	call minpac#add('haya14busa/is.vim')

	" Support for more focus events.
    	call minpac#add('tmux-plugins/vim-tmux-focus-events')
endif

" Timeout Lengths {{{
" ===============
" This should make pressing ESC more responsive.
" Alternative to `set esckeys` as this breaks sequences in INSERT mode that uses ESC.
set timeoutlen=250 ttimeoutlen=0
" }}}

" Enable Hardtime by default
let g:hardtime_default_on = 1

" Ale {{{
" ===
" Enable completion.
let g:ale_completion_enabled = 1
" Fix completion bug in some versions of Vim.
set completeopt=menu,menuone,preview,noselect,noinsert

" Set formatting.
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Set linters and fixers.
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'c': [ 'cquery' ],
\   'cpp': [ 'cquery' ],
\   'css': [ 'csslint' ],
\   'llvm': [ 'llc' ],
\   'lua': [ 'luac' ],
\   'python': [ 'flake8' ],
\   'ruby': [ 'rubocop' ],
\   'rust': [ 'cargo', 'rls' ],
\   'vim': [ 'vint' ],
\   'haskell': ['stack-build', 'hlint', 'hdevtools', 'hfmt'],
\}

" Use stable Rust for RLS.
let g:ale_rust_rls_toolchain = 'stable'

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\ }

" Set bindings.
nmap <Leader>ad <plug>(ale_go_to_definition)
nmap <Leader>ar <plug>(ale_find_references)
nmap <Leader>ah <plug>(ale_hover)
nmap <Leader>af <plug>(ale_fix)
nmap <Leader>at <plug>(ale_detail)
nmap <Leader>an <plug>(ale_next_wrap)
nmap <Leader>ap <plug>(ale_previous_wrap)

" Set quicker bindings.
nmap <C-n> <plug>(ale_next_wrap)
nmap <C-@> <plug>(ale_previous_wrap)
nmap <C-q> <plug>(ale_go_to_definition)
nmap <C-s> <plug>(ale_fix)
nmap <C-x> <plug>(ale_find_references)
" }}}

set nofoldenable    " disable folding

" set line numbers to be relative + abs value of current line
set number
set relativenumber

" Reading {{{
" =======
" Automatically reload files if changed from outside.
set autoread

if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction
" }}}

" UI & Visual Cues {{{
" ================
" Show ruler.
set ruler
" }}

" Mappings {{{
" ========
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>r :so $MYVIMRC<CR>

" clear search results
nmap <Leader><leader> :noh<CR>

" enable esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" `w!!` will save a file opened without sudo.
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" }}}

" Mouse {{{
" ==============
" Enable he mouse.
set mouse=a
" }}}

" Searching {{{
" =========
" Highlight matches.
set hlsearch
" Highlight matches as we type.
set incsearch
" Ignore case when searching.
set ignorecase
" Don't ignore case when different cases searched for.

set smartcase

" fzf {{{
nnoremap <C-p> :Files<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>pg :GFiles<CR>
nnoremap <Leader>pc :Commits<CR>
nnoremap <Leader>pb :Buffers<CR>
nnoremap <Leader>pt :Tags<CR>

" Mapping selecting mappings
nmap <Leader><tab> <plug>(fzf-maps-n)
xmap <Leader><tab> <plug>(fzf-maps-x)
omap <Leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><C-k> <plug>(fzf-complete-word)
imap <c-x><C-f> <plug>(fzf-complete-path)
imap <c-x><C-j> <plug>(fzf-complete-file-ag)
imap <c-x><C-l> <plug>(fzf-complete-line)
" }}}

" History {{{
" ====
" Increase history.
set history=1000
" }}}

" Lightline {{{
" =========
let g:lightline = {}
let g:lightline.colorscheme = 'hybrid'

let g:lightline.active = {
\   'left': [
\       [ 'mode' ],
\       [ 'paste', 'spell', 'gitbranch', 'readonly', 'filename' ]
\   ],
\   'right': [
\       [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
\       [ 'gutentags' ],
\       [ 'obsession', 'fileformat', 'fileencoding', 'filetype', 'charvaluehex', 'lineinfo',
\         'percent' ]
\   ]
\ }

let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ }

let g:lightline.component_type = {
\   'linter_checking': 'left',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'left',
\ }

let g:lightline.component_function = {
\   'gitbranch': 'fugitive#head',
\   'gutentags': 'LightlineGutentags',
\   'obsession': 'ObsessionStatus',
\   'readonly': 'LightlineReadonly',
\   'fileformat': 'LightlineFileformat',
\   'filetype': 'LightlineFiletype',
\   'filename': 'LightlineFilename'
\ }

function! LightlineFilename()
    " Get the full path of the current file.
    let filepath =  expand('%:p')
    let modified = &modified ? ' +' : ''

    " If the filename is empty, then display
    " nothing as appropriate.
    if empty(filepath)
        return '[No Name]' . modified
    endif

    " Find the correct expansion depending on whether Vim has
    " autochdir.
    let mod = (exists('+acd') && &acd) ? ':~' : ':~:.'

    " Apply the above expansion to the expanded file path and split
    " by the separator.
    let shortened_filepath = fnamemodify(filepath, mod)

    if len(shortened_filepath) < (winwidth('%') / 3)
        return shortened_filepath.modified
    endif

    " Ensure that we have the correct slash for the OS.
    let dirsep = has('win32') && ! &shellslash ? '\' : '/'
    " Check if the filepath was shortened above.
    let was_shortened = filepath != shortened_filepath

    " Split the filepath.
    let filepath_parts = split(shortened_filepath, dirsep)

    " Take the first character from each part of the path (except the tidle and filename).
    let initial_position = was_shortened ? 0 : 1
    let excluded_parts = filepath_parts[initial_position:-2]
    let shortened_paths = map(excluded_parts, 'v:val[0]')

    " Recombine the shortened paths with the tilde and filename.
    let combined_parts = shortened_paths + [filepath_parts[-1]]
    let combined_parts = (was_shortened ? [] : [filepath_parts[0]]) + combined_parts

    " Recombine into a single string.
    let finalpath = join(combined_parts, dirsep)
    return finalpath . modified
endfunction
function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineGutentags()
    return gutentags#statusline('')
endfunction
function! LightlineReadonly()
    return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction
" }}}

" File Navigation {{{
" ===============
" Map %% to the current opened file's path.
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
" Map helpful commands for editing files in that directory. (Leader defaults
" to \)
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%
" }}}

" Scrolling {{{
" =========
" Keep a minimum of 5 line below the cursor.
set scrolloff=5
" Keep a minimum of 5 columns left of the cursor.
set sidescrolloff=5
" }}}

" Spelling {{{
" ========
set spelllang=en_gb
set spellfile=~/.vim/spell/en-gb.utf-8.add
" }}}

" Tab Completion {{{
" ==============
" Turn on wildmenu for file name tab completion.
set wildmode=longest,list,full
set wildmenu
" }}}

" Tmuxline {{{
" ========
let g:tmuxline_powerline_separators = 1
" }}}

" Undo/Backups {{{
" ============
" If a path ends in '//' then the swap file name
" is built from the entire path. No more issues between
" projects.

" Change swap directory.
if isdirectory($HOME . '/.vim/swap') == 0
    call mkdir($HOME . '/.vim/swap', 'p')
endif
set directory=~/.vim/swap//

" Change backup directory.
if isdirectory($HOME . '/.vim/backup') == 0
    call mkdir($HOME . '/.vim/backup', 'p')
endif
set backupdir=~/.vim/backup//

if exists('+undofile')
    " Change undo directory.
    if isdirectory($HOME . '/.vim/undo') == 0
        call mkdir($HOME . '/.vim/undo', 'p')
    endif
    set undodir=~/.vim/undo//
end

if exists('+shada')
    " Change SHAred DAta path.
    set shada+=n~/.nvim/shada
else
    " Change viminfo path.
    set viminfo+=n~/.vim/viminfo
endif

" I've prefixed these functions with an underscore as I'll
" never want to run them directly.
function! _EchoSwapMessage(message)
    if has("autocmd")
        augroup EchoSwapMessage
            autocmd!
            " Echo the message after entering a file, useful for when
            " we're entering a file (like on SwapExists) and our echo will be
            " eaten.
            autocmd BufWinEnter * echohl WarningMsg
            exec 'autocmd BufWinEnter * echon "\r'.printf("%-60s", a:message).'"'
            autocmd BufWinEnter * echohl NONE

            " Remove these auto commands so that they don't run on entering
            " the next buffer.
            autocmd BufWinEnter * augroup EchoSwapMessage
            autocmd BufWinEnter * autocmd!
            autocmd BufWinEnter * augroup END
        augroup END
    endif
endfunction

function! _HandleSwap(filename)
    " If the swap file is old, delete. If it is new, recover.
    if getftime(v:swapname) < getftime(a:filename)
        let v:swapchoice = 'e'
        call _EchoSwapMessage("Deleted older swapfile.")
    else
        let v:swapchoice = 'r'
        call _EchoSwapMessage("Detected newer swapfile, recovering.")
    endif
endfunc

if has("autocmd")
    augroup AutoSwap
        autocmd!
        autocmd! SwapExists * call _HandleSwap(expand('<afile>:p'))
    augroup END
endif

" Enable keeping track of undo history.
set undofile

" Do not keep track of undo history in temporary files.
augroup vimrc
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
" }}}

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
