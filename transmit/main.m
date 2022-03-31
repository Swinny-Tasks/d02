clc; close all; clear;
disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');

% variable declaration
username = 'user';

% text interface
while true
  fprintf(2, '\n[%s] $', username);
  entered_text = input(' ', 's');
  is_msg = true; header = '000';


  % if empty input
  if size(entered_text) == 0
    is_msg = false;
    continue


  % check if possible command
  elseif entered_text(1) == '!'

    % cmd: encrypt message
    if iscmd('encrypt', entered_text)
      [pass, message] = text_filter('encrypt', entered_text);
      msg_hex = [encrypt(pass, pass), encrypt(message, pass)];

      msg_bin = ascii_convert(msg_hex, 'encrypted');
    end

    % cmd: save msg/cypher in local memory
    if iscmd('saveL', entered_text)
      is_msg = false;

    % cmd: save msg/cypher in host memory
    elseif iscmd('saveH', entered_text)
      is_msg = false;

    % cmd: save msg/cypher in host memory
    elseif iscmd('runL', entered_text)
      %TODO add code

    % cmd: save msg/cypher in host memory
    elseif iscmd('runH', entered_text)
      %TODO add code

    % cmd: change username
    elseif iscmd('name', entered_text)
      username = entered_text(7:end);
      is_msg = false;

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
      fprintf('!sos\t\t\t\tsend SOS in morse\n');
      fprintf('!exit\t\t\t\tleave the program\n')
      is_msg = false;

    % cmd: clear console
    elseif iscmd('clc', entered_text)
      clc
      is_msg = false;

    % cmd: exit the program
    elseif iscmd('exit', entered_text)
      fprintf('\nThank you for using d02\n\n\n');
      break

    end


  % entered text is just a message
  else
    msg_bin = ascii_convert(entered_text, 'plain');
  end
  

  % do not send message if user enters local cmd
  if is_msg                  
    % code for passing msg_bin to the machine
  end

end
