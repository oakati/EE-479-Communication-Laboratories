Fs = 14400; % Sampling Frequency , generally chosen as 14400.
duration = 20; % Duration of the sound file. 
t = linspace(0 , duration , duration*Fs ); % Time Vector. 

m = cos(2*pi*20*t);
f_c = 200;
k_f = 300;
s1 = cos(2*pi*f_c*t + 2*pi*k_f*(sin(2*pi*20*t)/(2*pi*20)));
s = s1;

plot(s);

s = s / max(s); %scale to the signal to fit between 1 and 1.
fftSignal = fft(s);
fftSignal = fftshift(fftSignal);
f = Fs/2*linspace(-1,1,20*Fs);
plot(f, abs(fftSignal));
% sound(s, Fs); % Creating the sound file.
audiowrite("deneme.wav", s, Fs);