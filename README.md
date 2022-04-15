# Goldfish <>< 
An autocomplete tool in the terminal to help my goldfish brain ...
![screen-gif](./assets/goldfishdemo.gif)

# Dependencies
- [fish shell](https://fishshell.com/) or [zsh](https://zsh.sourceforge.io/), bash is not supported rn
- [fzf](https://github.com/junegunn/fzf)
- [awk](https://man.archlinux.org/man/awk.1p.en) should be installed by default on most linux distribution and Mac OS

# Installation
## Fish
### Create ~/.config/fish/functions/configure_goldfish.fish
```
function configure_goldfish
  # This can be ran in the terminal(no escape char for fish scripting)
  # cat ~/.config/goldfish/goldfish.config | fzf --preview-window="bottom:3:wrap" --preview="echo {} | awk -F ' <>< ' '{print \$2}' | fish_indent --ansi" | awk -F ' <>< ' '{print $2}'

  alias goldfish='cat ~/.config/goldfish/goldfish.config | fzf --preview-window="bottom:3:wrap" --preview="echo {} | awk -F \' <>< \' \'{print \$2}\' | fish_indent --ansi" | awk -F \' <>< \' \'{print $2}\''
  
  # \eg is alt+g, you can change it to anything else you want 
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    bind -M insert \eg fzf_search_goldfish
  else
    bind \eg fzf_search_goldfish
  end
end
```
### Create ~/.config/fish/functions/fzf_search_goldfish.fish
```
function fzf_search_goldfish
    set command (
      goldfish
    )
    commandline --replace -- $command
    commandline --function repaint
end
```
### Add to ~/.config/fish/config.fish
```
configure_goldfish
```
## ZSH
Add to ~/.zshrc
```
alias goldfish=$'cat ~/.config/goldfish/goldfish.config | fzf --preview-window=\'bottom:3:wrap\' --preview="echo {} | awk -F \' <>< \' \'{print $2}\'" | awk -F \' <>< \' \'{print $2}\''

goldfish-widget ()
{
  zle .kill-whole-line
  local selection=$(goldfish)
  BUFFER=$selection
  zle end-of-line
}
zle -N goldfish-widget

# \eg is alt+g, feel free to change it to something else
bindkey '\eg' goldfish-widget
bindkey -M viins '\eg' goldfish-widget
bindkey -M vicmd '\eg' goldfish-widget
bindkey -M emacs '\eg' goldfish-widget
```

# Configuration
Create ~/.config/goldfish/goldfish.config
```
Description <>< Command
Git: Stage All <>< git add -A
Git: Commit <>< git commit -m "{commit message here}"
Git: Show Repo Status <>< git status
```

# Usage
By default `alt+g` will bring up the goldfish pop up in the terminal, this is configured in the shell scripts as `\eg`, replace all occurances with whatever you want! Ctrl should be `\c` in fish and `^` in zsh, but RTFM :stuck_out_tongue_closed_eyes:

# Note
- On mac OS, you might need to set `use alt key as meta key` in your terminal emulator for alt shortcut to work.
