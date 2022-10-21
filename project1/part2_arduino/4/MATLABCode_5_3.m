priorports = instrfind;%hali hazirdaki acik portlari bulma
delete(priorports); %bu acik port’lari kapama (yoksa hata verir)
s = serial('COM4');%bilgisayarinizda hangi port olarak define edildiyse,
%o port’u girin.. COM1, COM2, vs..
s.InputBufferSize = 1000; % serial protokolunden oturu,datayi bloklar halinde
% almanizgerekiyor. kacar bytelik bloklar halinde almak istiyorsaniz,onu girin
set(s, "BaudRate", 115200); % arduino’da set ettigimiz hiz ile ayni olmali
fopen(s); %COM portunu acma

while 1 %surekli okuma(ya da belli sayida blok okumak icin for kullanin)
    data=fread(s);
    % datayi bloklar halinde alma. bu islemi yaptiginzda 0 ile 255 arasi
    % degerler iceren, yukarida InputBufferSize’i kac olarak
    % belirlediyseniz o boyutta bir vektorunuz olacaktir.
    drawnow
    plot(data);
end
% audiowrite('aaudio_1.mp4',data2,44100);
% sound(data2,44100)
fclose(s); %serialport’u kapatmak

