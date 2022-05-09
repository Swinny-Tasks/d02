% save passed content in a file 
function save_txt(user, time, file_name, content)
  file_name = ['files/', file_name];

  new_sit = fopen(file_name, 'w');
  fprintf(new_sit, '{%s} on [%s] at [%s]\n%s\n', user, date, time, content);
  fclose(new_sit);
  
end
