function power_vector = processor_function(frequencies,power_vector,data_normalized)
    half_bw = 30;
    Fs = 8940;  % Sampling Frequency
    N    = 200;       % Order
    Beta = 0.5;      % Window Parameter
    flag = 'scale';  % Sampling Flag
    for i = 1:length(frequencies)
        Fc1  = frequencies(i)-half_bw;      % First Cutoff Frequency
        Fc2  = frequencies(i)+half_bw;      % Second Cutoff Frequency
        % Create the window vector for the design algorithm.
        win = kaiser(N+1, Beta);
        % Calculate the coefficients using the FIR1 function.
        b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag);
        data_normalized_filtered = filter(b,1,data_normalized); % filtering
        power_vector(i) = sum(data_normalized_filtered.^2); % power calculation
    end
end