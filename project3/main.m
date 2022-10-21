priorports = instrfind;%hali hazirdaki acik portlari bulma
delete(priorports); %bu acik port’lari kapama (yoksa hata verir)
s = serial('COM4');%bilgisayarinizda hangi port olarak define edildiyse,
%o port’u girin.. COM1, COM2, vs..
s.InputBufferSize = 1000; % serial protokolunden oturu,datayi bloklar halinde
% almanizgerekiyor. kacar bytelik bloklar halinde almak istiyorsaniz,onu girin
set(s, "BaudRate", 115200); % arduino’da set ettigimiz hiz ile ayni olmali
fopen(s); %COM portunu acma
dtmf_map = load("dtmf_map.mat"); % loading the dtmf map which includes
dtmf_map = dtmf_map.dtmf_map; %symbol names and corresponding frequencies
frequencies = [697;770;852;941;1209;1336;1477;1633]; % fir filter frequencies
power_vector = zeros(1,length(frequencies)); % the power vector
received_seq = "";
memory = 0;
while 1 %surekli okuma(ya da belli sayida blok okumak icin for kullanin)
    data_normalized = input_function(s);
    power_vector = processor_function(frequencies,power_vector,data_normalized);
    [received_seq,memory] = output_function(received_seq,...
        power_vector,memory,dtmf_map,frequencies);
end
fclose(s); %serialport’u kapatmak

