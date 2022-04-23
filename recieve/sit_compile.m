function sit_compile(code)
  % getting all one-time actions together
  code = split(code, ";");
  for i = 1:length(code)
    content = char(code(i));

    processes = string(zeros(length(content)/5, 2));
    for j = 1:(length(content)/5)
      processes(j, 1) = string(content((5*j-4):(5*j-3)));  % LED Name
      processes(j, 2) = string(content(5*j-1));            % on time
    end
    sortrows(processes, 2); % sorting LEDS with assending time order

    % turn all off
  end
end
