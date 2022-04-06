function password = get_password(content)
  fprintf(2, 'This is an encrypted message!\n');
  while true
    password = input('Enter Password: ', 's');

  % check password
  if (length(password) * 8 ) >= length(content) 
    fprintf(2, '\nWRONG PASSWORD\n');
  elseif password == decrypt(password, content(1, 1:(length(password)*8)))
    break;
  else
    fprintf(2, '\nWRONG PASSWORD\n');
  end

  end
end