% variable declaration
username = 'user';

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
        elseif iscmd('nn', entered_text)
            username = entered_text(5:end);

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
        fprintf('normal text\n')
    end
end
