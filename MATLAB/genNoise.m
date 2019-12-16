clc; close all;

Fs=192000;

%%
% Generating white noise
duration = 4; % second
nextP2 = nextpow2(Fs*duration);
Nsample = 2^nextP2;
seedX = randn(Nsample,1);
normX = seedX/max(abs(seedX));

audiowrite('../audio_data/white_noise_5.46s_192kHz_32bit_stereo.wav',[normX, normX],Fs,'BitsPerSample',32);
audiowrite('../audio_data/white_noise_5.46s_192kHz_32bit_mono.wav',normX,Fs,'BitsPerSample',32)

%%
% Generating interval white noise
duration = 2; % second
release = 0.5; % second
