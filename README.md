
    ENF-Based Audio Time-of-Recording Detection

  This repository contains the dataset, source codes, and experimental frameworks developed for our studies on Electric Network Frequency (ENF)-based audio forensic analysis, particularly focusing on time-of-recording verification and detection.

  The studies investigate how ENF traces embedded in audio recordings can be exploited for digital media forensics and how Short-Time Fourier Transform (STFT)-based ENF estimation performance can be improved through parameter optimization and enhanced segmentation strategies.

  The repository accompanies the following publications:
    1. The Effect of Short-Time Fourier Transform Parameters Choice on ENF-based Forensic Analysis of Audio
    2. An Enhanced STFT Segmentation Framework for ENF-Based Media Forensics

  Overview
Electric Network Frequency (ENF) is the instantaneous frequency fluctuation of mains electricity around its nominal value (50 Hz or 60 Hz), caused by continuous imbalances between electricity generation and consumption. These fluctuations unintentionally become embedded into audio and video recordings through electromagnetic interference, acoustic hum, or mains-powered illumination.
Because ENF variations are temporally correlated across an interconnected power grid, ENF signals extracted from media recordings can be compared against ground-truth ENF reference databases to estimate or verify the recording time of a media file. This makes ENF a powerful tool for:
Time-of-recording verification
Media authentication and integrity analysis
Tampering detection
Multimedia synchronization
Geolocation estimation
Digital media forensics research
Research Contributions

This repository includes implementations of the methodologies proposed in our studies, including:
Conventional STFT-based ENF estimation
Analysis of STFT window and hop size selection
Adaptive STFT segmentation strategies
ENF extraction from audio recordings
Correlation-based time-of-recording verification
Experimental evaluation on the ENF-WHU dataset
The proposed enhanced segmentation framework increases the number of ENF samples that can be estimated from a given recording by introducing adaptive anterior and posterior STFT segments. This produces longer and more distinctive ENF signals, improving forensic reliability, especially for short-duration recordings.

Repository Contents
  The repository may include:
    ENF estimation algorithms
    MATLAB and/or Python implementations
    Experimental scripts
    Dataset organization tools
    STFT segmentation frameworks
    Evaluation and benchmarking scripts
    Example audio and reference ENF data
    Reproducibility materials for published experiments

  Applications
    The provided framework can be used for:
    Academic ENF research
    Digital audio forensic analysis
    Media timestamp verification
    Benchmarking ENF estimation techniques
    Testing STFT parameter optimization strategies
    Developing robust ENF extraction pipelines

Citation

  [1] C. Grigoras “Digital audio recording analysis–the electric network frequency criterion”, International Journal Speech Language Law, vol. 12, no. 1, pp. 63–76, 2005.

  [2] C. Grigoras, “Applications of ENF criterion in forensic audio, video, computer and telecommunication analysis,” Forensic Sci. Int., vol. 167, nos. 2–3, pp. 136–145, Apr. 2007.

  [3] A. Cooper, “The electric network frequency (ENF) as an aid to authenticating forensic digital audio recordings–an automated approach”, Audio Engineering Society Conference, pp. 1–10, 2008.

  [4] G. Hua and H. Zhang “ENF signal enhancement in audio recordings”, IEEE Transactions on Information Forensics and Security, vol. 15, pp. 1868–1878, 2020.

  [5] G. Hua, H. Liao, H. Zhang, D. Ye, and J. Ma “Robust ENF estimation based on harmonic enhancement and maximum weight clique”, IEEE Transactions on Information Forensics and Security, vol. 16, pp. 3874–3887, 2021.

  [6] A. Berk Yalinkilic and S. Vatansever, "An Enhanced STFT Segmentation Framework for ENF-Based Media Forensics," in IEEE Access, vol. 12, pp. 117850-117862, 2024, doi: 10.1109/ACCESS.2024.3449099.

  [7] A. Berk Yalinkilic and S. Vatansever, “The Effect of Short-Time Fourier Transform Parameters Choice on ENF-based Forensic Analysis of Audio”, Müh.Bil.ve Araş.Dergisi, c. 5, sy 1, ss. 79–87, Nis. 2023, doi: 10.46387/bjesr.1246180.

  https://github.com/ghua-ac/ENF-WHU-Dataset/tree/master/ENF-WHU-Dataset

Disclaimer
  This repository is intended for academic and research purposes only. The provided methods and datasets should be used responsibly and in accordance with applicable ethical and legal regulations regarding digital forensic investigations.

