" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" ヤンクでクリップボードにコピー
set clipboard+=unnamedplus
" ターミナルエミュレータでzshを起動
set sh=zsh

" 見た目系
" 行番号を表示
set number
" カーソル位置の行数と列を表示
set ruler
" ウィンドウのタイトルを変更
set title
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" onにするとvimからファイルを開くときにリストを表示する
set wildmenu
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライト
syntax on
filetype plugin indent on

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" Tab、バッファ系の操作をsキーに割り当てる 
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

autocmd BufReadPost *.rs setlocal filetype=rust

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" ESCでターミナルモードを抜ける
tnoremap <silent> <ESC> <C-\><C-n>
" -----プラグイン設定-----
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" color scheme
Plug 'tomasr/molokai', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'jacoborus/tender.vim', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'ayu-theme/ayu-vim', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'kristijanhusak/vim-hybrid-material', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'hzchirs/vim-material', {'do': 'cp colors/* ~/.vim/colors/'}
Plug 'srcery-colors/srcery-vim', {'do': 'cp colors/* ~/.vim/colors/'}

" 文法チェック
Plug 'vim-syntastic/syntastic'

" ツリー形式でディレクトリを表示
Plug 'scrooloose/nerdtree'

" For Haskell
Plug 'neovimhaskell/haskell-vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kana/vim-submode'
Plug 'Shougo/unite.vim'
call plug#end()
" -----プラグイン設定end-----

" カラースキーム
set termguicolors     " enable true colors support
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

let g:deoplete#enable_at_startup = 1
let g:syntastic_haskell_checkers = ["hlint"]

" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie-wrapper'], 
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
let g:LanguageClient_hoverPreview = "Never"
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

" 連続入力
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
