function [data_normalized] = input_function(s)
    data = fread(s); %reading the data from serial port
    data_normalized = normalize(data); % data is normalized
end