function f = analyzePipeline(audiodata, nfft, fs)
    s = specgram(audiodata, nfft, fs, hanning(511), 380);
    absolute = transpose(abs(s));
    a = sum(absolute);
    a_norm = (a-min(a))/(max(a)-min(a));
    f = transpose(a_norm);
end
