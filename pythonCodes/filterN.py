import numpy as np
from scipy import signal

def filterN(h1_data, fsh, fs, fe, tol):
    dec_factor = int(fsh / fs)
    X1         = signal.decimate(h1_data, dec_factor)

    low_cut  = (fe + tol) / (fs / 2)
    b1, a1   = signal.butter(N=4, Wn=low_cut, btype='low')
    high_cut = (fe - tol) / (fs / 2)
    b2, a2   = signal.butter(N=4, Wn=high_cut, btype='high')

    X2 = signal.lfilter(b1, a1, X1)
    X  = signal.lfilter(b2, a2, X2)
    return X