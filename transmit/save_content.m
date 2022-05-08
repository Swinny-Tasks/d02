% save passed content in a file 
function save_content(user, time, file_name, content)
  file_name = ['files/', file_name];

  new_sit = fopen(file_name, 'w');
  fprintf(new_sit, '{%s} on [%s]\n%s', user, time, content);
  fclose(new_sit);
end
