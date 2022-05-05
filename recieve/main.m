clc; clear;

disp('     _  ___ ____');
disp('  __| |/ _ |___ \');
disp(' / _` | | | |__) |');
disp('| (_| | |_| / __/');
disp(' \__,_|\___|_____|');

username = 'user';

s = daq.createSession('ni');
s.addAnalogInputChannel('myDAQ1',0, 'Voltage');
s.DurationInSeconds = 10;
message_bin = '';

% program would continue working- waiting for text; without any limit
while true
  sensor_data = s.startForeground; % collect sensor data
  raw_bin = erase(num2str([sensor_data < mean(sensor_data)]'), ' ');
  
  if contains(raw_bin, "11101110111")   % look for preamble
    if contains(raw_bin, "00011111110") % look for postamble
      % complete messasge recorded
      message = slice_msg(raw_bin);

    else
      % means the scan only recoded starting of the whole message
      message_bin = raw_bin; 
    
    end
  else
    if ~isempty(message_bin) && contains(bin, "00011111110")
      % if last message only recoded starting of whole message
      message_bin = [message_bin, bin];
      message = slice_msg(message_bin);
      message_bin = '';

    else
      % scan only recorded garbage
      continue;
    end
  end

  username = decode(message, username);
end
