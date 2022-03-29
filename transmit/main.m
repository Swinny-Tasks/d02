% variable declaration
username = 'user'; header = 100;

% text interface
while true
  fprintf(2, '\n[%s] $', username);
  entered_text = input(' ', 's');
    
  if size(entered_text) == 0                                  % empty input
    continue

  elseif entered_text(1) == '!'                          % possible command
    if iscmd('encrypt', entered_text)                     % encrypt message
      %TODO add code for encrypting text
    end

    if iscmd('clc', entered_text)                           % clear console
      clc

    elseif iscmd('help', entered_text)                       % help command
      fprintf(2, 'command\tfunction\n');
      fprintf('!help\t\t\tget list of all commands\n');
      fprintf('![pass]message\tencrypt message with password\n');
      fprintf('!{file}message\tsave message in a file\n');
      fprintf('!clc\t\t\tclear your console\n');
      fprintf('!sos\t\t\tsend SOS in morse\n');
      fprintf('!exit\t\t\tleave the program\n')

    elseif iscmd('name', entered_text)                    % change username
      username = entered_text(7:end);

    elseif iscmd('exit', entered_text)                   % exit the program
      fprintf('\nThank you for using d02\n\n\n');
      break

    elseif iscmd('save', entered_text)          % save msg/cypher in a file
      %

    end

    % text message
  else
    % convert text into array of binary ascii
    msg_bin = ascii_convert(entered_text, 'plain');
  end

  % code for passing msg_bin to the machine

end
