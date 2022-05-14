function username = decode(bin_msg, username)
  c = clock;
  time = [num2str(c(4)), ':' num2str(c(5)), ':', num2str(c(4))];

  % change name
  if isequal(bin_msg(1, 1:4), '0010')
    username = char_convert(bin_msg(1, 5:end));
    fprintf(2, '\nnow recieving messages from %s\n\n', username);

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

      % normal text; display and store
      case '010'
        file_len = bin2dec(content(1:8));
        file_name = char_convert(content(9:(file_len*8 + 8)));
        message = char_convert(content((9 + file_len*8):end));
        save_txt(username, time, file_name, message);
        fprintf(2, 'saving the message locally in: files/%s\n', file_name);

      % load plain file from memory
      case '011'
        filename = ['files/', char_convert(char(content))];
        try
          file = importdata(filename);
          message = string(file(2));
        catch
          message = join(["*cannot find file {", char_convert(char(content)), "} on the system.*"]);
        end

      % run SIT from memory
      case '100'
        filename = ['files/', char_convert(char(content))];
        try
          file = importdata(filename);
          message = ["LED ACTION: ", string(file(2))];
          sit_compile(char(file(2)));
        catch
          message = join(["*cannot find file {", char_convert(char(content)), "} on the system.*"]);
        end

      % run SIT command
      case '101'
        message = join(["LED ACTION: ", char_convert(char(content))]);
        sit_compile(char_convert(char(content)));

    end
    fprintf(2, '[%s] %s >> ', time, username);
    disp(message);
  end
end
