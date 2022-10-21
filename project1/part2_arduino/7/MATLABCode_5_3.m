priorports = instrfind;%hali hazirdaki acik portlari bulma
delete(priorports); %bu acik port’lari kapama (yoksa hata verir)
s = serial('COM4');%bilgisayarinizda hangi port olarak define edildiyse,
%o port’u girin.. COM1, COM2, vs..
s.InputBufferSize = 1000; % serial protokolunden oturu,datayi bloklar halinde
% almanizgerekiyor. kacar bytelik bloklar halinde almak istiyorsaniz,onu girin
set(s, "BaudRate", 115200); % arduino’da set ettigimiz hiz ile ayni olmali
fopen(s); %COM portunu acma

Fs = 14400; % Sampling Frequency , generally chosen as 14400.
duration = 20; % Duration of the sound file. 
t = [0:999]/8980; % Time Vector. 

m = cos(2*pi*10*t);
A = 1.2;
f_c = 200;
s1 = (A + m).*cos(2*pi*f_c*t);
mes = s1;

while 1 %surekli okuma(ya da belli sayida blok okumak icin for kullanin)
    data=fread(s);
    % datayi bloklar halinde alma. bu islemi yaptiginzda 0 ile 255 arasi
    % degerler iceren, yukarida InputBufferSize’i kac olarak
    % belirlediyseniz o boyutta bir vektorunuz olacaktir.
    drawnow
    plot(t,m);
    hold on
    data = data-mean(data);
    lowpassed = lowpass(data.*data, 50, 8980);
    plot(t,(lowpassed-mean(lowpassed))/1200);
    legend("original signal","demodulated signal");
    hold off
%     plot(t,zeromean);
%     hold on
%     plot (t,1250*m);
%     hold off
%     plot([0:999]/8980,data);
%     data2 = [data2;data];
end
% audiowrite('aaudio_1.mp4',data2,44100);
% sound(data2,44100)
fclose(s); %serialport’u kapatmak

