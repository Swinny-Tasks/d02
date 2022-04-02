% encrypt message with a password
function cypher = encrypt(message, password)
  pass_ascii = double(password); 
  msg_ascii = double(message);

  msg_len = length(message);        % instead of finding length 2 times ahead
  pass_len = length(password);      % consistancy

  cypher = zeros(1, msg_len);       % to predefine cypher's length

  for counter = 1:length(message)
      pass_counter = rem(counter, pass_len);

      if pass_counter == 0
          pass_counter = pass_len;
      end

    cypher(counter) = msg_ascii(counter) + (pass_ascii(pass_counter));
  end

end
