% looks at the head of a message to confirm if its a command
function is_it = iscmd(cmd, text)
  is_it = false;
  pass_save = false;  % if the cmd is related to password or save function
  for_host = false;   % if the cmd is for host operation
  host_confirm = false; % would confirm if the command is infact in right syntax

  switch cmd
    case 'encrypt'
      to_look = ['[', ']'];
      to_avoid = ['{', '}'];
      pass_save = true;

    case 'saveL'
      to_look = ['{', '}'];
      to_avoid = ['[', ']'];
      pass_save = true;

    case 'saveH'
      to_look = ['{', '}'];
      to_avoid = ['[', ']'];
      pass_save = true; for_host = true;

    otherwise
      if length(text) > length(cmd)
        if text(2:(length(cmd)+1)) == cmd
          is_it = true;
        end
      end
  end

  if pass_save
      % checks if the action is for host
      if text(2) == '*'
          search_index = 3;
          host_confirm = true;
      else 
          search_index = 2;
      end

      % checks if what we're looking for is right after !
      if text(search_index) == to_look(1, 1)
        if ~isempty(find(text == to_look(1, 2), 1))
            is_it = true;
        end

      % checks if some other operations are also involved
      elseif text(search_index) == to_avoid(1, 1)
        save_until = find(text == to_avoid(1, 2));
        if ~isempty(save_until)
          if text(save_until + 1) == to_look(1, 1)
            if ~isempty(find(text == to_avoid(1, 2), 1))
              is_it = true;
            end
          end
        end

      end

      if for_host
          is_it = is_it * host_confirm;
      end
  end

end
