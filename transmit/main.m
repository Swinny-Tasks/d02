clc; close all; clear;
disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');

% variable declaration
username = 'user';
preamble = '';
postamble = '0';

% text interface
while true
  fprintf(2, '\n[%s] $', username);
  entered_text = input(' ', 's');
  is_msg = false;       % would be true only if entered text should be sent
  is_encrypted = false; % would be true if user encrypts their message
  file_bin = ''; pswd_bin = ''; % could contain other extra information


  % if empty input
  if size(entered_text) == 0
    continue


  % check if possible command
  elseif (entered_text(1) == '!' && length(entered_text) > 1)

    % cmd: encrypt message
    if iscmd('encrypt', entered_text)
      [pass, message] = text_filter('encrypt', entered_text);
      msg_bin = ascii_convert(encrypt(message, pass));
      pswd_bin = ascii_convert(encrypt(pass, pass));

      is_msg = true; is_encrypted = true; header = '001';
    end

    % cmd: save msg/cypher in host memory
    if iscmd('saveH', entered_text)
      is_msg = true;
      if is_encrypted
          header = '011';
      else
          header = '010';
      end

      [file_name, message] = text_filter('save', entered_text);
      
      if length(file_name) > 255
          fprintf(2, "FILE SILZE SHOULD BE SMALLER THAN 255 CHARACTERS")
          is_msg = false;
      else
          file_len_bin = dec2bin(length(file_name));
          while length(file_len_bin) ~= 8
              file_len_bin = ['0', file_len_bin];
          end
      end
      file_bin = [file_len_bin, ascii_convert(file_name)];
      msg_bin = ascii_convert(message);

    % cmd: save msg/cypher in local memory
    elseif iscmd('saveL', entered_text)
      is_msg = false;
      %TODO add code

    % cmd: load plain file from local memory
    elseif iscmd('loadLP', entered_text)
      header = '000';
      %TODO add code

    % cmd: load encrypted file from local memory
    elseif iscmd('loadLE', entered_text)
      header = '001';
      %TODO add code

    % cmd: load plain file from local memory
    elseif iscmd('loadHP', entered_text)
      header = '100';
      %TODO add code

    % cmd: load encrypted file from local memory
    elseif iscmd('loadHE', entered_text)
      header = '101';
      %TODO add code

    % cmd: run localy stored command
    elseif iscmd('runL', entered_text)
      header = '110';
      %TODO add code

    % cmd: run remotely stored command
    elseif iscmd('runH', entered_text)
      header = '111';
      is_msg = true;
      %TODO add code

    % cmd: change username
    elseif iscmd('name', entered_text)
      username = entered_text(7:end);
      msg_bin = ascii_convert(username);
      header = '0010';
      is_msg = true;

    % cmd: display help menu
    elseif iscmd('help', entered_text)
      fprintf(2, 'General\n');
      fprintf('!help\t\t\t\tget list of all commands\n');
      fprintf('!name\t\t\t\tchange your display name\n');
      fprintf('!clc\t\t\t\tclear your console\n');
      fprintf('!exit\t\t\t\tleave the program\n');
      fprintf(2, '\nLocal Actions\n');
      fprintf('![pass]msg\t\t\tsend encrypted msgs\n');
      fprintf('!{file}msg\t\t\tsave msg\\cmds in local memory\n');
      fprintf('![pass]{file}msg\tsave encrypted msg\\cmds in a local file\n');
      fprintf('!(file)\t\t\t\tsend content of a local file\n');
      fprintf('!!(file)\t\t\trun cmds from a local file\n');
      fprintf(2, '\nHost Operations\n');
      fprintf('!*{file}msg\t\t\tsave msg\\cmds in host''s memory\n');
      fprintf('!*[pass]{file}msg\tsave encrypted msg\\cmds in the host''s memory\n');
      fprintf('!*(file)\t\t\tdisplay content of a file in the host''s memory\n');
      fprintf('!!*(file)\t\t\trun cmds from saved file in the host''s memory\n');

    % cmd: clear console
    elseif iscmd('clc', entered_text)
      clc

    % cmd: exit the program
    elseif iscmd('exit', entered_text)
      fprintf('\nThank you for using d02\n\n\n');
      break

    elseif ~is_encrypted
        fprintf(2, '\n\t\t ! INVALID COMMAND !\n');
        disp('Type !help to get list of all commands.')

    end


  % entered text is just a message
  else
    header = '000';
    msg_bin = ascii_convert(entered_text);
    is_msg = true;
  end
  

  % do not send message if user enters local cmd
  if is_msg
    full_msg = [preamble, header, file_bin, pswd_bin, msg_bin, postamble];
    send_signal(full_msg);
  end

end
