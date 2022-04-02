clc; close all; clear;
disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');

% variable declaration
username = 'user';
preamble = '';
postamble = '';

% text interface
while true
  fprintf(2, '\n[%s] $', username);
  entered_text = input(' ', 's');
  
  is_msg = false;       % would be true only if entered text should be sent
  is_encrypted = false; % would be true if user encrypts their message
  header = '000';       % would change depending on the type of message
  extra = '';           % could contain other extra information


  % if empty input
  if size(entered_text) == 0
    continue


  % check if possible command
  elseif (entered_text(1) == '!' && length(entered_text) > 1)

    % cmd: encrypt message
    if iscmd('encrypt', entered_text)
      [pass, message] = text_filter('encrypt', entered_text);
      cypher_hex = [encrypt(pass, pass), encrypt(message, pass)];

      msg_bin = ascii_convert(cypher_hex);
      is_msg = true; is_encrypted = true; header = '001';
    end

    % cmd: save msg/cypher in local memory
    if iscmd('saveL', entered_text)
      %TODO add code

    % cmd: save msg/cypher in host memory
    elseif iscmd('saveH', entered_text)
      is_msg = true;
      if is_encrypted
          header = '011';
      else
          header = '010';
      end
      %TODO add save code

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
      fprintf(2, 'command\t\t\t\tfunction\n');
      fprintf('!help\t\t\t\tget list of all commands\n');
      fprintf('![pass]message\t\tencrypt message with password\n');
      fprintf('!{file}message\t\tsave message\\cmds in a local file\n');
      fprintf('!{file}*message\t\tsave message\\cmds in a host file\n');
      fprintf('!(file)\t\t\t\tsend content of a local file\n');
      fprintf('!(file)*\t\t\tdisplay content of a host file\n');
      fprintf('!!(file)\t\t\trun cmds from a local file\n');
      fprintf('!!(file)*\t\t\teun cmds from a host file\n');
      fprintf('!name\t\t\t\tchange your display name\n');
      fprintf('!clc\t\t\t\tclear your console\n');
      fprintf('!exit\t\t\t\tleave the program\n')

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
    msg_bin = ascii_convert(entered_text);
    is_msg = true;
  end
  

  % do not send message if user enters local cmd
  if is_msg
    full_msg = [preamble, extra, header, msg_bin, postamble];
    % code for passing msg_bin to the machine
    disp(full_msg);
  end

end
