clear all; clc; close all;

Fs=192000;

%%
% Generating white noise
duration = 4; % second
nextP2 = nextpow2(Fs*duration);
Nsample = 2^nextP2;
seedX = randn(Nsample,1);
normX = seedX/max(abs(seedX));

%%
bpFilt = designfilt('bandpassfir', 'FilterOrder', 4000, ...
    'CutoffFrequency1',100, 'CutoffFrequency2',200,...
    'SampleRate', Fs);
y=filter(bpFilt, normX);

% [Pxx, F] = pwelch(y, [], [], Nsample, Fs);
% 
% figure,semilogy(F,Pxx)

audiowrite('bassFiltered_5.46s_192kHz_32bit_stereo.wav',[y, y],Fs,'BitsPerSample',32);