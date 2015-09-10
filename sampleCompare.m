       
function [sampleWord, errorvector] = sampleCompare(correctAnswer, fs, nfft, referenceRed1, referenceRed2, referenceRed3, referenceRed4, referenceRed5, referenceRed6,...
    referenceYellow1, referenceYellow2, referenceYellow3, referenceYellow4, referenceYellow5, referenceYellow6,...
    referenceGreen1, referenceGreen2, referenceGreen3, referenceGreen4, referenceGreen5, referenceGreen6,...
    referenceBlue1, referenceBlue2, referenceBlue3, referenceBlue4, referenceBlue5, referenceBlue6)
color1 = 'red';
color2 = 'yellow';
color3 = 'green';
color4 = 'blue';
%%%%%%%%%%%%%%%%%%%%%%%%%%

v=audiorecorder(fs, 16, 1);
record(v)
fprintf(['Say ' correctAnswer '\n']);
WaitSecs(2)
stop(v)
voicedata=getaudiodata(v)-mean(getaudiodata(v));
%%%%%%%%%%%%%% use specgram to get the signals spectrom information in
%%%%%%%%%%%%%% frequency domain

voice = analyzePipeline(voicedata, nfft, fs);

errorsRed1 = errorCompare(referenceRed1, voice);
errorsRed2 = errorCompare(referenceRed2, voice);
errorsRed3 = errorCompare(referenceRed3, voice);
errorsRed4 = errorCompare(referenceRed4, voice);
errorsRed5 = errorCompare(referenceRed5, voice);
errorsRed6 = errorCompare(referenceRed6, voice);
errorsGreen1 = errorCompare(referenceGreen1, voice);
errorsGreen2 = errorCompare(referenceGreen2, voice);
errorsGreen3 = errorCompare(referenceGreen3, voice);
errorsGreen4 = errorCompare(referenceGreen4, voice);
errorsGreen5 = errorCompare(referenceGreen5, voice);
errorsGreen6 = errorCompare(referenceGreen6, voice);
errorsYellow1 = errorCompare(referenceYellow1, voice);
errorsYellow2 = errorCompare(referenceYellow2, voice);
errorsYellow3 = errorCompare(referenceYellow3, voice);
errorsYellow4 = errorCompare(referenceYellow4, voice);
errorsYellow5 = errorCompare(referenceYellow5, voice);
errorsYellow6 = errorCompare(referenceYellow6, voice);
errorsBlue1 = errorCompare(referenceBlue1, voice);
errorsBlue2 = errorCompare(referenceBlue2, voice);
errorsBlue3 = errorCompare(referenceBlue3, voice);
errorsBlue4 = errorCompare(referenceBlue4, voice);
errorsBlue5 = errorCompare(referenceBlue5, voice);
errorsBlue6 = errorCompare(referenceBlue6, voice);

errorvector = [errorsRed1 errorsRed2 errorsRed3 errorsRed4 errorsRed5  errorsRed6...
    errorsGreen1 errorsGreen2 errorsGreen3 errorsGreen4 errorsGreen5 errorsGreen6...
    errorsYellow1 errorsYellow2 errorsYellow3 errorsYellow4 errorsYellow5 errorsYellow6...
    errorsBlue1 errorsBlue2 errorsBlue3  errorsBlue4  errorsBlue5  errorsBlue6];


errorvectorindex = find(errorvector == min(errorvector));
if errorvectorindex < 7
    %disp(['Red']);
    sampleWord = 1;
elseif errorvectorindex < 13
    %disp(['Green']);
    sampleWord = 2;
elseif errorvectorindex <19
    %disp(['Yellow']);
    sampleWord = 3;
elseif errorvectorindex <25
    %disp(['Blue']);
    sampleWord = 4;
end
% errormeans = [mean(errorvector(1:6)), mean(errorvector(7:12)), mean(errorvector(13:18)), mean(errorvector(19:24))];
% sampleWord = find(errormeans == min(errormeans));
end


