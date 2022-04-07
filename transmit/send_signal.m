function send_signal(str_bin)
  num_bin = zeros(length(str_bin), 1);
  for i = 1:length(str_bin)
      num_bin(i, 1) = str2num(str_bin(i));
  end

  % Use daq.getDevices to check the device
  session = daq.createSession('ni');
  session.addAnalogOutputChannel('myDAQ1',0,'Voltage');
  session.Rate = 100; 
  dataSeq = num_bin; % column vector
  voltage = 5; % value to output port
  queueOutputData(session,dataSeq*voltage); % prepare data sequence for output
  session.startForeground; % output the queued date
  session.release();

end
