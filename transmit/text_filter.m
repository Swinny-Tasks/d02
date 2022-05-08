% extract additional info from the message string
function [extra_info, message] = text_filter(expected, text)
  % extra info would be either password or file name
  if isequal(expected, 'encrypt')
    borders = ['[', ']'];
  elseif isequal(expected, 'save')
    borders = ['{', '}'];
  elseif isequal(expected, 'load')
    borders = ['(', ')'];
  elseif isequal(expected, 'run')
    borders = ['<', '>'];
  end

  starting = find(text == borders(1, 1));
  ending = find(text == borders(1, 2));

  extra_info = text(1, (starting+1):(ending-1) );
  message = text(1, (ending+1):end);

end
