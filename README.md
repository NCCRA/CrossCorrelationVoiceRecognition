# CrossCorrelationVoiceRecognition
Demo code for using cross correlation for voice recognition

CrossCorrelationDemo uses 1 reference per stimulus to compare only one sample to the references.  It explains how the code works.  QuickRecog is what I'm working on now to take multiple references per simulus.  It is not done!

Copy pasted from CrossCorrelationDemo:

%% Warnings: Clearly you don't have to use 4 color words, you can use any 4 words.
% BUT this code won't work if you use too many stimuli or too similar stimuli.
% I haven't benchmarked this code yet, so I can't guarantee it has super
% high accuracy.  

%% To do:
% Working on a version that takes more than one reference
% per stimuli, which should make it more accurate. 
% Need to come up with a robust system for throwing out garbage trials
% (when the subject didn't say ANY of the stimulus words)
% Throw out trials that don't exceed background noise levels

%% Here's a high level version of what the script does:
% 1) Make reference signals and an audio recording to compare to the references.
% 2) Use “spectrogram” to process recorded signals and get a signals matrix.
% 3) Transpose the signals matrix, take sum of the matrix and get a row vector 
%    for each column summation result. This row vector is the frequency spectrum signal. 
% 4) Normalize the frequency spectrums using linear normalization. 
% 5) Do the cross-correlations of the audio recording with the reference signals.
% 6) Find the position of the maximum value of the cross-correlation and calculate 
%    the difference between the values right of the maximum value position and 
%    the values left of the maximum value position. 
% 7) Take the absolute value of this difference and find the mean square-error 
%    of this absolute value. 
% 8) The better two signals match, the cross-correlation is more symmetric. 
%    And if the cross-correlation is more symmetric, then the mean square-error 
%    should be smaller. The reference signal with the lowest mean square error 
%    is thus the best match for the comparison signal.
