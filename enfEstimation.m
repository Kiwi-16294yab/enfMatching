function enf_audio = enfEstimation(samples_audio,Fs_audio,frequencies,STFT_window_size_factor,hop_size_factor)

% [samples_audio,Fs_audio]=audioread(query_file);

divisors_Fs = divisor(Fs_audio);
fs_audio = min(divisors_Fs(divisors_Fs>300));

samples_audio2=mean(samples_audio,2);

d_rate=round(Fs_audio/fs_audio);
samples_audio2_decimated=decimate(samples_audio2,d_rate);

f_i = 0;
for f_ENF=frequencies
    f_i = f_i+1;
    
    d1 = fdesign.lowpass('N,Fc',100,f_ENF+0.5,fs_audio);
    Hd1=butter(d1);
    d2 = fdesign.highpass('N,Fc',100,f_ENF-0.5,fs_audio);
    Hd2=butter(d2);
    
    y1 = filter(Hd1,samples_audio2_decimated);
    y2 = filter(Hd2,y1);
    
    i=0;
    h=1;
    hop_size=hop_size_factor*fs_audio;
    window_length=STFT_window_size_factor*fs_audio;
    while h+window_length-1<=length(y2)
        i=i+1;
        x(:,i)=y2(h:h+window_length-1);
        h=h+hop_size;
    end
    
    N = 2^14;
    while N<=window_length*3
        N = N*2;
    end
    zero_t=transpose(zeros(1, (N-window_length)));
    delta=fs_audio/N;
    
%     y=ones(N,i);
%     X=ones(N,i);
%     X_mag=ones(N,i);
%     C=ones(1,i);
%     I=ones(1,i);
    
    f_l = f_ENF - 0.5;
    f_l = round(f_l*N/fs_audio);
    
    f_h = f_ENF + 0.5;
    f_h = round(f_h*N/fs_audio);
    
    for k=1:i
        x(:,k)=x(:,k).*hanning(length(x(:,k)));
%         y(:,k)=[x(:,k) ; zero_t];
%         X(:,k)=fft(y(:,k));
%         X_mag(:,k)=abs(X(:,k));
%         
% %         [C(k),I(k)] = max(X_mag(:,k));
%         [C(k),I(k)] = max(X_mag(f_l:f_h,k));
%         I(k) = I(k) + f_l-1;
%         
%         x0=I(k)-1;
%         x1=I(k);
%         x2=I(k)+1;
% %         xm=x0:delta/1000:x2-delta/1000;
%         f0=X_mag(I(k)-1,k);
%         f1=X_mag(I(k),k);
%         f2=X_mag(I(k)+1,k);


        y(:,1)=[x(:,k) ; zero_t];
        X(:,1)=fft(y(:,1));
        X_mag(:,1)=abs(X(:,1));
        
%         [C(k),I(k)] = max(X_mag(:,k));
        [C, I] = max(X_mag(f_l:f_h,1));
        I = I + f_l-1;
        
        x0=I-1;
        x1=I;
        x2=I+1;
%         xm=x0:delta/1000:x2-delta/1000;
        f0=X_mag(I-1,1);
        f1=X_mag(I,1);
        f2=X_mag(I+1,1);
        a0=f0/((x0-x1)*(x0-x2));
        a1=f1/((x1-x0)*(x1-x2));
        a2=f2/((x2-x0)*(x2-x1));
        
%         f=a0.*(xm-x1).*(xm-x2)+a1.*(xm-x0).*(xm-x2)+a2.*(xm-x0).*(xm-x1);
%         [M(k),B(k)]=max(f);
%         ENF(k,1)=((B(k)*(delta/1000)+x0)*fs_audio)/N;
        AA=a0+a1+a2;
        BB=-(a0*(x1+x2)+a1*(x0+x2)+a2*(x0+x1));
        xx=-BB/(2*AA);
        ENF(k,1)=xx*fs_audio/N;
    end
    enf_audio(:,f_i) = ENF;
    
    %             ENF = filloutliers(ENF,'linear');
    
end
end

