clc,clear
awgn_input_signal_power = 1/(1*8);
awgn_symbol_period = 1e-6;

rig_sample_time = 1e-6;
rig_samples_per_frame = 100;
cnst_sample_time = 1e-6*rig_samples_per_frame;
M = 4;


uc_dc_freq = 2.5e6;
uc_dc_sample_time = 1e-6/8;
uc_dc_samples_per_frame = 8*rig_samples_per_frame;

snr_vec = 0:2:14;
ErrorVecMain = zeros(length(snr_vec),5);
erc_receive_delay = 10*log2(M);

rcrf_gain = 2;

stop_time = 1000*1e-6;
mod_demod_av_pow = 1;
current_snr = 50;
for i =1:length(snr_vec)
   current_snr = snr_vec(i);
   Es_N0 = db2pow(current_snr);
   sim("q13.slx",stop_time);
   ErrorVecMain(i,:) = [current_snr,...
       ErrorVec,...
       (2*(M-1)/(M*sqrt(log2(M))))*qfunc(sqrt((6*Es_N0/(M^2-1))))];
   current_snr
end
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,2),...
    "displayname","4-PAM sim.",...
    "linewidth",2);
hold on;
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,5),...
    "displayname","4-PAM theo.",...
    "linewidth",2);
axis square, grid on, grid minor, legend
xlabel("SNR (dB)");
ylabel("BER");
set(gca,"fontsize",14);