function username = decode(bin_msg, username)
  c = clock;
  time = [num2str(c(4)), ':' num2str(c(5)), ':', num2str(c(4))];
  print_message  = true;

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
          fprintf("*cannot find file {%s} on the system.*\n",char_convert(char(content)));
          print_message = false;
        end

      % run SIT from memory
      case '100'
        filename = ['files/', char_convert(char(content))];
        print_message = false;
        try
          file = importdata(filename);
          fprintf(2, "LED ACTION: "); disp(file(2));
          sit_compile(char(file(2)));
        catch
          fprintf("*cannot find file {%s} on the system.*\n",char_convert(char(content)));
        end

      % run SIT command
      case '101'
        message = join(["LED ACTION: ", char_convert(char(content))]);
        sit_compile(char_convert(char(content)));

      % manual LED control
      case '111'
        print_message = false;
        % getting LED Name
        if (content(1) == '1')
          LED_name = 'Red';
        else
          LED_name = 'Blue';
        end

        % getting LED number
        LED_num = (str2double(content(2:3)) + 1);

        % getting LED state
        if (content(4) == '1')
          LED_state = 'On';
        else
          LED_state = 'OFF';
        end

        fprintf(2, "Turning %s %d LED %s \n", LED_name, LED_num, LED_state);

        switch(content(1:3))
          case '000' % blue 1
            LED_grid = [str2double(content(4)) 0 0 0 0 0 0 0];
          case '001' % blue 2
            LED_grid = [0 0 str2double(content(4)) 0 0 0 0 0];
          case '010' % blue 3
            LED_grid = [0 0 0 0 0 str2double(content(4)) 0 0];
          case '011' % blue 4
            LED_grid = [0 0 0 0 0 0 0 str2double(content(4))];
          case '100' % red 1
            LED_grid = [0 str2double(content(4)) 0 0 0 0 0 0];
          case '101' % red 2
            LED_grid = [0 0 0 str2double(content(4)) 0 0 0 0];
          case '110' % red 3
            LED_grid = [0 0 0 0 str2double(content(4)) 0 0 0];
          case '111' % red 4
            LED_grid = [0 0 0 0 0 0 str2double(content(4)) 0];
        end
        grid_ctrl(LED_grid);

    end
    if print_message
      fprintf(2, '[%s] %s >> ', time, username);
      disp(message);
    end
  end
end
