"---------------------------------------------------------------------------
let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ 'mode_map': { 'c': 'NORMAL' },
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
	\ },
	\ 'component_func': {
	\   'modified': 'MyModified',
	\   'readonly': 'MyReadonly',
	\   'fugitive': 'MyFugitive',
	\   'filename': 'MyFilename',
	\   'fileformat': 'MyFileformat',
	\   'filetype': 'MyFiletype',
	\   'fileencoding': 'MyFileencoding',
	\   'mode': 'MyMode',
	\ },
	\ 'separator': { 'left': '⮀', 'right': '⮂' },
	\ 'subseparator': { 'left': '⮁', 'right': '⮃' }
	\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction
function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') : 
        \ '' != expand('%t') ? expand('%t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
  return &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && len(fugitive#head()) ? '⭠ '.fugitive#head() : ''
endfunction
function! MyFileformat()
  return winwidth('.') > 60 ? &fileformat : ''
endfunction
function! MyFiletype()
  return winwidth('.') > 60 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileencoding()
  return winwidth('.') > 60 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction


"---------------------------------------------------------------------------
" フォントに関する設定
"
set guifont=Osaka-Mono:h18

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif


"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a
"
"---------------------------------------------------------------------------
"カラースキームと透明度の設定
"
colorscheme wombat
set background=dark
if has('gui_macvim')
  set transparency=10
endif

"---------------------------------------------------------------------------
"全画面
"

"if has("gui_running")
"    autocmd BufEnter * macaction performZoom:
"endif

"起動時に最大化
if has("gui_running")
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"
" ウインドウの幅
set columns=80
" ウインドウの高さ
set lines=25
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" ルーラーを表示 (noruler:非表示)
set ruler
" Highlighting the current line & column in VIM
set cursorline
:hi clear CursorLine
:hi CursorLine gui=underline guifg=NONE guibg=NONE
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
highlight CursorLine gui=underline guifg=NONE guibg=NONE
