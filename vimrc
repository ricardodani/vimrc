" .vimrc
" Author: Ricardo Dani
" Based on spf-13

" Basics
    set nocompatible        " Must be first line
    filetype off            " required
    set nospell

" Vundle.vim
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        let g:consolidated_directory = $HOME . '/.vim/'
            let common_dir = g:consolidated_directory . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }
 " General
     filetype plugin indent on   " Automatically detect file types.
     syntax on                   " Syntax highlighting
     set mouse=a                 " Automatically enable mouse usage
     set mousehide               " Hide the mouse cursor while typing
     scriptencoding utf-8
     if has('clipboard')
         if has('unnamedplus')  " When possible use + register for copy-paste
             set clipboard=unnamed,unnamedplus
         else         " On mac and Windows, use * register for copy-paste
             set clipboard=unnamed
         endif
     endif
     " swithces to same buffer path
     autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
     set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
     set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
     set virtualedit=onemore             " Allow for cursor beyond last character
     set history=1000                    " Store a ton of history (default is 20)
     set hidden                          " Allow buffer switching without saving
     set iskeyword-=.                    " '.' is an end of word designator
     set iskeyword-=#                    " '#' is an end of word designator
     set iskeyword-=-                    " '-' is an end of word designator
     " Instead of reverting the cursor to the last position in the buffer, we
     " set it to the first line when editing a git commit message
     au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
     " Restore cursor to file position in previous editing session
     function! ResCur()
         if line("'\"") <= line("$")
             silent! normal! g`"
             return 1
         endif
     endfunction
     augroup resCur
         autocmd!
         autocmd BufWinEnter * call ResCur()
     augroup END

" Backup
     set backup                  " Backups are nice ...
     if has('persistent_undo')
         set undofile                " So is persistent undo ...
         set undolevels=1000         " Maximum number of changes that can be undone
         set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
     endif
" UI
     set tabpagemax=15               " Only show 15 tabs
     set showmode                    " Display the current mode
     set cursorline                  " Highlight current line
     highlight clear SignColumn      " SignColumn should match background
     highlight clear LineNr          " Current line number row will have same background color in relative mode
     set backspace=indent,eol,start  " Backspace for dummies
     set linespace=0                 " No extra spaces between rows
     set number                      " Line numbers on
     set showmatch                   " Show matching brackets/parenthesis
     set incsearch                   " Find as you type search
     set hlsearch                    " Highlight search terms
     set winminheight=0              " Windows can be 0 line high
     set ignorecase                  " Case insensitive search
     set smartcase                   " Case sensitive when uc present
     set wildmenu                    " Show list instead of just completing
     set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
     set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
     set scrolljump=5                " Lines to scroll when cursor leaves screen
     set scrolloff=3                 " Minimum lines to keep above and below cursor
     set foldenable                  " Auto fold code
     set list
     set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
     set nowrap                      " Do not wrap long lines
     set autoindent                  " Indent at the same level of the previous line
     set shiftwidth=4                " Use indents of 4 spaces
     set expandtab                   " Tabs are spaces, not tabs
     set tabstop=4                   " An indentation every four columns
     set softtabstop=4               " Let backspace delete indent
     set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
     set splitright                  " Puts new vsplit windows to the right of the current
     set splitbelow                  " Puts new split windows to the bottom of the current
     set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
     let mapleader = ','
     let maplocalleader = '_'
     " toggle search highlight
     nmap <silent> <leader>/ :set invhlsearch<CR>
     " Visual shifting (does not exit Visual mode)
     vnoremap < <gv
     vnoremap > >gv
     " vnoremap . :normal .<CR>
     map <leader>ew :e %%
     map <leader>es :sp %%
     map <leader>ev :vsp %%
     map <leader>et :tabe %%
 
 " Configuring plugins
     let g:airline_powerline_fonts=1
     let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
     " NERDTree
     map <C-e> <plug>NERDTreeTabsToggle<CR>
     map <leader>e :NERDTreeFind<CR>
     nmap <leader>nt :NERDTreeFind<CR>
 
     let NERDTreeShowBookmarks=1
     let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
     let NERDTreeChDirMode=0
     let NERDTreeQuitOnOpen=1
     let NERDTreeMouseMode=2
     let NERDTreeShowHidden=1
     let NERDTreeKeepTreeInNewTab=1
     let g:nerdtree_tabs_open_on_gui_startup=0
     " pymode
     let g:pymode_lint_checkers = ['pyflakes']
     let g:pymode_trim_whitespaces = 0
     let g:pymode_rope = 0
     let g:pymode_folding = 0
     " Ctrlp
     let g:ctrlp_map = '<c-p>'
     let g:ctrlp_cmd = 'CtrlP'
     let g:ctrlp_working_path_mode = 'ra'
     let g:ctrlp_custom_ignore = {
         \ 'dir':  '\.git$\|\.hg$\|\.svn$',
         \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
     let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
     let g:ctrlp_user_command = {
         \ 'types': {
             \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
             \ 2: ['.hg', 'hg --cwd %s locate -I .'],
         \ },
         \ 'fallback': s:ctrlp_fallback
     \ }
    " GUI
     if has('gui_running')
         set guioptions-=m
         set guioptions-=T
         set guioptions-=r
         set lines=40
         set bg=dark
         set guifont=Space\ Mono\ for\ Powerline\ 10
         colorscheme solarized
         let g:airline_theme = 'solarized'
     endif
