priorports = instrfind;%hali hazirdaki acik portlari bulma
delete(priorports); %bu acik port’lari kapama (yoksa hata verir)
s = serial('COM4');%bilgisayarinizda hangi port olarak define edildiyse,
%o port’u girin.. COM1, COM2, vs..
s.InputBufferSize = 1000; % serial protokolunden oturu,datayi bloklar halinde
% almanizgerekiyor. kacar bytelik bloklar halinde almak istiyorsaniz,onu girin
set(s, "BaudRate", 115200); % arduino’da set ettigimiz hiz ile ayni olmali
fopen(s); %COM portunu acma

Fs = 14400; % Sampling Frequency , generally chosen as 14400.
t = [1:999]/9045; % Time Vector.
while 1 %surekli okuma(ya da belli sayida blok okumak icin for kullanin)
    data=fread(s);
    % datayi bloklar halinde alma. bu islemi yaptiginzda 0 ile 255 arasi
    % degerler iceren, yukarida InputBufferSize’i kac olarak
    % belirlediyseniz o boyutta bir vektorunuz olacaktir.
    drawnow
    deriv = diff(data);
    
    %  envelope detector
    squared = deriv.*deriv;
    lowpassed = lowpass(squared,30,8900);
    dcblocked = lowpassed-mean(lowpassed);
    normalized = zeros(999,1);
    conditioned = dcblocked>0;
    normalized(conditioned) = dcblocked(conditioned)/max(dcblocked);
    conditioned = dcblocked<0;
    normalized(conditioned) = dcblocked(conditioned)/abs(min(dcblocked));
    
    plot(t,normalized);
    hold on
    plot(t,cos(2*pi*20*t));
    hold off
end
% audiowrite('aaudio_1.mp4',data2,44100);
% sound(data2,44100)
fclose(s); %serialport’u kapatmak
% mean_square_error = mean((normalized' - cos(2*pi*20*t)).^2)
