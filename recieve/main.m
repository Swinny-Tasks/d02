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
s.Rate = 12000;
prev_time = -1; % useful to prevent multiple call in a single time frame

% program would continue working- waiting for text; without any limit
while true
  t = second(datetime('now'));
  if ((rem(t, 2) == 0) && (t ~= prev_time))
    prev_time = t;

    % collect sensor data
    sensor_data = read(s, seconds(1.55), "OutputFormat","Matrix");
    smooth_data = zeros(1, 186);
    
    for i = 1:186
      smooth_data(i) = median(sensor_data((((i*100)-99)) : (i*100)));
    end

    env_level = (max(rmoutliers(smooth_data)) + min(rmoutliers(smooth_data)))/2;
    raw_bin = num2str([smooth_data > env_level]')';

    message = slice_msg(raw_bin);
    if ~isempty(message)
      username = decode(message, username);
    end

  end
end
