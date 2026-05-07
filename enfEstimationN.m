function qENF = enfEstimationN(X, wSize, hSize, fe, sizeWithZeros, tol, fs);
xl  = length(X);

%% Estimation
for i = 1:(xl/fs - wSize)/hSize + 1;
    N           = sizeWithZeros - wSize*fs;
    WhzFM       = abs(fft([X((i - 1)*hSize*fs + 1:(i - 1)*hSize*fs + wSize*fs).*hann(fs*wSize); zeros(N, 1)]));

    fl1 = round((fe - tol)*sizeWithZeros/fs);
    fl2 = round((fe + tol)*sizeWithZeros/fs);

    [C, I] = max(WhzFM(fl1:fl2, 1));
    I = I + fl1 - 1;

    x0 = I - 1;
    x1 = I;
    x2 = I + 1;

    f0 = WhzFM(I - 1, 1);
    f1 = WhzFM(I, 1);
    f2 = WhzFM(I + 1, 1);
    a0 = f0/((x0 - x1)*(x0 - x2));
    a1 = f1/((x1 - x0)*(x1 - x2));
    a2 = f2/((x2 - x0)*(x2 - x1));

    AA = a0 + a1 + a2;
    BB = -(a0*(x1 + x2) + a1*(x0 + x2) + a2*(x0 + x1));
    xx = -BB/(2*AA);
    qENF(i, 1) = xx*fs/sizeWithZeros;
end

end
