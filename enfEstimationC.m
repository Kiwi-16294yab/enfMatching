function qENF = enfEstimationC(X, wSizes, hSize, fe, sizeWithZeros, tol, fs);
xl     = length(X);

%% 1. Adım
k = 1;
for i = 1:length(wSizes) - 1;
    N           = sizeWithZeros - wSizes(i)*fs;
    WhzFM{k, 1} = abs(fft([X(1:wSizes(i)*fs).*hann(fs*wSizes(i)); zeros(N, 1)]));
    nFFT        = length(WhzFM{k, 1});

    fl1 = round((fe - tol)*nFFT/fs);
    fl2 = round((fe + tol)*nFFT/fs);

    [C, I] = max(WhzFM{k, 1}(fl1:fl2, 1));
    I = I + fl1 - 1;

    x0 = I - 1;
    x1 = I;
    x2 = I + 1;

    f0 = WhzFM{k, 1}(I - 1, 1);
    f1 = WhzFM{k, 1}(I, 1);
    f2 = WhzFM{k, 1}(I + 1, 1);
    a0 = f0/((x0 - x1)*(x0 - x2));
    a1 = f1/((x1 - x0)*(x1 - x2));
    a2 = f2/((x2 - x0)*(x2 - x1));

    AA = a0 + a1 + a2;
    BB = -(a0*(x1 + x2) + a1*(x0 + x2) + a2*(x0 + x1));
    xx = -BB/(2*AA);
    qENF(k, 1) = xx*fs/nFFT;
    k = k + 1;
end

%% 2. Adım
for i = 1:(xl/fs - wSizes(end))/hSize + 1;
    N           = sizeWithZeros - wSizes(end)*fs;
    WhzFM{k, 1} = abs(fft([X((i - 1)*hSize*fs + 1:(i - 1)*hSize*fs + wSizes(end)*fs).*hann(fs*wSizes(end)); zeros(N, 1)]));
    nFFT        = length(WhzFM{k, 1});

    fl1 = round((fe - tol)*nFFT/fs);
    fl2 = round((fe + tol)*nFFT/fs);

    [C, I] = max(WhzFM{k, 1}(fl1:fl2, 1));
    I = I + fl1 - 1;

    x0 = I - 1;
    x1 = I;
    x2 = I + 1;

    f0 = WhzFM{k, 1}(I - 1, 1);
    f1 = WhzFM{k, 1}(I, 1);
    f2 = WhzFM{k, 1}(I + 1, 1);
    a0 = f0/((x0 - x1)*(x0 - x2));
    a1 = f1/((x1 - x0)*(x1 - x2));
    a2 = f2/((x2 - x0)*(x2 - x1));

    AA = a0 + a1 + a2;
    BB = -(a0*(x1 + x2) + a1*(x0 + x2) + a2*(x0 + x1));
    xx = -BB/(2*AA);
    qENF(k, 1) = xx*fs/nFFT;
    k = k + 1;
end

%% 3. Adım
for i = length(wSizes) - 1:-1:1;
    N           = sizeWithZeros - wSizes(i)*fs;
    WhzFM{k, 1} = abs(fft([X(xl - wSizes(i)*fs + 1:end).*hann(fs*wSizes(i)); zeros(N, 1)]));
    nFFT        = length(WhzFM{k, 1});

    fl1 = round((fe - tol)*nFFT/fs);
    fl2 = round((fe + tol)*nFFT/fs);

    [C, I] = max(WhzFM{k, 1}(fl1:fl2, 1));
    I = I + fl1 - 1;

    x0 = I - 1;
    x1 = I;
    x2 = I + 1;

    f0 = WhzFM{k, 1}(I - 1, 1);
    f1 = WhzFM{k, 1}(I, 1);
    f2 = WhzFM{k, 1}(I + 1, 1);
    a0 = f0/((x0 - x1)*(x0 - x2));
    a1 = f1/((x1 - x0)*(x1 - x2));
    a2 = f2/((x2 - x0)*(x2 - x1));

    AA = a0 + a1 + a2;
    BB = -(a0*(x1 + x2) + a1*(x0 + x2) + a2*(x0 + x1));
    xx = -BB/(2*AA);
    qENF(k, 1) = xx*fs/nFFT;
    k = k + 1;
end

end