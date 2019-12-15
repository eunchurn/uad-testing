from scipy import signal
import numpy as np
import soundfile as sf
import matplotlib.pyplot as plt
# from matplotlib.mlab import psd, csd


def tfestimate(x, y, *args, **kwargs):
    """estimate frequency response function from x to y"""
    F, Pxy = signal.csd(x, y, *args, **kwargs)
    _, Pxx = signal.welch(x, *args, **kwargs)
    print(len(Pxy))
    Txy = [0] * (len(Pxy))
    for i in range(len(Pxy)-1):
        Txy[i] = Pxy[i]/Pxx[i]
    return Txy, F


Yref, Fs = sf.read("audio_data/white_noise_5.46s_192kHz_32bit_stereo.wav")
Y1to1, Fs2 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor1-1.wav')
Y2to1, Fs3 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor2-1.wav')
Y10to1, Fs4 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1.wav')
Y10to1FAFR, Fs5 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1_FAFR.wav')
Y10to1SAFR, Fs6 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1_SAFR.wav')
Y10to1SASR, Fs7 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor10-1_SASR.wav')
Y1176Default, Fs8 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_1176_Rev_A_default.wav')
YAPI2500Default, Fs9 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_API2500_default.wav')
YSSL_E_default, Fs10 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_SSL_E_default.wav')
YBypass, Fs11 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_bypass.wav')
YNeve_33609SE_default, Fs12 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Neve_33609SE_default.wav')
YNeve_33609SE_6to1, Fs13 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Neve_33609SE_6to1_gain_matched.wav')
YNeve_1073_default, Fs14 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Neve_1073_default.wav')
YDistressor_opt_reduction_1to6_gain_matched, Fs15 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor_Opto_Reduction_1-6_gain_matched.wav')
YDistressor_opt_reduction_6to12_gain_matched, Fs15 = sf.read(
    'audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor_Opto_Reduction_6-12_gain_matched.wav')
YBassRef, _ = sf.read('audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor_Opto_Bass_C1_bypass.wav')
YBass_dist_opto, _ = sf.read('audio_data/white_noise_5.46s_192kHz_32bit_stereo_Distressor_Opto_Bass_C1.wav')

Txy1to1, F1 = tfestimate(
    YBassRef[:, 0], YBass_dist_opto[:, 0], fs=Fs, window="hann", nperseg=2**14)

fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(14, 9))

axes[0].semilogy(F1, np.abs(Txy1to1), "k", linewidth=0.5)
axes[1].plot(F1, np.angle(Txy1to1, deg=True), "k", linewidth=0.5)
axes[0].set_ylabel("Magnitude")
axes[0].set_xlabel("Frequency (Hz)")
axes[0].set_xlim([F1[1], F1[-1]])
axes[1].set_xlim([F1[1], F1[-1]])
# axes[0].set_xlim([F1[1], 1000])
# axes[1].set_xlim([F1[1], 1000])
axes[1].set_ylabel("Phase angle (degree)")
axes[1].set_xlabel("Frequency (Hz)")
axes[0].grid(color='b', linestyle='--', linewidth=0.1)
axes[1].grid(color='b', linestyle='--', linewidth=0.1)
plt.show()
