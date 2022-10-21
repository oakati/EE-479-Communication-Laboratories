clc,clear
awgn_input_signal_power = 1/(2*8);
awgn_symbol_period = 1e-6;

cnst_sample_time = 1e-4;
M = 8;
rig_sample_time = 1e-6;
rig_samples_per_frame = 100;

uc_dc_freq = 2.5e6;
uc_dc_sample_time = 1e-6/8;
uc_dc_samples_per_frame = 8*rig_samples_per_frame;

snr_vec = 0:2:14;
ErrorVecMain = zeros(length(snr_vec),5);
erc_receive_delay = 10*log2(M);

rcrf_gain = 1;

stop_time = 1000*1e-6;
for i =1:length(snr_vec)
   current_snr = snr_vec(i);
   Eb_N0 = db2pow(current_snr-10*log10(log2(M)));
   sim("q14.slx",stop_time);
   ErrorVecMain(i,:) = [current_snr,...
       ErrorVec,...
       (2/log2(M))*qfunc(sqrt(2*Eb_N0*log2(M))*sin(pi/M))];
   current_snr
end
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,2),...
    "displayname","8-PSK sim.",...
    "linewidth",2);
hold on;
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,5),...
    "displayname","8-PSK theo.",...
    "linewidth",2);
axis square, grid on, grid minor, legend
xlabel("SNR (dB)");
ylabel("BER");
set(gca,"fontsize",14);