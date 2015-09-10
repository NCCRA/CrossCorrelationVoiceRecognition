%% Abby's super hacky voice recognition code for 4 possible stimuli

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

%% Credit to Tingxiao Yang for the cross-correlation algorithm

%% Step 1%%%
clear;
color1 = 'red';
color2 = 'yellow';
color3 = 'green';
color4 = 'blue';

fs=16000; %sampling frequency
duration=2; %recording time
%duration*fs: the length of the recorded data: take 2*fs samples need 2 seconds
%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('You need to speak loudly and quickly when the program says: Say [a color] \n');
WaitSecs(5);

red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r1=getaudiodata(red)-mean(getaudiodata(red));

yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y1=getaudiodata(yellow)-mean(getaudiodata(yellow));

green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
greeny1=getaudiodata(green)-mean(getaudiodata(green));

blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
bluey1=getaudiodata(blue)-mean(getaudiodata(blue));

v=audiorecorder(fs, 16, 1);
record(v)
fprintf(['Say ' color1 ', ' color2 ', ' color3 ', or ' color4 '\n']);
WaitSecs(2)
stop(v)
voice=getaudiodata(v)-mean(getaudiodata(v));

%% Step 2 %%%% use specgram to get the signals' spectogram information 
nfft = min(1023,length(r1)); %%%%%%%define our the length of STFT
% define window length and the overlap to decide the window step
s=specgram(r1, nfft, fs, hanning(511),380);
s2=specgram(y1, nfft, fs, hanning(511),380);
s3=specgram(voice, nfft, fs, hanning(511),380);
s4 = specgram(greeny1, nfft, fs, hanning(511),380);
s5 = specgram(bluey1, nfft, fs, hanning(511),380);

%% Step 3%%%
%%% s is a complex matrix. take abs value and then transpose it
absolute=transpose(abs(s)); %red
 absolute2=transpose(abs(s2)); %yellow
absolute3=transpose(abs(s3)); %voice
absolute4 = transpose(abs(s4)); %blue
absolute5 = transpose(abs(s5)); %green
%If A is a matrix, sum(A) treats the columns of A as vectors,
%returning a row vector of the sums of each column
% after transpose, the rows and columns has been swapped,
% take the summation of transposed matrix ,we get summation the time axis
% to return a frequency spectrum
%%%% get time-freuqency related spectrum
a4=sum(absolute); %red
a5=sum(absolute2); %yellow
a6=sum(absolute3); %voice
a7 = sum(absolute4); %green
a8 = sum(absolute5); %blue

%% Step 4 %%%%
%normalize spectrom and also decrease the noise
a4_norm=(a4-min(a4))/(max(a4)-min(a4)); %red
a5_norm=(a5-min(a5))/(max(a5)-min(a5)); %yellow
a6_norm=(a6-min(a6))/(max(a6)-min(a6)); %voice
a7_norm=(a7-min(a7))/(max(a7)-min(a7)); %green
a8_norm=(a8-min(a8))/(max(a8)-min(a8)); %blue
%%%%%%%%%%%%%%%%%%%%%transpose row to colume vector%%%%%%%%%%%%
F4=transpose(a4_norm); %red
F5=transpose(a5_norm); %yellow
F6=transpose(a6_norm); %voice
F7=transpose(a7_norm); %green
F8=transpose(a8_norm); %blue

%% Step 5 %%%%
%do cross-correlations
[x3,lag3]=xcorr(F6,F4); %red vs. voice
[mx3,indice3]=max(x3);
frequency_red_shift=lag3(indice3);

[x4,lag4]=xcorr(F6,F5); %yellow vs. voice
[mx4,indice4]=max(x4);
frequency_yellow_shift=lag4(indice4);

[x5,lag5]=xcorr(F6,F7); %green vs. voice
[mx5,indice5]=max(x5);
frequency_green_shift=lag5(indice5);

