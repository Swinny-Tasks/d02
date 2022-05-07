clc; clear;

disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');
disp('  ')

username = 'user';

s = daq('ni');
s.addinput('myDAQ1',0, 'Voltage');
message_bin = '';
s.Rate = 5000;

% program would continue working- waiting for text; without any limit
while true
  if (rem(second(datetime('now')), 2) == 0)
    fprintf("start  ")

    % collect sensor data
    sensor_data = read(s, seconds(1.55), "OutputFormat","Matrix");
  
    raw_bin = erase(num2str([sensor_data > 2]'), ' ');
  
    if contains(raw_bin, "11101110111")   % look for preamble
      if contains(raw_bin, "00011111110") % look for postamble
        % complete messasge recorded
        message = slice_msg(raw_bin);
        username = decode(message, username);
        disp(' ')
      end
    end
    disp("end")
  end
end
