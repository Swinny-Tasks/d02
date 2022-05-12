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
s.Rate = 256;
prev_time = -1; % useful to prevent multiple call in a single time frame

% program would continue working- waiting for text; without any limit
while true
  t = second(datetime('now'));
  if ((rem(t, 2) == 0) && (t ~= prev_time))
    prev_time = t;

    % env_level = read(s, seconds(0.1), "OutputFormat","Matrix");
    % env_level = max(env_level); % max value of 0, i.e. environment level
    env_level = 1;


    % collect sensor data
    sensor_data = read(s, seconds(1.55), "OutputFormat","Matrix");

    raw_bin = erase(num2str([sensor_data > env_level]'), ' ');

    if contains(raw_bin, "11101110111")   % look for preamble
      if contains(raw_bin, "00011111110") % look for postamble
        % complete messasge recorded
        message = slice_msg(raw_bin);
        username = decode(message, username);
      end
    end
  end
end