[x6,lag6]=xcorr(F6,F8); %blue vs. voice
[mx6,indice6]=max(x6);
frequency_blue_shift=lag6(indice6);

%% Steps 6 and 7 %%%
% 6) Find the position of the maximum value of the cross-correlation and calculate 
%    the difference between the values right of the maximum value position and 
%    the values left of the maximum value position. 
% 7) Take the absolute value of this difference and find the mean square-error 
%    of this absolute value. 
if indice3<length(x3)/2
 q=1:(indice3-1);
p=indice3+length(q):-1:indice3+1;
length(p);
length(q);
x3_left=x3(q);
min(x3_left);
x3_right=x3(p);
min( x3_right);
rederror = std((abs(x3_right-x3_left)).^2);
rederror1= mean((abs(x3_right-x3_left)).^2);
else
 q=1+frequency_red_shift*2:indice3-1;
 p=length(x3):-1:indice3+1;
 length(q);
 length(p);
 x3_left=x3(q);
 x3_right=x3(p);
 rederror = std((abs(x3_right-x3_left)).^2);
rederror1= mean((abs(x3_right-x3_left)).^2);
 end

if indice4<length(x4)/2
 q2=1:indice4-1;
p2=indice4+length(q2):-1:indice4+1;
x4_left=x4(q2);
length(q2);
length(p2);
min(x4_left);
x4_right=x4(p2);
min( x4_right);
yellowerror = std(abs(x4_right-x4_left).^2);
yellowerror2= mean((abs(x4_right-x4_left)).^2);
else
 q2=1+frequency_yellow_shift*2:indice4-1;
 p2=length(x4):-1:indice4+1;
 length(q2);
 length(p2);
 x4_left=x4(q2);
 x4_right=x4(p2);
 yellowerror = std((abs(x4_right-x4_left)).^2);
yellowerror2= mean((abs(x4_right-x4_left)).^2);
end

if indice5<length(x5)/2
 qq=1:(indice5-1);
pp=indice5+length(qq):-1:indice5+1;
length(pp);
length(qq);
x5_left=x5(qq);
min(x5_left);
x5_right=x5(pp);
min( x5_right);
greenerror = std((abs(x5_right-x5_left)).^2);
greenerror3= mean((abs(x5_right-x5_left)).^2);
else
 qq=1+frequency_green_shift*2:indice5-1;
 pp=length(x5):-1:indice5+1;
 length(qq);
 length(pp);
 x5_left=x5(qq);
 x5_right=x5(pp);
 greenerror = std(abs(x5_right-x5_left).^2);
greenerror3= mean((abs(x5_right-x5_left)).^2);
end
 
if indice6<length(x6)/2
 qqq=1:(indice6-1);
ppp=indice6+length(qqq):-1:indice6+1;
length(ppp);
length(qqq);
x6_left=x6(qqq);
min(x6_left);
x6_right=x6(ppp);
min( x6_right);
blueerror = std((abs(x6_right-x6_left)).^2);
blueerror4= mean((abs(x6_right-x6_left)).^2);
else
 qqq=1+frequency_blue_shift*2:indice6-1;
 ppp=length(x6):-1:indice6+1;
 length(qqq);
 length(ppp);
 x6_left=x6(qqq);
 x6_right=x6(ppp);
 blueerror = std((abs(x6_right-x6_left)).^2);
blueerror4= mean((abs(x6_right-x6_left)).^2);
end

 %% Step 8 %%%
 % Compare the mean square errors between the sample and the different
 % references.
disp('The lowest error reflects the best fit to the reference.');
rederror1 =rederror1
yellowerror2 =yellowerror2
greenerror3 =greenerror3
blueerror4 = blueerror4

figure(1)
hold on;
errors = [rederror yellowerror greenerror blueerror];
scatter([1 2 3 4], errors);
set(gca,'XTick',[0 1 2 3 4 5]); 
set(gca,'XTickLabel',{'','red','yellow',...
         'green', 'blue', ' '});
     ylabel('Errors (smallest error = best fit for data)');
