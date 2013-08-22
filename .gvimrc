"---------------------------------------------------------------------------
" フォントに関する設定
"
set guifont=Osaka-Mono:h16

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
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
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
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

"---------------------------------------------------------------------------
"Powerline
"let g:Powerline_symbols = 'fancy'
"set t_Co=256
"let g:Powerline_symbols = 'compatible'
"set background              =dark
"let g:Powerline_theme       ='solarized256'
"let g:Powerline_colorscheme ='solarized256'

"
"airline
let g:airline_theme = 'landscape'
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_branch_prefix = '⭠ '
let g:airline#extensions#readonly#symbol = '⭤ '
let g:airline_linecolumn_prefix = ''
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#readonly#enabled = 0
"let g:airline_section_b = "%t%( %M%)"
let g:airline_section_b =
      \ '%{airline#extensions#branch#get_head()}' .
      \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
      \ '%{airline#extensions#readonly#get_mark()}' .
      \ '%t%( %M%)'
let g:airline_section_c = ''
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
      \ '%{strlen(&fileformat)?&fileformat:""}'.s:sep.
      \ '%{strlen(&fenc)?&fenc:&enc}'.s:sep.
      \ '%{strlen(&filetype)?&filetype:"no ft"}'
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline_inactive_collapse = 0
function! AirLineForce()
  let g:airline_mode_map.__ = ''
  let w:airline_render_left = 1
  let w:airline_render_right = 1
endfunction
augroup AirLineForce
  autocmd!
  autocmd VimEnter * call add(g:airline_statusline_funcrefs, function('AirLineForce'))
augroup END


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
