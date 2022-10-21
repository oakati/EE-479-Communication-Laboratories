Fs = 14400; % Sampling Frequency , generally chosen as 14400.
duration = 20; % Duration of the sound file. 
t = linspace(0 , duration , duration*Fs ); % Time Vector. 

m = cos(2*pi*10*t);
A = 1.2;
f_c = 200;
s1 = (A + m).*cos(2*pi*f_c*t);
s = s1;

plot(s);
s = s / max(s); %scale to the signal to fit between 1 and 1. 
% sound(s, Fs); % Creating the sound file.
audiowrite("deneme.wav", s, Fs);