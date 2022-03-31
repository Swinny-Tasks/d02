% would be used to convert plain binary ascii to text
function text = char_convert(msg_ascii)
  % msg_ascii is in binary
  text_deci = zeros(1, length(msg_ascii)/8);

  for k = 1:8:(length(msg_ascii))
    single_letter = bin2dec(msg_ascii(1, k:(k+7)));
    text_deci(1, (k-1)/8 + 1) = single_letter;
  end

  text = char(text_deci);

end
