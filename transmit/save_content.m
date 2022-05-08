% save passed content in a file 
function save_content(user, file_name, content)
  file_name = ['files/', file_name];
  time = datetime('now');

  new_sit = fopen(file_name, 'w');
  fprintf(new_sit, '{%s} on [%s]\n%s', user, time, content);
  fclose(new_sit);
end
