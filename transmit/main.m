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
