function username = decode(bin_msg, username)
  
  % change name
  if isequal(bin_msg(1, 1:4), '0010')
    username = char_convert(bin_msg(1, 4:end));
    fprintf(2, 'recieving messages from %s\n', username);

  % is command
  elseif  isequal('110', bin_msg(1, 1:3))
    %TODO add code 

  % load command
  elseif  isequal('111', bin_msg(1, 1:3))
    %TODO add code

  else
    header = bin_msg(1, 1:3);
    switch header
      % normal text
      case '000'
        %TODO add code 

      % encrypted text
      case '001'
        right_pass = false;

        fprintf(2, 'This is an encrypted message!\n');
        while ~right_pass
          pswd = input('Enter Password: ', 's');

          % check password
          if pswd == decrypt(pswd, text(1, 4:((length(pswd)*8)+ 3)))
            right_pass = true;
            break;
          end

        end


      % normal text; store it as well
      case '010'
        %TODO add code 

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
    fprintf(2, '[%s] >> %s\n\n', username, message);
  end
end
