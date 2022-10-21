clc,clear;
close all
set(0,'DefaultFigureWindowStyle','docked');
priorports = instrfind;%hali hazirdaki acik portlari bulma
delete(priorports); %bu acik port’lari kapama (yoksa hata verir)
s = serial('COM4');%bilgisayarinizda hangi port olarak define edildiyse,
%o port’u girin.. COM1, COM2, vs..
symbolSize = 7;
bitPeriod = 1e2;
bitLength = round(894*bitPeriod/1e2);
s.InputBufferSize = symbolSize*bitLength; % serial protokolunden oturu,datayi bloklar halinde
% almanizgerekiyor. kacar bytelik bloklar halinde almak istiyorsaniz,onu girin
set(s, "BaudRate", 115200); % arduino’da set ettigimiz hiz ile ayni olmali
fopen(s); %COM portunu acma
matlabSamplinRate = 8900;
t=[1:1:s.InputBufferSize]/matlabSamplinRate;

flag = 0;
header_threshold = 45;%230;
count = 4;
one_mean = [];
one_zero_threshold = 70;
% while 1
    while 1 % this is for the header
        flag = 0;
        data=fread(s);
        for i = 2:length(data)
            if(data(i-1) > header_threshold &&...
                    data(i) <= header_threshold) % finding where header starts
                start_header_i = i-1;
                remaining = data(start_header_i+1:end); % record the remaining part of the buffer
                count = count - 1;
                if count == 0
                    flag = 1;
                    break;
                end
            end
        end
        drawnow
        plot(t,data);
        if flag == 1
            hold on;
             plot(t(start_header_i),data(start_header_i),'r*');
             hold off;
            break;
        end

    end
    message = "";
    bit_seq = '9999999';
    mesIndex = 0;
    while 1
        data=fread(s);
        data = [remaining; data];
        remaining = data(s.InputBufferSize+1:end);
        symbol = data(1:s.InputBufferSize);
        
        drawnow
        plot(t,symbol);
        
        for i = 1 : symbolSize
            if mean(symbol(((i-1)*bitLength+1:i*bitLength))) < 75
                bit_seq(i) = '1';
            else
                bit_seq(i) = '0';
            end
            one_mean = [one_mean mean(symbol(((i-1)*bitLength+1:i*bitLength)))];
        end
%         if char(bin2dec(bit_seq)) == 'T'
%             char(bin2dec(bit_seq))
%         end
        if bit_seq == "0000000"
            break;
        end
        clc
        message = strcat(message,char(bin2dec(bit_seq)))
        mesIndex = mesIndex + 1;    
    end
% end
fclose(s); %serialport’u kapatmak
% sum(bit_Seq)
%char(bin2dec(dec2bin(double('A'))))
%scatter(1:length(one_mean),one_mean)