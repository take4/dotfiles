"Vi互換モードオフ
set nocompatible
filetype off

"neobundle設定
if has('vim_starting')
    set runtimepath+=~/.vim/.bundle/neobundle.vim
    call neobundle#rc('~/.vim/.bundle/')
endif

"導入プラグイン
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'vim-scripts/Align'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'othree/eregex.vim'
NeoBundle 'tyru/open-browser.vim'

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

"表示設定 
syntax on
colorscheme desert
set number
set ruler
set hidden
set wildmenu
set showcmd
set confirm
set hlsearch "検索語を強調表示
set visualbell
set laststatus=2 "ステータスラインを常に表示
set cmdheight=2 "コマンドラインの高さを2行に
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する

"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"検索設定
set ignorecase "大文字・小文字を区別しない
set smartcase "混在時は区別する
set wrapscan "先頭へループ

"編集設定
set encoding=utf-8
set autoindent
set backspace=indent,eol,start "オートインデント、改行、インサートモード開始直後にバックスペースキーで削除
set tabstop=4
set shiftwidth=4
set expandtab "タブの代わりに空白文字を挿入する
set nobackup "バックアップをとらない
set noswapfile "スワップファイルを作らない

"カーソルを自動的に()の中へ
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
imap // /<Left>
imap /// ///<Left>

"-------------------------
"neocomplcache
"-------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
\ 'default' : '',
\ 'vimshell' : $HOME.'/.vimshell_hist',
\ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><silent> <CR> <SID>my_cr_function()
function! s:my_cr_function()
return pumvisible() ? neocomplcache#close_popup() . "\<CR>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



"-------------------------
"quickrun
"-------------------------
nmap <Leader>r <Plug>(quickrun)
let g:quickrun_config = {'*': {'split': ''}}
set splitbelow
set splitright

"-------------------------
"Unite
"-------------------------
"入力モードで開始
let g:unite_enable_start_insert=0
"バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
"ファイル一覧
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
"最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
"レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
"ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
"全部
noremap <C-U><C-A> :Unite UniteWithBufferDir -buffer-name=files buffer
"ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"マッピング
nnoremap <Esc><Esc> :nohlsearch<CR> "検索結果ハイライトをリセット
