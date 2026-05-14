close all; clear; clc;

wSize1 = 24;
wSize2 = 48;
hSize  = 1;
wSizes = wSize1:2 * hSize:wSize2;
fe     = 50;
tol    = 0.5;
nFFT   = 2^16;

h1RefFileList = dir(fullfile('H1_ref_one_day', '*.wav'));
for i = 1:length(h1RefFileList)
    clc;
    currentFileName = h1RefFileList(i).name;
    fullPath = fullfile(h1RefFileList(i).folder, currentFileName);
    fprintf('\n ENF estimating: %s\n', currentFileName);
    [x, fsR] = audioread(fullPath);
    h1RefOneDayENF{i, 1} = enfEstimationN(x, wSize, hSize, fe, nFFT, tol, fsR);
    clear x;
end

h1FileList = dir(fullfile('H1', '*.wav'));
for i = 1:length(h1FileList)
    clc;
    currentFileName = h1FileList(i).name;
    fullPath = fullfile(h1FileList(i).folder, currentFileName);
    fprintf('\n%s ENF estimating. \n', currentFileName);
    [x, fsH] = audioread(fullPath);
    X = filterN(x, fsH, fsR, 2 * fe, tol);
    clear x;
    h1ENF{i, 1} = enfEstimationC(X, wSizes, hSize, 2 * fe, nFFT, tol, fsR) / 2;
    clear X;
end

load("refIndex.mat"); load("refPoints.mat");
m = 1; timeShift = 30;
for i = 1:length(h1ENF)
    fprintf('\n Calculating: %d\n', i);
    corrM = normxcorr2(h1ENF{i, 1}, h1RefOneDayENF{refIndex(i, 1), 1});
    [refPointsN(i, 1), refPointsN(i, 2)] = max(corrM((length(h1ENF{i, 1}) - (wSize2 - wSize1) / 2):end - length(h1ENF{i, 1}) + 1));
    clear corrM;
    if abs((refPoints(i, 2) / hSize) - refPointsN(i, 2)) >= timeShift / hSize
        unMatchN(m) = i;
        m = m + 1;
    end
    clc;
end

fprintf('\n Accuracy: %f / 100 \n', (length(h1ENF) - m) * 100 / length(h1ENF));