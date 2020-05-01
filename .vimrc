" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

filetype plugin on
syntax on
set background=dark
set clipboard=unnamedplus

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
	" call minpac#add('google/vim-maktaba')
	" call minpac#add('google/vim-codefmt')
	" call minpac#add('google/vim-glaive')
	" call minpac#add('lpenz/vim-codefmt-haskell')

	" install coc
	call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

	" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Vim colour theme pack
	call minpac#add('rafi/awesome-vim-colorschemes')

	" vim-polyglot syntax highlighting for various file types and languages
	call minpac#add('sheerun/vim-polyglot')

	" Generate statuslines for tmux.
	call minpac#add('edkolev/tmuxline.vim', {'type': 'opt'})

	" Apply indentation from .editorconfig files.
	call minpac#add('editorconfig/editorconfig-vim')

	" Statusline
    	call minpac#add('itchyny/lightline.vim')
    	call minpac#add('josa42/vim-lightline-coc')

	" Switch to absolute line numbers for buffers that are not selected.
    	call minpac#add('jeffkreeftmeijer/vim-numbertoggle')

	" Hardtime - get learnt
	call minpac#add('takac/vim-hardtime')

	" Focus events & clipboard for tmux
	call minpac#add('roxma/vim-tmux-clipboard')

	" Autocompletion/linting.
    	call minpac#add('w0rp/ale')

	" Easy navigation between vim splits and tmux panes.
    	call minpac#add('christoomey/vim-tmux-navigator')

	" Improvements to netrw.
    	call minpac#add('tpope/vim-vinegar')

	"  Show Git changes in the sign column.
	call minpac#add('mhinz/vim-signify')

	" Vim obsession
	call minpac#add('tpope/vim-obsession')

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

	" Racer completions for rust
	" call minpac#add('racer-rust/vim-racer')
endif

" add awesome vim colour scheme to rtp
set runtimepath+=~/.config/nvim
set runtimepath+=~/.config/nvim/pack/minpac/start/awesome-vim-colorschemes

" Timeout Lengths {{{
" ===============
" This should make pressing ESC more responsive.
" Alternative to `set esckeys` as this breaks sequences in INSERT mode that uses ESC.
" set timeoutlen=250 ttimeoutlen=0
set ttimeoutlen=0
" }}}

set termguicolors
colorscheme jellybeans

" Enable Hardtime by default
let g:hardtime_default_on = 0

" Ale {{{
" ===

" keep the error gutter open at all times
set signcolumn=yes

" Use stable Rust for RLS.
" let g:ale_rust_rls_toolchain = 'stable'

let g:ale_fix_on_save = 1

let g:ale_fixers = {
\   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\   'java': ['google_java_format'],
\   'python': ['black'],
\   'javascript': ['eslint'],
\   'haskell': ['stylish-haskell', 'hlint', 'brittany'],
\   'rust': ['rustfmt'],
\ }

set nofoldenable    " disable folding

" set line numbers to be relative + abs value of current line
set number
set relativenumber

set cursorline

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
nnoremap <Leader>r :so $MYVIMRC<CR>

" copy to system clipboard when in visual mode
map <C-c> "+y<CR>

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
let g:lightline.colorscheme = 'jellybeans'

let g:lightline.active = {
\   'left': [
\       [ 'mode' ],
\       [ 'paste', 'spell', 'gitbranch', 'readonly', 'filename' ]
\   ],
\   'right': [
\       [ 'coc_ok', 'coc_errors', 'coc_warnings',  'coc_status' ],
\       [ 'coc_hint' ],
\       [ 'fileformat', 'fileencoding', 'filetype', 'lineinfo', 'percent' ]
\   ]
\ }

let g:lightline.component_expand = {
\   'coc_warnings'  	: 'lightline#coc#warnings',
\   'coc_errors' 	: 'lightline#coc#errors',
\   'coc_status' 	: 'lightline#coc#status',
\   'coc_ok' 		: 'CocOk',
\   'coc_hint' 		: 'CocHint'
\ }

" Set color to the components:
let g:lightline.component_type = {
\   'coc_warnings' 	: 'warning',
\   'coc_errors' 	: 'error',
\   'coc_status' 	: 'right',
\   'coc_ok' 		: 'left',
\   'coc_hint' 		: 'right'
\ }



let g:lightline.component_function = {
\   'gitbranch' 	: 'fugitive#head',
\   'obsession' 	: 'ObsessionStatus',
\   'readonly' 		: 'LightlineReadonly',
\   'fileformat' 	: 'LightlineFileformat',
\   'filetype' 		: 'LightlineFiletype',
\   'filename' 		: 'LightlineFilename',
\ }

function! CocOk()
  let hints = exists('b:coc_diagnostic_info') ? get(b:coc_diagnostic_info, 'hint', 0) : 0
  return empty(lightline#coc#status()) && hints == 0 ? lightline#coc#ok() : ''
endfunction

function! CocHint()
  let hints = exists('b:coc_diagnostic_info') ? get(b:coc_diagnostic_info, 'hint', 0) : 0
  return empty(lightline#coc#status()) && hints != 0 ? 'H: ' . hints : ''
endfunction

let g:lightline#coc#indicator_ok = 'OK'
let g:lightline#coc#indicator_errors = 'E: '
let g:lightline#coc#indicator_warnings = 'W: '

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

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

function TabName(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

function! s:jumpToTab(line)
    let pair = split(a:line, ' ')
    let cmd = pair[0].'gt'
    execute 'normal' cmd
endfunction

nnoremap <silent> <Leader>t :call fzf#run({
\   'source':  reverse(map(range(1, tabpagenr('$')), 'v:val." "." ".TabName(v:val)')),
\   'sink':    function('<sid>jumpToTab'),
\   'down':    tabpagenr('$') + 2
\ })<CR>

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

" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

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
if exists('*complete_info')
  inoremap <expr><cr> complete_info()["selected"] != "-1" ? "<C-y>" : "<CR>"
else
  imap <expr><cr> pumvisible() ? "<C-y>" : "<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>d <Plug>(coc-diagnostic-info)

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

let g:coc_global_extensions = [
\  'coc-omnisharp',
\  'coc-highlight',
\  'coc-html',
\  'coc-dictionary',
\  'coc-emoji',
\  'coc-tag',
\  'coc-pairs',
\  'coc-java',
\  'coc-json',
\  'coc-rust-analyzer',
\  'coc-yaml',
\ ]
