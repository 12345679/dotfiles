bindkey -v

# 左プロンプト
#PROMPT='[%n@%m %~]${WINDOW:+"[$WINDOW]"}%# '
case "$TERM" in
    xterm*|kterm*|rxvt*)
    PROMPT=$(print "%B%{\e[34m%}%m:%(5~,%-2~/.../%2~,%~)%{\e[33m%}\n%n%# %b")
    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT") # title bar
    ;;

    # tmux or screen
    # 画面を分割することが多いので、小さくなりやすい
    # でも色変えるだけにしとこう
    *)
    PROMPT='%m:%c%# '
    PROMPT=$(print "%B%{\e[32m%}%m:%(5~,%-2~/.../%2~,%~)%{\e[33m%}\n%n%# %b")
    ;;
esac

if [ $UID = 0 ]; then             # root のプロンプトは特別（赤色）
    PROMPT=$(print "%B%{\e[31m%}%m:%(5~,%-2~/.../%2~,%~)%{\e[33m%}\n%n%# %b")
    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT") # title bar
fi
# 右側のプロンプト
# R＝前のプロセスのReturnコード、L＝SHLVL、H=ヒストリ番号、時刻
# %* : 時刻＋秒
# %T : ２４時間表記の時刻
# %t : １２時間表記の時刻
#RPROMPT=$(print "R%?,L%L,H%h %U%*%u")

function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    RPROMPT="--NORMAL--"
    ;;
    main|viins)
    RPROMPT=" "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char



alias la='ls -l -aF --show-control-char --color=always'
alias ls='ls --show-control-char --color=always'
alias ll='ls -l --show-control-char --color=always'
alias l.='ls -d .[a-zA-Z]* --color=always'
alias svm='~/githubs/svm/svm'

export SCALA_HOME=~/.svm/current/rt
export PATH=$SCALA_HOME/bin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && rvm_prefix="${HOME}/.";source "$HOME/.rvm/scripts/rvm"

# -------------------------------------------------
# http://memo.officebrook.net/20090205.html
# ↑あんまりかも
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
autoload -Uz history-search-end
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する) 
bindkey "^[[Z" reverse-menu-complete

function google() {
  local str opt
  if [ $# != 0 ]; then
    for i in $*; do
      str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
  fi
  w3m http://www.google.co.jp/$opt
}
# 'google ほげほげ'ですぐに検索。

function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup

source .aliases
