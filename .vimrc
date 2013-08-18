"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" インクリメンタルサーチ
set incsearch
 
"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=8
" タブ幅
set softtabstop=8
" タブを挿入するときの幅
set shiftwidth=8
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:>-,extends:<,precedes:>,trail:-,eol:$
" 全角スペース・行末のスペース・タブの可視化
if has("syntax")
    syntax on
   " PODバグ対策
    syn sync fromstart
    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif
" 長い行を折り返して表示 (nowrap:折り返さない)
set nowrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)
 
" delete buffer but splitted window remains there
command! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn
command! FKwbd let kwbd_bn= bufnr("%")|enew|exe "bdel! ".kwbd_bn|unlet kwbd_bn


"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set backupdir=$HOME/vimbackup
set directory=$HOME/vimbackup

"---------------------------------------------------------------------------
" キーマッピング
 
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <C-Up> 5k
nnoremap <C-Down> 5j
 
noremap <S-Up> v<Up>
noremap <S-Down> v<Down>
noremap <S-Left> v<Left>
noremap <S-Right> v<Right>
 
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <Up> v<Up>
vnoremap <Down> v<Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
vnoremap <Left> v<Left>
vnoremap <Right> v<Right>
 
"nnoremap <tab> f=2l
"nnoremap <s-tab> 2F=2l
 
" Save the current buffer and execute the Tortoise SVN interface's diff program
"nnoremap <silent> <leader>cc :w<CR>:silent !"C:\Progra~1\TortoiseSVN\bin\TortoiseProc.exe /command:commit  /path:"%" /notempfile /closeonend:1"<CR>
 
" Tabs
nnoremap <Space>t t
nnoremap <Space>T T
nnoremap t <Nop>
nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tk :<C-u>tabclose<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>
 
" Map double-tap Esc to clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
 
" very magic
nnoremap / /\v
cnoremap s/ s/\v
cnoremap %s/ %s/\v
 
"Fuf setting
nnoremap <silent> <space>fb :FufBuffer!<CR>
nnoremap <silent> <space>ff :FufFile! <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> <space>fd :FufDir! <C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]<CR><CR>
nnoremap <silent> <space>fm :FufMruFile<CR>
nnoremap <silent> <Space>fc :FufRenewCache<CR>
autocmd FileType fuf nmap <C-c> <ESC>
let g:fuf_patternSeparator = ' '
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
let g:fuf_mrufile_maxItem = 100
let g:fuf_enumeratingLimit = 20
let g:fuf_file_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
 
" zencoding setting 
let g:user_zen_expandabbr_key = '<C-d>'


" ---------------------------------------------------------------------------
" 編集関連
 
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"---------------------------------------------------------------------------
" F5でリロード
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    execute 'source ' . a:file
  endif
  echo 'Reloaded vimrc and gvimrc and ' . a:file . '.'
endfunction
nnoremap <F5> <Esc>:<C-u>source $MYVIMRC<CR> :source $MYGVIMRC<CR> :call SourceIfExists($FTPLUGIN .'\'. &filetype . '.vim')<CR>

"---------------------------------------------------------------------------
" foldの設定
set foldmethod=syntax
set foldlevel=1
set foldnestmax=2
 
augroup foldmethod-syntax
  autocmd!
  autocmd InsertEnter * if &l:foldmethod ==# 'syntax'
  \                   |   setlocal foldmethod=manual
  \                   | endif
  autocmd InsertLeave * if &l:foldmethod ==# 'manual'
  \                   |   setlocal foldmethod=syntax
  \                   | endif
augroup END


"---------------------------------------------------------------------------
" ファイル設定関連
 
" fileencode を設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin
" filetype を検出
filetype on
 
"---------------------------------------------------------------------------
"ステータスラインの設定
set statusline=%{expand('%:p:t')}\ %<\(%{SnipMid(expand('%:p:h'),80-len(expand('%:p:t')),'...')}\)%=\ %m%r%y%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%3l,%3c]
 
function! SnipMid(str, len, mask)
  if a:len >= len(a:str)
    return a:str
  elseif a:len <= len(a:mask)
    return a:mask
  endif
 
  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head
 
  return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction


"---------------------------------------------------------------------------
"Project.vim
:let g:proj_flags = "imstc"
:nmap <silent> <space>tp <Plug>ToggleProject
:nmap <silent> <space>op :Project<CR>
 
 
"---------------------------------------------------------------------------
"neocomplcacheによる補完 
 
let g:neocomplcache_enable_at_startup = 1
if !exists("g:neosnippet#snippets_directory")
    let g:neosnippet#snippets_directory=""
endif
let g:neosnippet#snippets_directory = $VIM.'\vim73\snippets'
command! -nargs=* Es NeoComplCacheEditSnippets
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif


"---------------------------------------------------------------------------
" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()
" original repos on github
Bundle 'Shougo/neocomplcache'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'mattn/zencoding-vim'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
filetype plugin indent on
