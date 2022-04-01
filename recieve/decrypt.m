% decrypt passed text with entered password
function msg = decrypt(text, password)
  pass_deci = double(password);
  text_deci = zeros(1, (length(text)/8));
  msg_deci = zeros(length(password));

  for i = 1:8:(length(text))
    single_letter = bin2dec(text(1, i:(i+7)));
    text_deci(1, (i-1)/8 + 1) = single_letter;
  end

  for j = 1:length(password)
    msg_deci(j) = text_deci(j) - pass_deci(j);
  end

  msg = char(msg_deci);
end
