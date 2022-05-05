function message = slice_msg(text)
  start = strfind(text, "11101110111");
  finish = strfind(text, "00011111110");

  message = text(start+11: finish-1);
end
