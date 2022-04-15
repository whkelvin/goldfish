alias goldfish=$'cat ~/.config/goldfish/goldfish.config | fzf --preview-window=\'bottom:3:wrap\' --preview="echo {} | awk -F \' <>< \' \'{print $2}\'" | awk -F \' <>< \' \'{print $2}\''

goldfish-widget ()
{
  zle .kill-whole-line
  local selection=$(goldfish)
  #zle -U $selection
  BUFFER=$selection
  zle end-of-line
}
zle -N goldfish-widget

bindkey '\eg' goldfish-widget
bindkey -M viins '\eg' goldfish-widget
bindkey -M vicmd '\eg' goldfish-widget
bindkey -M emacs '\eg' goldfish-widget

