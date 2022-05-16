% script to read surrounding data
s = daq('ni');
s.addinput('myDAQ1',0, 'Voltage');
message_bin = '';
s.Rate = 20000;

% collect sensor data
sensor_data = read(s, seconds(1), "OutputFormat","Matrix");

% smoothening recorded data
smooth_data = zeros(1, 186);
for i = 1:200
  smooth_data(i) = mean(sensor_data((((i*100)-99)) : (i*100)));
end
clear sensor_data;

env_level = (max(smooth_data) + min(smooth_data))/2;

figure("Name", 'Smooth Data')
plot(1:200, smooth_data); hold on;
plot(1:200, env_level*ones(1, 200)); hold off;
