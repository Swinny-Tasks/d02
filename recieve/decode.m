function username = decode(bin_msg, username)
  
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
        fprintf(2, 'This is an encrypted message!\n');
        while true
          pswd = input('Enter Password: ', 's');

          % check password
          if (length(pswd) * 8 ) >= length(content) 
            fprintf(2, '\nWRONG PASSWORD\n');
          elseif pswd == decrypt(pswd, content(1, 1:(length(pswd)*8)))
            break;
          else
            fprintf(2, '\nWRONG PASSWORD\n');
          end

        end

        message = decrypt(pswd, content(1, (length(pswd)*8 + 1):end));


      % normal text; store it as well
      case '010'
        message = char_convert(content);
        %TODO add code to save message

      % encrypted text; store it as well
      case '011'
        %TODO add code 

      % load normal text
      case '100'
        %TODO add code

      % load encrypted text
      case '101'
        %TODO add code

    end
    fprintf(2, '%s >> ', username);
    disp(message);
  end
end
