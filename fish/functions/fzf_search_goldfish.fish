function fzf_search_goldfish
    set command (
      goldfish
    )
    commandline --replace -- $command
    commandline --function repaint
end

