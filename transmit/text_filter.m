% extract additional info from the message string
function [extra_info, message] = text_filter(expected, text)
  % extra info would be either password or file name
  if expected == 'encrypt'
      borders = ['[', ']'];
  elseif expected == 'save'
      borders = ['{', '}'];
  end
  starting = find(text == borders(1, 1))
  ending = find(text == borders(1, 2))

  extra_info = text(starting+1, ending -1 );
  message = text(ending + 1, end);

  fprintf('%s\n%s', extra_info, message)
end