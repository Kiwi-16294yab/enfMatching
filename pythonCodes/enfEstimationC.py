import numpy as np
from scipy.signal.windows import hann

def enfEstimationC(X, wSizes, hSize, fe, sizeWithZeros, tol, fs):
    xl   = len(X)
    qENF = []

    def estimate_enf(segment, win_size):
        N = int(sizeWithZeros - win_size * fs)

        fft_input = np.concatenate([segment * hann(int(fs * win_size)), np.zeros(N)])
        WhzFM     = np.abs(np.fft.fft(fft_input))
        nFFT      = len(WhzFM)

        fl1 = int(round((fe - tol) * nFFT / fs))
        fl2 = int(round((fe + tol) * nFFT / fs))

        local_index = np.argmax(WhzFM[fl1:fl2 + 1])
        I           = local_index + fl1

        x0 = I - 1
        x1 = I
        x2 = I + 1

        f0 = WhzFM[I - 1]
        f1 = WhzFM[I]
        f2 = WhzFM[I + 1]

        a0 = f0 / ((x0 - x1) * (x0 - x2))
        a1 = f1 / ((x1 - x0) * (x1 - x2))
        a2 = f2 / ((x2 - x0) * (x2 - x1))

        AA = a0 + a1 + a2
        BB = -(a0 * (x1 + x2) + a1 * (x0 + x2) + a2 * (x0 + x1))
        xx = -BB / (2 * AA)
        return xx * fs / nFFT

    for i in range(len(wSizes) - 1):
        win_size = wSizes[i]
        end_idx  = int(win_size * fs)
        segment  = X[0:end_idx]
        enf      = estimate_enf(segment, win_size)
        qENF.append(enf)

    last_wsize = wSizes[-1]
    loop_count = int((xl / fs - last_wsize) / hSize + 1)

    for i in range(loop_count):
        start_idx = int(i * hSize * fs)
        end_idx   = int(i * hSize * fs + last_wsize * fs)
        segment   = X[start_idx:end_idx]
        enf       = estimate_enf(segment, last_wsize)
        qENF.append(enf)

    for i in range(len(wSizes) - 2, -1, -1):
        win_size  = wSizes[i]
        start_idx = int(xl - win_size * fs)
        segment   = X[start_idx:xl]
        enf       = estimate_enf(segment, win_size)
        qENF.append(enf)

    return np.array(qENF).reshape(-1, 1)