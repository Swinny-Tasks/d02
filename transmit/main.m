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
  timenow = datetime('now');

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
    end


    % cmd: save message/SIT in Host memory
    if iscmd('saveH', entered_text)
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
      save_content(username, timenow, file_name, message);
      fprintf(2, 'message saved!');
      clear message file_len_bin;


    % cmd: load Plain file from Host memory
    elseif iscmd('loadHP', entered_text)
      header = '011';
      %TODO add code


    % cmd: load Plain file from Local memory
    elseif iscmd('loadLP', entered_text)
      header = '000';
      [file_name, buffer] = text_filter('load', entered_text);
      clear buffer; % doesn't matter what user types here
      
      message = importdata(file_name);
      message = string(message(2));


    % cmd: run SIT from Host memory
    elseif iscmd('runH', entered_text)
      header = '100';
      %TODO add code

      
    % cmd: run SIT from Local memory
    elseif iscmd('runL', entered_text)
      header = '101';
      %TODO add code


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
      
      fprintf(2, '\nEncryption\n');
      fprintf('![pass]msg\t\t\tencrypt message before sending\n');

      fprintf(2, '\nLocal Actions\n');
      fprintf('!{file.txt}msg\t\t\tsave msg in local memory\n');
      fprintf('!{file.sit}msg\t\t\tsave SIT in local memory\n');
      fprintf('!(file)\t\t\t\tsend locally saved file\n');
      fprintf('!<file>\t\t\t\trun locally saved sit\n');

      fprintf(2, '\nHost Operations\n');
      fprintf('!*{file.txt}msg\t\t\tsave msg in host''s memory\n');
      fprintf('!*{file.sit}msg\t\t\tsave SIT in host''s memory\n');
      fprintf('!*(file)\t\t\tview file saved on host''s memory\n');
      fprintf('!*<file>\t\t\trun sit saved on host''s memory\n');


    % cmd: clear console
    elseif iscmd('clc', entered_text)
      clc

    % cmd: exit the program
    elseif iscmd('exit', entered_text)
      fprintf('\nThank you for using d02\n\n\n');
      break;

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
