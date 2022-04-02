% converts text to single ascii string
function ascii_msg = ascii_convert(text)
  % character added to make the converstion use 8bits per ascii (and not 7)
  text = [text, '»'];
  text = double(text);

  ascii = dec2bin(text);
  ascii_msg = '';
  
  for counter = 1:(length(text)-1)
    ascii_msg = append(ascii_msg, ascii(counter, :));
  end
  
end
