close all;
clear all;

%% frsky data
fileID = fopen("drone_IQ_frsky_fs_5e6_fc_2431500e3.dat",'r');
frsky_bin = fread(fileID,100000000,'float');

fftsize = 2048*2;
fs = 5e6;
period_ms = (1/fs)*1000;
center_freq = 2431500e3;

frsky_IQ_raw = (frsky_bin(1:2:end) + j*frsky_bin(2:2:end));

figure
plot([0:length(frsky_IQ_raw)-1]*period_ms, real(frsky_IQ_raw))
hold on
plot([0:length(frsky_IQ_raw)-1]*period_ms,imag(frsky_IQ_raw))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of Raw Frsky Capture');

figure
spectrogram(frsky_IQ_raw,hamming(fftsize),0, fftsize , fs, 'centered', 'psd' );
title('Spectrogram of Raw Frsky Capture');
xticks([( -0.5:0.05:0.5-0.05)*fs/1e6])
xticklabels([(-0.5:0.05:0.5-0.05)*fs/1e6]+center_freq/1e6)


% Selected these signals based on the spectrogram
IQ_data_frsky_1 = frsky_IQ_raw(39449000:39449000+22745);
IQ_data_frsky_2 = frsky_IQ_raw(39449000+26360:39490000);
IQ_data_frsky_full = frsky_IQ_raw(39449000:39490000);


figure
plot([0:length(IQ_data_frsky_1)-1]*period_ms, real(IQ_data_frsky_1))
hold on
plot([0:length(IQ_data_frsky_1)-1]*period_ms,imag(IQ_data_frsky_1))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of First Portion of Frsky Signal');

figure
plot((-0.5:1/fftsize:0.5-1/fftsize)*fs/1e6+center_freq/1e6,fftshift(20*log10(abs(fft(IQ_data_frsky_1,fftsize)))),'linewidth',2)
xlabel('Frequency (MHz)')
ylabel('Magnitude (dB)')
title('Spectrum of First Portion of Frsky Signal');

figure
plot([0:length(IQ_data_frsky_2)-1]*period_ms, real(IQ_data_frsky_2))
hold on
plot([0:length(IQ_data_frsky_2)-1]*period_ms, imag(IQ_data_frsky_2))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of Second Portion of Frsky Signal');

figure
plot((-0.5:1/fftsize:0.5-1/fftsize)*fs/1e6+center_freq/1e6,fftshift(20*log10(abs(fft(IQ_data_frsky_2,fftsize)))),'linewidth',2)
xlabel('Frequency (MHz)')
ylabel('Magnitude (dB)')
title('Spectrum of Second Portion of Frsky Signal');

figure
plot([0:length(IQ_data_frsky_full)-1]*period_ms,real(IQ_data_frsky_full))
hold on
plot([0:length(IQ_data_frsky_full)-1]*period_ms,imag(IQ_data_frsky_full))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of Frsky Signal');

fclose(fileID);
clear frsky_IQ_raw;
clear frsky_bin;
%% phantom_4 data
fileID = fopen("drone_IQ_phantom_4_fs_5e6_fc_2430e6.dat",'r');
phantom_4_bin = fread(fileID,100000000,'float');

center_freq = 2430e6;

phantom_4_IQ_raw = (phantom_4_bin(1:2:end) + j*phantom_4_bin(2:2:end));

figure
plot([0:length(phantom_4_IQ_raw)-1]*period_ms,real(phantom_4_IQ_raw))
hold on
plot([0:length(phantom_4_IQ_raw)-1]*period_ms,imag(phantom_4_IQ_raw))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of Raw Phantom 4 Capture');

figure
spectrogram(phantom_4_IQ_raw,hamming(fftsize),0,(-0.5:1/fftsize:0.5-1/fftsize)*fs+center_freq,fs)
title('Spectrogram of Raw Phantom 4 Capture');
xticks([( -0.5:0.05:0.5-0.05)*fs/1e6])
xticklabels([(-0.5:0.05:0.5-0.05)*fs/1e6]+center_freq/1e6)


IQ_data_phantom_4 = phantom_4_IQ_raw(18900:35650);

