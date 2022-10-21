snr_vec = 1:11;
ErrorVecMain = zeros(length(snr_vec),5);
for i =1:length(snr_vec)
   current_snr = snr_vec(i);
   sim("q11.slx");
   ErrorVecMain(i,:) = [current_snr ErrorVec qfunc(sqrt(2*current_snr))];
end
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,2),...
    "displayname","BPSK sim.",...
    "linewidth",2);
hold on;
semilogy(ErrorVecMain(:,1),ErrorVecMain(:,5),...
    "displayname","BPSK theo.",...
    "linewidth",2);
axis square, grid on, grid minor, legend
xlabel("SNR (dB)");
ylabel("BER");
set(gca,"fontsize",14);