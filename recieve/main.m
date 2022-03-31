clc; close all; clear;

disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');

username = 'user';

% program would continue working- waiting for text; without any limit
while true

  % code to read data from sensors
  raw_bin = ''; % overwrite this with the data recieved
  
  % look for preambed
  message = ''; % extract from raw binary; scrape out preamble and post
  username = decode(message, username);
end