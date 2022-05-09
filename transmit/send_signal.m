function send_signal(str_bin)
  num_bin = zeros(length(str_bin), 1);
  
  % convert message binary string to numerical array
  for i = 1:length(str_bin)
      num_bin(i, 1) = str2double(str_bin(i));
  end

  % Use daq.getDevices to check the device
  session = daq.createSession('ni');
  session.addAnalogOutputChannel('myDAQ1',0,'Voltage');
  session.Rate = 5000; 
  dataSeq = num_bin; % column vector
  voltage = 5; % value to output port
  queueOutputData(session,dataSeq*voltage); % prepare data sequence for output

  % send message only on even-clock-edge & if message size is reasonable
  while (true)
    % if the data could be transmitted under a second
    if (length(str_bin) > session.Rate)
        fprintf(2, "message too big\n");
        break;
    else
      % if time is exactly event; i.e. including nano/mili seconds
      if (rem(second(datetime('now')), 2) == 0)
        session.startForeground; % output the queued date
        session.release();
        break;
      end
    end
  end

end
