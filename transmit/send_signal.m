function send_signal(str_bin)
  num_bin = zeros(length(str_bin), 1);
  
  % convert message binary string to numerical array
  for i = 1:length(str_bin)
      num_bin(i, 1) = str2double(str_bin(i));
  end

  % Use daq.getDevices to check the device
  session = daq.createSession('ni');
  session.addAnalogOutputChannel('myDAQ1',0,'Voltage');
  session.Rate = 120; 
  dataSeq = num_bin; % column vector
  voltage = 10; % value to output port
  queueOutputData(session,dataSeq*voltage); % prepare data sequence for output

  % if the data could be transmitted under a second
  if (length(str_bin) > session.Rate)
    fprintf(2, "message too big\n");
  else
    prev_time = -1; % useful to prevent multiple call in a single time frame
    % send message only on even-clock-edge & if message size is reasonable
    while (true)
      % if time is exactly event; i.e. including nano/mili seconds
      t = second(datetime('now'));
      if ((rem(t, 2) == 0) && (t ~= prev_time))
        prev_time = t;
        pause(0.3)
        session.startForeground; % output the queued date
        session.release();
        break;
      end
    end
  end
end
