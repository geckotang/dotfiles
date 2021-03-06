let mapleader = ","
" ,のデフォルトの機能は、\で使えるように退避
noremap \  ,
"---------------------------------------------------------------------------
" lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'gitgutter', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'gitgutter': 'MyGitGutter'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

"---------------------------------------------------------------------------
" クリップボードに関する設定
set clipboard=unnamed,autoselect
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
set tabstop=2
" タブ幅
set softtabstop=2
" タブを挿入するときの幅
set shiftwidth=2
" タブをスペースに展開しない (expandtab:展開する)
set expandtab
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
set listchars=tab:▸\ ,extends:<,precedes:>,trail:-,eol:$
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
"set backupdir=$HOME/vimbackup
"set directory=$HOME/vimbackup
set nobackup
set noswapfile

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

"エスケープキー
inoremap <C-j> <esc>
vnoremap <C-j> <esc>

"保存
nnoremap <Space>w :<C-u>write<CR>

"終了
nnoremap <Space>q :<C-u>quit<CR>

" Moving selection
xmap <C-k> :mo'<-- <CR> gv
xmap <C-j> :mo'>+ <CR> gv
 
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
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>:let &transparency = 10<Cr><C-l>
 
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
let g:user_zen_expandabbr_key = '<C-e>'
let g:user_emmet_leader_key = '<c-e>'

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
set fileencodings=iso-2022-jp,utf-8,sjis,cp932,euc-jp,default,latin
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

"---------------------------------------------------------------------------
"neosnippet

" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '~/dotfiles/.vim/snippets'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif



"---------------------------------------------------------------------------
" IndentGuide
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup=1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"---------------------------------------------------------------------------
" Quickrun
" http://blog.glidenote.com/blog/2013/01/10/vim-quickrun-marked/
let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'outputter' : 'null',
      \ 'command'   : 'open',
      \ 'cmdopt'    : '-a',
      \ 'args'      : 'Marked',
      \ 'exec'      : '%c %o %a %s',
      \ }

"---------------------------------------------------------------------------
" spell check
set spelllang+=cjk
set spell

"---------------------------------------------------------------------------
" Filetype
au BufNewFile,BufRead,BufReadPre *.inc set filetype=html
au BufNewFile,BufRead,BufReadPre *.{md,mdwn,mkd,mkdn,mark*,text,txt} set filetype=markdown
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
au BufRead,BufNewFile,BufReadPre *.jade   set filetype=jade
au BufRead,BufNewFile,BufReadPre *.styl   set filetype=sass
au BufRead,BufNewFile,BufReadPre *.{handlebars,hbs} set filetype=html syntax=html
autocmd FileType markdown hi! def link markdownItalic LineNr

"---------------------------------------------------------------------------
" Vundle
set nocompatible
set rtp+=~/.vim/vundle.git/
call vundle#rc()
" original repos on github
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'mattn/emmet-vim'
Bundle 'itchyny/landscape.vim'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'kchmck/vim-coffee-script'

"カラースキーム
Bundle 'w0ng/vim-hybrid'
Bundle 'jellybeans.vim'
Bundle 'git@github.com:tomasr/molokai.git'
Bundle 'git@github.com:hail2u/h2u_colorscheme.git'
Bundle 'vim-scripts/moria'
Bundle 'endel/vim-github-colorscheme'

"gitのHEADからの差分を表示
Bundle 'airblade/vim-gitgutter'
let g:gitgutter_sign_added = '✚ '
let g:gitgutter_sign_modified = '➜ '
let g:gitgutter_sign_removed = '✘ '
let g:gitgutter_max_signs = 1000
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

"Syntax
Bundle "pangloss/vim-javascript"
Bundle 'teramako/jscomplete-vim'
Bundle 'JulesWang/css.vim'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'hokaccha/vim-html5validator'
Bundle 'digitaltoad/vim-jade'
Bundle 'vim-scripts/vim-stylus'
Bundle 'mustache/vim-mustache-handlebars'
let g:mustache_abbreviations = 1

"Easymotion
Bundle 'haya14busa/vim-easymotion'
" デフォルトのキーバインドを解除
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
nmap e <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_startofline=0
nmap s <Plug>(easymotion-s)
vmap s <Plug>(easymotion-s)
omap z <Plug>(easymotion-s) 
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)

"Calendar.vim
Bundle 'itchyny/calendar.vim'
let g:calendar_views = [ 'year', 'month', 'day_3', 'clock' ]
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
filetype plugin indent on


"---------------------------------------------------------------------------
" Markdown
Bundle 'godlygeek/tabular'
Bundle 'joker1007/vim-markdown-quote-syntax'
Bundle 'rcmdnk/vim-markdown'
let g:vim_markdown_liquid=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_math=1
let g:markdown_quote_syntax_filetypes = {
        \ "coffee" : {
        \   "start" : "coffee",
        \},
        \ "html" : {
        \   "start" : "html",
        \},
        \ "scss" : {
        \   "start" : "scss",
        \},
        \ "css" : {
        \   "start" : "css",
        \},
  \}
hi link htmlItalic LineNr
hi link htmlBold WarningMsg
hi link htmlBoldItalic ErrorMsg

Bundle 'gosukiwi/vim-atom-dark'
Bundle 'vim-scripts/BusyBee'

"---------------------------------------------------------------------------
" CSS
Bundle 'rstacruz/vim-hyperstyle'

"---------------------------------------------------------------------------
" Check Syntax
Bundle 'scrooloose/syntastic'
let g:syntastic_mode_map = {
\ "mode" : "active",
\ "active_filetypes" : ["javascript", "json"],
\}
Bundle 'wakatime/vim-wakatime'

"---------------------------------------------------------------------------
" Memo App
Bundle 'glidenote/memolist.vim'
let g:memolist_path = "/Users/geckotang/Dropbox/Memolist"
" suffix type (default markdown)
let g:memolist_memo_suffix = "md"
" date format (default %Y-%m-%d %H:%M)
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
" tags prompt (default 0)
let g:memolist_prompt_tags = 1
" categories prompt (default 0)
let g:memolist_prompt_categories = 1
" use qfixgrep (default 0)
let g:memolist_qfixgrep = 0
" use vimfler (default 0)
let g:memolist_vimfiler = 0
" remove filename prefix (default 0)
let g:memolist_filename_prefix_none = 0
" use unite (default 0)
let g:memolist_unite = 0
" use arbitrary unite source (default is 'file')
let g:memolist_unite_source = "file"
" use arbitrary unite option (default is empty)
"let g:memolist_unite_option = "-auto-preview -start-insert"
" use various Ex commands (default '')
"let g:memolist_ex_cmd = 'CtrlP'
let g:memolist_ex_cmd = 'NERDTree'
map <Space>mn  :MemoNew<CR>
map <Space>ml  :MemoList<CR>
map <Space>mg  :MemoGrep<CR>
nmap mf  :FufFile <C-r>=expand(g:memolist_path."/")<CR><CR>
