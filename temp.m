figure;
j=1;
while j<30
hold on; plot(csv_FS_temp(:,j*2)); j=j+4;
end

Fs=1925;
figure;
L= length(csv_FS_temp(:,1));
 j=1;
while j<30
Y = fft(csv_FS_temp(:,j*2));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
hold on;
plot(f,P1)
 j=j+4;
 clear Y P2 P1;
end
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

x=filtfilt(Hd,csv_FS_temp(:,2));