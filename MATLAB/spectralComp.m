clear all; clc; close all;

[Yref, Fs1] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo.wav');
[Y1to1, Fs2] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor1-1.wav');
[Y2to1, Fs3] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor2-1.wav');
[Y10to1, Fs4] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1.wav');
[Y10to1FAFR, Fs5] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1_FAFR.wav');
[Y10to1SAFR, Fs6] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1_SAFR.wav');
[Y10to1SASR, Fs7] = audioread('../audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1_SASR.wav');

WINDOW=[];
NOVERLAP=[];
NFFT=2^20;

[Txy1, F1] = tfestimate(Yref(:,1), Y1to1(:,1), WINDOW, NOVERLAP, NFFT, Fs2);
[Txy2, F2] = tfestimate(Yref(:,1), Y2to1(:,1), WINDOW, NOVERLAP, NFFT, Fs3);
[Txy3, F3] = tfestimate(Yref(:,1), Y10to1(:,1), WINDOW, NOVERLAP, NFFT, Fs4);
[Txy4, F4] = tfestimate(Yref(:,1), Y10to1FAFR(:,1), WINDOW, NOVERLAP, NFFT, Fs5);
[Txy5, F5] = tfestimate(Yref(:,1), Y10to1SAFR(:,1), WINDOW, NOVERLAP, NFFT, Fs6);
[Txy6, F6] = tfestimate(Yref(:,1), Y10to1SASR(:,1), WINDOW, NOVERLAP, NFFT, Fs7);

%%
close all
figure,semilogy(F1,abs(Txy1),'-', F2, abs(Txy2),'-', F3, abs(Txy3),'--', F4, abs(Txy4),':', F5, abs(Txy5),'.:', F6, abs(Txy6),':')
legend('Distressor 1:1','Distressor 2:1','Distressor 10:1(opto)','Distressor 10:1(opto) FAFR','Distressor 10:1(opto) SAFR','Distressor 10:1(opto) SASR')
xlim([F1(1) F1(end)])

figure,semilogy(F1,abs(Txy1),'-', F2, abs(Txy2),'-', F3, abs(Txy3),'--', F4, abs(Txy4),':', F5, abs(Txy5),'.:', F6, abs(Txy6),':')
legend('Distressor 1:1','Distressor 2:1','Distressor 10:1(opto)','Distressor 10:1(opto) FAFR','Distressor 10:1(opto) SAFR','Distressor 10:1(opto) SASR')
xlim([F1(1) 20000])

figure, spectrogram(Y10to1SASR(:,1), 2^14, 2^10, F5, Fs1);
