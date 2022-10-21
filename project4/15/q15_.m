clc,clear
awgn_input_signal_power = 1/(2*8);
awgn_symbol_period = 1e-6;

rig_samples_per_frame = 100;
rig_sample_time = 1e-6;
cnst_sample_time = 1e-6*rig_samples_per_frame;
M = 16;

uc_dc_freq = 2.5e6;
uc_dc_sample_time = 1e-6/8;
uc_dc_samples_per_frame = 8*rig_samples_per_frame;

snr_vec = 0:2:20;
ErrorVecMain = zeros(length(snr_vec),5);
erc_receive_delay = 10*log2(M);

rcrf_gain = 2;

stop_time = 1000*1e-6;
current_snr = 50;

mod_demod_av_pow = 1;
for i =1:length(snr_vec)
   current_snr = snr_vec(i);
   Eb_N0 = db2pow(current_snr-10*log10(log2(M)));
   sim("q15.slx",stop_time);
   ErrorVecMain(i,:) = [current_snr,...
       ErrorVec,...
       (4/log2(M))*qfunc(sqrt(3*Eb_N0*log2(M)/(M-1)))];
   current_snr
end
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,2),...
    "displayname","16-QAM sim.",...
    "linewidth",2);
hold on;
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,5),...
    "displayname","16-QAM theo.",...
    "linewidth",2);
axis square, grid on, grid minor, legend
xlabel("SNR (dB)");
ylabel("BER");
set(gca,"fontsize",14);