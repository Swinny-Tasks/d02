clc; close all; clear;
disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');

% variable declaration
username = 'user';
preamble = '11101110111';
postamble = '00011111110';

% text interface
while true
  fprintf(2, '\n[%s] $', username);
  entered_text = input(' ', 's');
  extra = ''; % could contain other extra info such as password or filename
  header = ''; % would be filled depending on different conditions

  % if empty input
  if size(entered_text) == 0
    continue;

  % check if possible command
  elseif (entered_text(1) == '!' && length(entered_text) > 1)

    % cmd: encrypt message
    if iscmd('encrypt', entered_text)
      header = '001';
      [pass, message] = text_filter('encrypt', entered_text);
      
      msg_bin = ascii_convert(encrypt(message, pass));
      extra = ascii_convert(encrypt(pass, pass));      
      clear message pass; % clearing no longer needed vars

    % cmd: save message/SIT in Host memory
    elseif iscmd('saveH', entered_text)
      header = '010';
      [file_name, message] = text_filter('save', entered_text);
      
      if length(file_name) > 255
          fprintf(2, "FILE NAME SHOULD BE SMALLER THAN 255 CHARACTERS")
          continue;
      else
          file_len_bin = dec2bin(length(file_name));
          while length(file_len_bin) ~= 8
              file_len_bin = ['0', file_len_bin];
          end
      end
      extra = [file_len_bin, ascii_convert(file_name)];
      msg_bin = ascii_convert(message);
      clear message file_len_bin;


    % cmd: save message/SIT in Local memory
    elseif iscmd('saveL', entered_text)
      [file_name, message] = text_filter('save', entered_text);
      
      if length(file_name) > 255
          fprintf(2, "FILE NAME SHOULD BE SMALLER THAN 255 CHARACTERS")
          continue;
      end
      save_content(username, file_name, message);
      fprintf(2, 'message saved!');
      clear message file_len_bin;


    % cmd: load plain file from Host memory
    elseif iscmd('loadH', entered_text)
      header = '011';
      [file_name, buffer] = text_filter('load', entered_text);
      clear buffer; % dont need this information
      msg_bin = ascii_convert(file_name);


    % cmd: Load plain file from Local memory
    elseif iscmd('loadL', entered_text)
      header = '000';
      [file_name, buffer] = text_filter('load', entered_text);
      clear buffer; % doesn't matter what user types here
      
      try
        message = importdata(['files\', file_name]);
        msg_bin = ascii_convert(char(message(2)));
        clear file_name;
      catch
        header = '';
        fprintf(2, 'INVALID FILE\n');
      end

    % cmd: run SIT from Host memory
    elseif iscmd('runH', entered_text)
      header = '100';
      [sit_name, buffer] = text_filter('run', entered_text);
      clear buffer; % dont need this information
      msg_bin = ascii_convert(sit_name);

      
    % cmd: run SIT from Local memory
    elseif iscmd('runL', entered_text)
      header = '101';
      [sit_name, buffer] = text_filter('run', entered_text);
      clear buffer; % doesn't matter what user types here
      
      try
        sit = importdata(['files\', sit_name]);
        msg_bin = ascii_convert(char(sit(2)));
      catch
        header = '';
        fprintf(2, 'Could not find file\n');
        pwd
        disp(sit_name)
      end


    % cmd: user entered SIT
    elseif iscmd('run', entered_text)
      header = '101';
      sit_command = erase(entered_text, ' ');
      msg_bin = ascii_convert(sit_command(5:end));


    % cmd: change username
    elseif iscmd('name', entered_text)
      header = '0010';
      username = entered_text(7:end);
      msg_bin = ascii_convert(username);


    % cmd: display help menu
    elseif iscmd('help', entered_text)
      fprintf(2, 'General\n');
      fprintf('!help\t\t\t\tget list of all commands\n');
      fprintf('!name\t\t\t\tchange your display name\n');
      fprintf('!clc\t\t\t\tclear your console\n');
      fprintf('!exit\t\t\t\tleave the program\n');
      
      fprintf(2, '\nAdvance\n');
      fprintf('![pass]msg\t\t\tencrypt message before sending\n');
      fprintf('!run sit_code\t\tenter sit code\n');
      fprintf('!syntax\t\t\t\tget sit syntax format\n');

      fprintf(2, '\nLocal Actions\n');
      fprintf('!{file.txt}msg\t\tsave msg in local memory\n');
      fprintf('!{file.sit}msg\t\tsave SIT in local memory\n');
      fprintf('!(file)\t\t\t\tsend locally saved file\n');
      fprintf('!<file>\t\t\t\trun locally saved sit\n');

      fprintf(2, '\nHost Operations\n');
      fprintf('!*{file.txt}msg\t\tsave msg in host''s memory\n');
      fprintf('!*{file.sit}msg\t\tsave SIT in host''s memory\n');
      fprintf('!*(file)\t\t\tview file saved on host''s memory\n');
      fprintf('!*<file>\t\t\trun sit saved on host''s memory\n');

    % cmd: clear console
    elseif iscmd('clc', entered_text)
      clc

    % cmd: exit the program
    elseif iscmd('exit', entered_text)
      fprintf('\nThank you for using d02\n\n\n');
      break;

    % cmd: show .sit syntax
    elseif iscmd('syntax', entered_text)
      fprintf(2, "Stored Illuminated Text syntax guide:\n");
      disp('LED_NAME(time_in_sec)LED2_NAME(time_in_sec);');
      fprintf('divide blink sequence in segments with'); fprintf(2, ';\n');
      fprintf(2, '\nExample:\n');
      disp('B1(1)R1(1);R1(1)B2(1);B2(1)R3(1);')

    % cmd: LED on / LED off
    elseif iscmd('!', entered_text)
      header = '111'; msg_bin = '';
      try
        % converting to capital case
        entered_text = upper(erase(entered_text, ' '));

        % getting LED name
        switch entered_text(3)
          case 'B'
            LED_name = '0';
          case 'R'
            LED_name = '1';
          otherwise
            fprintf(2,'INVALID LED NAME');
            continue;
        end

        % getting LED number
        switch entered_text(4)
          case '1'
            LED_num = '00';
          case '2'
            LED_num = '01';
          case '3'
            LED_num = '10';
          case '4'
            LED_num = '11';
          otherwise
            fprintf(2, 'INVALID LED INDEX\n');
            continue;
        end

        % if the command is to turn off or on
        if isequal('ON', entered_text(5:end))
          LED_state = '1';
        elseif isequal('OFF', entered_text(5:end))
          LED_state = '0';
        else
          fprintf(2, 'INVALID LED STATE\n');
          continue;
        end

        % 4 bits to turn an LED on or off
        msg_bin = [LED_name, LED_num, LED_state]; 

      catch
        fprintf(2, 'syntax error!\n')
        continue;
      end

    else
        fprintf(2, '\n\t\t ! INVALID COMMAND !\n');
        disp('Type !help to get list of all commands.')
    end


  % entered text is just a message
  else
    header = '000';
    msg_bin = ascii_convert(entered_text);
  end
  

  % do not send message if user enters local cmd
  if ~isempty(header)
    full_msg = [preamble, header, extra, msg_bin, postamble];
    send_signal(full_msg);
  end

end
