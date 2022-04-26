% Turn off all LEDs

m = daq.createSession('ni');
m.addDigitalChannel('myDAQ1','Port0/Line0:7','OutputOnly');

on_LEDs = zeros(1, 8);
m.outputSingleScan(on_LEDs); 
m.release();

