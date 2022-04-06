function username = decode(bin_msg, username)
  c = clock;
  time = [num2str(c(4)), ':' num2str(c(5)), ':', num2str(c(4))];

  % change name
  if isequal(bin_msg(1, 1:4), '0010')
    username = char_convert(bin_msg(1, 5:end));
    fprintf(2, 'now recieving messages from %s\n', username);

  % is command
  elseif  isequal('110', bin_msg(1, 1:3))
    %TODO add code 

  % load command
  elseif  isequal('111', bin_msg(1, 1:3))
    %TODO add code

  else
    header = bin_msg(1, 1:3);
    content = bin_msg(1, 4:end);
    
    switch header
      % normal text
      case '000'    
        message = char_convert(content);

      % encrypted text
      case '001'
       pswd = get_password(content);
       message = decrypt(pswd, content(1, (length(pswd)*8 + 1):end));

      % normal text; store it as well
      case '010'
        file_len = bin2dec(content(1:8));
        file_name = char_convert(content(9:(file_len*8 + 8)));
        message = char_convert(content((9 + file_len*8):end));
        save_sit(username, time, file_name, message);
        fprintf(2, 'saving the message locally in: %s.sit\n', file_name);

      % encrypted text; store it as well
      case '011'
        file_len = bin2dec(content(1:8));
        file_name = char_convert(content(9:(file_len*8 + 8)));
        pswd = get_password(content((9 + file_len*8):end));
        message = decrypt(pswd, content(1, (9 + 8*(file_len + length(pswd))):end));
        save_sit(username, time, file_name, message);
        fprintf(2, 'saving the message locally in: %s.sit\n', file_name);

      % load normal text
      case '100'
        %TODO add code

      % load encrypted text
      case '101'
        %TODO add code

    end
    fprintf(2, '[%s] %s >> ', time, username);
    disp(message);
  end
end
