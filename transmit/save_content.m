% save passed content in a file 
function save_content(user, time, file_name, content, extension)
  file_name = [file_name, extension];
  c = clock;
  date = [num2str(c(3)), '/', num2str(c(2)), '/', num2str(c(1))];

  new_sit = fopen(file_name, 'w');
  fprintf(new_sit, '{%s} on [%s] at [%s]\n%s', user, date, time, content);
  fclose(new_sit);
  
end
