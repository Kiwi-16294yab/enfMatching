import numpy as np
from scipy.signal.windows import hann

def enfEstimationN(X, wSize, hSize, fe, sizeWithZeros, tol, fs):

    xl         = len(X)
    loop_count = int((xl / fs - wSize) / hSize + 1)
    qENF       = np.zeros((loop_count, 1))

    for i in range(loop_count):
        start_idx = int(i * hSize * fs)
        end_idx   = int(i * hSize * fs + wSize * fs)

        segment = X[start_idx:end_idx]
        segment = segment * hann(int(fs * wSize))

        N = int(sizeWithZeros - wSize * fs)

        fft_input = np.concatenate([segment, np.zeros(N)])

        WhzFM = np.abs(np.fft.fft(fft_input))

        fl1 = int(round((fe - tol) * sizeWithZeros / fs))
        fl2 = int(round((fe + tol) * sizeWithZeros / fs))

        local_index = np.argmax(WhzFM[fl1:fl2+1])
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

        qENF[i, 0] = xx * fs / sizeWithZeros
    return qENF