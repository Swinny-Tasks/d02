% looks at the head of a message to confirm if its a command
function is_it = iscmd(cmd, text)
  is_it = false;
  if length(text) > length(cmd)
      if text(2:(length(cmd)+1)) == cmd
          is_it = true;
      end
  end
end
