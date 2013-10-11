# 文字コード
export LANG=ja_JP.UTF-8

# プロンプト
autoload colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '%{${fg[red]}%}(%s %b%{${fg[cyan]}%}%c%u%{${fg[red]}%}) %{$reset_color%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
[%n]$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

PROMPT2='[%n]> ' 

# 補間
[ -d ~/.zsh_fn ] && fpath=($HOME/.zsh_fn $fpath)
autoload -U compinit
compinit -u

# 履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# エディタ
export EDITOR=vi

# キーバインド
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
bindkey '^R' history-incremental-pattern-search-backward

# ビープ音ならなさない
setopt nobeep

# cd
setopt auto_cd
setopt auto_pushd 
setopt pushd_ignore_dups

# 改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# lsと補間にでる一覧の色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

# デフォルトパーミッションの設定
umask 022

# alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias ll='ls -l'

#rbenv rehashの自動化するためにgemコマンドのラッパーを作る
#http://rhysd.hatenablog.com/entry/20120226/1330265121

function gem(){
	$HOME/.rbenv/shims/gem $*
	if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
	then
		rbenv rehash
		rehash
	fi
}

#remove .DS_store from dir & subdir
alias rmds="find . -name '*.DS_Store' -type f -delete"

# bundle 
alias be="bundle exec"
alias bi="bundle install --without=production --path vendor/bundle"

# Marked
# http://markedapp.com/
function mrkd() {
  open -a Marked $1
}


# server
function server() {
  local port="${1:-8000}"
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# iOSシミュレータ起動
function mobile-safari() {
  local VERSION=$1
  local URL=$2
  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app/Contents/MacOS/iPhone\ Simulator -SimulateApplication /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator$VERSION.sdk/Applications/MobileSafari.app/MobileSafari -u $URL
}


# 環境ごとの設定読み込む
[ -f ~/.zshrc_env ] && source ~/.zshrc_env

# 個別設定を読み込む
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
