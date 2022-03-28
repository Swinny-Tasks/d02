% looks at the head of a message to confirm if its a command
function is_it = iscmd(cmd, text)
  is_it = false;
  pass_save = false;

  switch cmd
    case 'encrypt'
      to_look = ['[', ']'];
      to_avoid = ['{', '}'];
      pass_save = true;

    case 'save'
      to_look = ['{', '}'];
      to_avoid = ['[', ']'];
      pass_save = true;

    otherwise
      if length(text) > length(cmd)
        if text(2:(length(cmd)+1)) == cmd
          is_it = true;
        end
      end
  end

  if pass_save
      if text(2) == to_look(1, 1)
        if ~isempty(find(text == to_look(1, 2), 1))
            is_it = true;
        end
      
      elseif text(2) == to_avoid(1, 1)
        save_until = find(text == to_avoid(1, 2));
        if ~isempty(save_until)
          if text(save_until + 1) == to_look(1, 1)
            if ~isempty(find(text == to_avoid(1, 2), 1))
              is_it = true;
            end
          end
        end

      end 
  end

end
