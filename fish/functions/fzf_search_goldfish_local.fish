function fzf_search_goldfish_local
    set command (
      goldfish-local
    )
    commandline --replace -- $command
    commandline --function repaint
end
