function X = filterN(h1_data, fsh, fs, fe, tol);

X1  = decimate(h1_data, fsh/fs);

d1  = fdesign.lowpass('N,Fc', fe, fe + tol, fs);
Hd1 = butter(d1);
d2  = fdesign.highpass('N,Fc', fe, fe - tol, fs);
Hd2 = butter(d2);

X2  = filter(Hd1,X1);
X   = filter(Hd2,X2);

end