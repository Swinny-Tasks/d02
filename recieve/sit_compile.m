function sit_compile(code)
  LED_seq = ["r1", "b1", "r2", "b2", "r3", "b3", "r4", "b4"];
  
  % connecting to the hardware
  m = daq.createSession('ni');
  m.addDigitalChannel('myDAQ1','Port0/Line0:7','OutputOnly');
  
  % getting all one-time actions together
  code = split(code, ";");
  for i = 1:length(code)
    content = char(code(i));
    on_LEDs = [0 0 0 0 0 0 0 0];
    
    processes = string(zeros(length(content)/5, 2));
    for j = 1:(length(content)/5)
      processes(j, 1) = string(content((5*j-4):(5*j-3)));  % LED Name
      processes(j, 2) = string(content(5*j-1));            % on time
    end
    % sorting LEDS with assending time order
    processes = sortrows(processes, 2); 

    for k = (length(content)/5):-1:2
      % change 'time on' with 'time difference'
      diff = str2num(processes(k, 2)) - str2num(processes(k-1, 2));
      processes(k, 2) = string(diff);

      % generating 'to turn on' list
      LED_index = find(LED_seq == lower(processes(k, 1)));
      if ~isempty(LED_index)
        on_LEDs(1, LED_index) = 1;
      end
    end
    
    % turn all off
    m.outputSingleScan([0 0 0 0 0 0 0 0]);
    m.release();

  end
end