figure
plot([0:length(IQ_data_phantom_4)-1]*period_ms, real(IQ_data_phantom_4))
hold on
plot([0:length(IQ_data_phantom_4)-1]*period_ms,imag(IQ_data_phantom_4))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of the Phantom 4 Signal');

figure
plot((-0.5:1/fftsize:0.5-1/fftsize)*fs/1e6+center_freq/1e6,fftshift(20*log10(abs(fft(IQ_data_phantom_4,fftsize)))),'linewidth',2)
xlabel('Frequency (MHz)')
ylabel('Magnitude (dB)')
title('Spectrum of the Phantom 4 Signal');

fclose(fileID);
clear phantom_4_IQ_raw;
clear phantom_4_bin;

%% mro900 GCS data
fileID = fopen("drone_IQ_mro900_fs_5e6_fc_920073e3_GCS.dat",'r');
mro900_GCS_bin = fread(fileID,100000000,'float');

center_freq = 920073e3;

mro900_GCS_IQ_raw = (mro900_GCS_bin(1:2:end) + j*mro900_GCS_bin(2:2:end));

figure
plot([0:length(mro900_GCS_IQ_raw)-1]*period_ms,real(mro900_GCS_IQ_raw))
hold on
plot([0:length(mro900_GCS_IQ_raw)-1]*period_ms,imag(mro900_GCS_IQ_raw))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of Raw mro900 GCS Capture');

figure
spectrogram(mro900_GCS_IQ_raw,hamming(fftsize),0,(-0.5:1/fftsize:0.5-1/fftsize)*fs+center_freq,fs)
title('Spectrogram of Raw mro900 GCS Capture');

IQ_data_mro900_GCS = mro900_GCS_IQ_raw(1424650:1469750);

figure
plot([0:length(IQ_data_mro900_GCS)-1]*period_ms, real(IQ_data_mro900_GCS))
hold on
plot([0:length(IQ_data_mro900_GCS)-1]*period_ms,imag(IQ_data_mro900_GCS))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of the mro900 GCS Signal');

figure
plot((-0.5:1/fftsize:0.5-1/fftsize)*fs/1e6+center_freq/1e6,fftshift(20*log10(abs(fft(IQ_data_mro900_GCS,fftsize)))),'linewidth',2)
xlabel('Frequency (MHz)')
ylabel('Magnitude (dB)')
title('Spectrum of the IQ data mro900 GCS Signal');


fclose(fileID);
clear mro900_GCS_IQ_raw;
clear mro900_GCS_bin;

%% mro900 TEL data
fileID = fopen("drone_IQ_mro900_fs_5e6_fc_920e6_TEL.dat",'r');
mro900_TEL_bin = fread(fileID,100000000,'float');

center_freq = 920e6;

mro900_TEL_IQ_raw = (mro900_TEL_bin(1:2:end) + j*mro900_TEL_bin(2:2:end));

figure
plot([0:length(mro900_TEL_IQ_raw)-1]*period_ms,real(mro900_TEL_IQ_raw))
hold on
plot([0:length(mro900_TEL_IQ_raw)-1]*period_ms,imag(mro900_TEL_IQ_raw))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of Raw mro900 TEL Capture');

figure
spectrogram(mro900_TEL_IQ_raw,hamming(fftsize),0,(-0.5:1/fftsize:0.5-1/fftsize)*fs+center_freq,fs)
title('Spectrogram of Raw mro900 TEL Capture');

IQ_data_mro900_TEL = mro900_TEL_IQ_raw(1750000:2300000);

figure
plot([0:length(IQ_data_mro900_TEL)-1]*period_ms, real(IQ_data_mro900_TEL))
hold on
plot([0:length(IQ_data_mro900_TEL)-1]*period_ms,imag(IQ_data_mro900_TEL))
xlabel('Time (ms)')
ylabel('Amplitude')
title('Time Series of the mro900 TEL Signal');

figure
plot((-0.5:1/fftsize:0.5-1/fftsize)*fs/1e6+center_freq/1e6,fftshift(20*log10(abs(fft(IQ_data_mro900_TEL,fftsize)))),'linewidth',2)
xlabel('Frequency (MHz)')
ylabel('Magnitude (dB)')
title('Spectrum of the IQ data mro900 TEL Signal');


fclose(fileID);
clear mro900_TEL_IQ_raw;
clear mro900_TEL_bin;

