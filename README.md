# UAD Plugins Testing

## Generating white-noise

- `Fs = 192000` Hz
- `duration: 4` seconds
- `nextP2 = nextpow2(Fs*duration)`
- `Nsample = 2^nextP2`
- `seedX = randn(Nsample,1)`
- `normX = seedX/max(abs(seedX))`

## Generating filtered white-noise (for bass test)

```matlab
bpFilt = designfilt('bandpassfir', 'FilterOrder', 4000, ...
    'CutoffFrequency1',100, 'CutoffFrequency2',200,...
    'SampleRate', Fs);
y=filter(bpFilt, normX);
```

## Estimation of transfer function from measured data

### Estimation function

```python
def tfestimate(x, y, *args, **kwargs):
    """estimate frequency response function from x to y"""
    F, Pxy = signal.csd(x, y, *args, **kwargs)
    _, Pxx = signal.welch(x, *args, **kwargs)
    print(len(Pxy))
    Txy = [0] * (len(Pxy))
    for i in range(len(Pxy)-1):
        Txy[i] = Pxy[i]/Pxx[i]
    return Txy, F
```

