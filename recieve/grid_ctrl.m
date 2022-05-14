function grid_ctrl(pattern)
  % connecting to the hardware
  dev = daq.createSession('ni');
  dev.addDigitalChannel('myDAQ1','Port0/Line0:7','OutputOnly');

  % turning all reqested lights on
  dev.outputSingleScan(pattern);
  dev.release();
end
