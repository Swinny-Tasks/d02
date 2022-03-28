clc; close all; clear;

% variable declaration
username = 'user'; header = 100;

% text interface
while true
  fprintf(2, '\n[%s] $', username);
  entered_text = input(' ', 's');
    
  % empty input
  if size(entered_text) == 0
    continue

  % possible command
  elseif entered_text(1) == '!'
    % clear console
    if iscmd('clc', entered_text)
      clc

    % change username
    elseif iscmd('name', entered_text)
      username = entered_text(7:end);

    % exit the program
    elseif iscmd('exit', entered_text)
      fprintf('\nThank you for using d02\n\n\n');
      break

    % not a command
    else
      fprintf(2, '\nINVALID COMMAND\n');
      fprintf('Type !h to get list of all commands\n');
    end

    % text message
  else
    % convert text into array of binary ascii
    msg_bin = ascii_convert(entered_text);
  end

  % code for passing msg_bin to the machine

end
