% save passed content in a file 
function save_txt(user, time, file_name, content)
  file_name = [file_name, '.sit'];
  time = datetime("now");

  new_sit = fopen(file_name, 'w');
  fprintf(new_sit, '{%s} on [%s]\n%s\n', user, time, content);
  fclose(new_sit);
  
end
