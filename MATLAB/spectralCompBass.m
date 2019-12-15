clear all; clc; close all;

[Yref, Fs1] = audioread('../audio_data/bassFiltered_5.46s_192kHz_32bit_stereo.wav');
[Y10to1SASR, Fs2] = audioread('../audio_data/bassFiltered_5.46s_192kHz_32bit_stereo_Distressor10-1_SASR.wav');

WINDOW=[];
NOVERLAP=[];
NFFT=2^20;

[Txy1, F1] = tfestimate(Yref(:,1), Y10to1SASR(1:length(Yref),1), WINDOW, NOVERLAP, NFFT, Fs1);

[Pxx1, F2] = pwelch(Yref(:,1), WINDOW, NOVERLAP, NFFT, Fs1);
[Pxx2, F3] = pwelch(Y10to1SASR(:,1), WINDOW, NOVERLAP, NFFT, Fs2);


%%
close all
figure,loglog(F1,abs(Txy1))
legend('Bass Filtered')
xlim([F1(1) F1(end)])


figure,loglog(F1,abs(Txy1))
legend('Bass Filtered')
xlim([F1(1) 20000])

figure,semilogy(F2,Pxx1,F3,Pxx2)
xlim([F2(1) 3000])

figure,plot(1:length(Yref), Yref(:,1), 1:length(Y10to1SASR), Y10to1SASR(:,1))