function sit_compile(code)
  LED_seq = ["b1", "r1", "b2", "r2", "r3", "b3", "r4", "b4"];
  
  % connecting to the hardware
  dev = daq.createSession('ni');
  dev.addDigitalChannel('myDAQ1','Port0/Line0:7','OutputOnly');
  
  % getting all one-time actions together
  code = split(erase(code, ' '), ";");
  for i = 1:length(code)
    content = char(code(i));
    on_LEDs = [0 0 0 0 0 0 0 0];
    
    % generating list of LEDs dealt with in this process
    before_time = find(content == '(');
    after_time = find(content == ')');
    processes = string(zeros(length(before_time), 2));
    for j = 1:(length(before_time))
      index = before_time(j);
      processes(j, 1) = string(content((index-2):(index-1)));  % LED Name
      processes(j, 2) = string(content((index+1):(after_time(j)-1))); % on time
    end
    clear before_time after_time content

    % sorting LEDS with assending time order
    processes = sortrows(processes, 2); 

    % change 'time on' with 'time difference'
    for k = length(processes):-1:2
      diff = str2double(processes(k, 2)) - str2double(processes(k-1, 2));
      processes(k, 2) = string(diff);
    end

    % generating 'to turn on' list
    for l = 1:length(processes)
      LED_index = find(LED_seq == lower(processes(l, 1)));
      if ~isempty(LED_index)
        on_LEDs(1, LED_index) = 1;
      end
    end

    % turning all reqested lights on
    dev.outputSingleScan(on_LEDs);
    dev.release();

    % turn off specific LED after specified time delay
    for m = 1:length(processes)
      pause(str2double(processes(m, 2)));
      turn_off_index = LED_seq == lower(processes(m, 1));
      on_LEDs(1, turn_off_index) = 0;

      dev.outputSingleScan(on_LEDs);
      dev.release();
    end
  end
end

