function [nfft, referenceRed1, referenceRed2, referenceRed3, referenceRed4, referenceRed5, referenceRed6,...
    referenceYellow1, referenceYellow2, referenceYellow3, referenceYellow4, referenceYellow5, referenceYellow6,...
    referenceGreen1, referenceGreen2, referenceGreen3, referenceGreen4, referenceGreen5, referenceGreen6,...
    referenceBlue1, referenceBlue2, referenceBlue3, referenceBlue4, referenceBlue5, referenceBlue6] =...
    recordReferences(fs, color1, color2, color3, color4)

fprintf(['Say brown \n']);
WaitSecs(2)
fprintf(['Say brown \n']);
WaitSecs(2)

red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r1=getaudiodata(red)-mean(getaudiodata(red));

red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r2=getaudiodata(red)-mean(getaudiodata(red));
red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r3=getaudiodata(red)-mean(getaudiodata(red));
red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r4=getaudiodata(red)-mean(getaudiodata(red));
red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r5=getaudiodata(red)-mean(getaudiodata(red));
red=audiorecorder(fs, 16, 1);
record(red)
fprintf(['Say ' color1 '\n']);
WaitSecs(2)
stop(red)
r6=getaudiodata(red)-mean(getaudiodata(red));
%duration*fs: the length of the recorded data: take 2*fs samples need 2 seconds
%r=r-mean(r);
yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y1=getaudiodata(yellow)-mean(getaudiodata(yellow));
yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y2=getaudiodata(yellow)-mean(getaudiodata(yellow));
yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y3=getaudiodata(yellow)-mean(getaudiodata(yellow));
yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y4=getaudiodata(yellow)-mean(getaudiodata(yellow));
yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y5=getaudiodata(yellow)-mean(getaudiodata(yellow));
yellow=audiorecorder(fs, 16, 1);
record(yellow)
fprintf(['Say ' color2 '\n']);
WaitSecs(2)
stop(yellow)
y6=getaudiodata(yellow)-mean(getaudiodata(yellow));


green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
g1=getaudiodata(green)-mean(getaudiodata(green));
green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
g2=getaudiodata(green)-mean(getaudiodata(green));
green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
g3=getaudiodata(green)-mean(getaudiodata(green));
green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
g4=getaudiodata(green)-mean(getaudiodata(green));
green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
g5=getaudiodata(green)-mean(getaudiodata(green));
green=audiorecorder(fs, 16, 1);
record(green)
fprintf(['Say ' color3 '\n']);
WaitSecs(2)
stop(green)
g6=getaudiodata(green)-mean(getaudiodata(green));

blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
b1=getaudiodata(blue)-mean(getaudiodata(blue));
blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
b2=getaudiodata(blue)-mean(getaudiodata(blue));
blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
b3=getaudiodata(blue)-mean(getaudiodata(blue));
blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
b4=getaudiodata(blue)-mean(getaudiodata(blue));
blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
b5=getaudiodata(blue)-mean(getaudiodata(blue));
blue=audiorecorder(fs, 16, 1);
record(blue)
fprintf(['Say ' color4 '\n']);
WaitSecs(2)
stop(blue)
b6=getaudiodata(blue)-mean(getaudiodata(blue));

nfft = min(1023,length(r1));

referenceRed1 = analyzePipeline(r1, nfft, fs);
referenceRed2 = analyzePipeline(r2, nfft, fs);
referenceRed3 = analyzePipeline(r3, nfft, fs);
referenceRed4 = analyzePipeline(r1, nfft, fs);
referenceRed5 = analyzePipeline(r1, nfft, fs);
referenceRed6 = analyzePipeline(r1, nfft, fs);

referenceGreen1 = analyzePipeline(g1, nfft, fs);
referenceGreen2 = analyzePipeline(g2, nfft, fs);
referenceGreen3 = analyzePipeline(g3, nfft, fs);
referenceGreen4 = analyzePipeline(g3, nfft, fs);
referenceGreen5 = analyzePipeline(g3, nfft, fs);
referenceGreen6 = analyzePipeline(g3, nfft, fs);

referenceBlue1 = analyzePipeline(b1, nfft, fs);
referenceBlue2 = analyzePipeline(b2, nfft, fs);
referenceBlue3 = analyzePipeline(b3, nfft, fs);
referenceBlue4 = analyzePipeline(b3, nfft, fs);
referenceBlue5 = analyzePipeline(b3, nfft, fs);
referenceBlue6 = analyzePipeline(b3, nfft, fs);

referenceYellow1 = analyzePipeline(y1, nfft, fs);
referenceYellow2 = analyzePipeline(y2, nfft, fs);
referenceYellow3 = analyzePipeline(y3, nfft, fs);
referenceYellow4 = analyzePipeline(y3, nfft, fs);
referenceYellow5 = analyzePipeline(y3, nfft, fs);
referenceYellow6 = analyzePipeline(y3, nfft, fs);
end

