% looks at the head of a message to confirm if its a command
function command = iscmd(cmd, text)
  look = '';

  switch cmd
    case 'encrypt'
      look = ['[', ']'];
      index = 2;

    case 'saveL'
      look = ['{', '}'];
      index = 2;

    case 'runL'
      look = ['<', '>'];
      index = 2;

    case 'loadL'
      look = ['(', ')'];
      index = 2;

    case 'saveH'
      look = ['*{', '}'];
      index = 2:3;

    case 'runH'
      look = ['*<', '>'];
      index = 2:3;

    case 'loadH'
      look = ['*(', ')'];
      index = 2:3;

    otherwise % for commands like !exit, !clc, !name
      command = false;
      if length(text) > length(cmd)
        if text(2:(length(cmd)+1)) == cmd
          command = true;
        end
      end
  end

  if ~isempty(look)
    command = isequal(text(index), look(1)) && contains(text, look(2));
  end
end
