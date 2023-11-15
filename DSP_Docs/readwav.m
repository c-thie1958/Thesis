function [fVec, tVec, Sxx, finfo] = readwav(fpath,fname, Nfft)

fhandle = fullfile(fpath,fname);
finfo   = audioinfo(fhandle);

[x, Fs]   = audioread(fhandle);

x = x(:,1) + 1i*x(:,2);

Nwin    = Nfft/2;
window  = hamming(Nwin);
nov     = Nfft/4;
[Sxx, fVec, tVec] = spectrogram(x,window,nov,Nfft,Fs);

Sxx = 10*log10(abs(Sxx));
imagesc(tVec,fVec,Sxx);
colorbar
xlabel('Time (s)')
ylabel('Frequency (Hz)')
