"Vi互換モードオフ
set nocompatible
filetype off

"neobundle設定
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

"導入プラグイン
NeoBundle 'Shougo/vimproc', {
    \'build' : {
    \   'windows' : 'make -f make_mingw32.mak',
    \   'cygwin' : 'make -f make_cygwin.mak',
    \   'mac' : 'make -f make_mac.mak',
    \   'unix' : 'make -f make_unix.mak',
    \   },
    \}
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'vim-scripts/Align'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'othree/eregex.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-rails'
NeoBundle 'nathanaelkane/vim-indent-guides'

call neobundle#end()

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

NeoBundleCheck

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
set cursorline

"検索設定
set ignorecase "大文字・小文字を区別しない
set smartcase "混在時は区別する
set wrapscan "先頭へループ

"編集設定
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,sjis,cp932
set autoindent
set smartindent
set backspace=indent,eol,start "オートインデント、改行、インサートモード開始直後にバックスペースキーで削除
"インデント幅 基本は2とし、その他は別途設定する。
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround
"au FileType perl setlocal shiftwidth=2 tabstop=2 softtabstop=2
set expandtab "タブの代わりに空白文字を挿入する
set nobackup "バックアップをとらない
set noswapfile "スワップファイルを作らない

"不可視文字表示設定
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
match JpSpace /　/

"カーソルを自動的に()の中へ
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
imap %% %%<Left>

"対応括弧に<>を追加
set matchpairs& matchpairs+=<:>

"vimrcオープンと再読込
nnoremap <F7> :<C-u>edit ~/.vimrc<CR>
nnoremap <F8> :<C-u>source ~/.vimrc<CR>

"Shift+矢印でウィンドウサイズを変更
nnoremap <S-Left> <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up> <C-w>-<CR>
nnoremap <S-Down> <C-w>+<CR>

"入力モード中Ctrl+jでEsc
inoremap <C-j> <Esc>

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
" let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
" let g:neocomplcache_enable_underbar_completion = 1
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
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
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
"grep
noremap <C-U><C-G> :Unite grep<CR>

"ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

"ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

"ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"unite-grep設定
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'

"マッピング
nnoremap <Esc><Esc> :nohlsearch<CR> "検索結果ハイライトをリセット
nmap gW <Plug>(openbrowser-open)

"-------------------------
"smartchr
"-------------------------
"inoremap <expr> = smartchr#loop('=', ' = ', ' == ')
inoremap <expr> , smartchr#loop(',', ', ', ' => ', '->')

"-------------------------
"vimfiler
"-------------------------
"セーフモード無効
let g:vimfiler_safe_mode_by_default = 0
"vimfilerをデフォルトに設定
let g:vimfiler_as_default_explorer = 1
"現在開いているバッファをIDE風に開く
nnoremap <F2> :VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>

"-------------------------
"NeoSnippet
"-------------------------
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"-------------------------
"syntastic
"-------------------------
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_javascript_checker = 'jshint'

"-------------------------
"easy-motion
"-------------------------
let g:EasyMotion_leader_key = "'"
let g:EasyMotion_grouping=1

"-------------------------
"Indent Guides
"-------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
