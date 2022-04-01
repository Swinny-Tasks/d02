% decrypt passed text with entered password
function msg = decrypt(pass, text)
  pass_deci = double(pass);
  msg_deci = zeros(1, length(pass));

  for i = 1:8:(length(text))
    i1 = (i-1)/8 + 1;
    i2 = rem(i1, length(pass));
    
    if i2 == 0
        i2 = length(pass);
    end
    
    letter = bin2dec(text(1, i:(i+7)));
    msg_deci(1, i1) = letter - pass_deci(i2);
  end

  msg = char(msg_deci);
end
