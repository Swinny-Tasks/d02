function send_signal(str_bin)
  num_bin = zeros(length(str_bin), 1);
  for i = 1:length(str_bin)
      num_bin(i, 1) = str2num(str_bin(i));
  end

  % Use daq.getDevices to check the device
  session = daq.createSession('ni');
  session.addAnalogOutputChannel('myDAQ1',0,'Voltage');
  session.Rate = 5000; 
  dataSeq = num_bin; % column vector
  voltage = 5; % value to output port
  queueOutputData(session,dataSeq*voltage); % prepare data sequence for output
  
  while (true)
    t1 = datetime('now');
    
    if (rem(second(t1), 2) == 0)
      pause(0.5); 
      session.startForeground; % output the queued date
      session.release();
      t2 = datetime('now');
      
      if (seconds(diff(datetime([t1;t2]))) > 1.5)
        fprintf(2, "message too big\n");
      end
      
      break;
    end
  end

end
