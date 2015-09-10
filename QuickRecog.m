
ntrials = 20;
color1 = 'red';
color2 = 'yellow';
color3 = 'green';
color4 = 'blue';
colors = {color1 color2 color3 color4};

accuracy = zeros(1, ntrials*4);
fs=16000; %sampling frequency, in 1 second take 16000 samples
duration=2; %recording time
%end
[nfft, referenceRed1, referenceRed2, referenceRed3, referenceRed4, referenceRed5, referenceRed6,...
    referenceYellow1, referenceYellow2, referenceYellow3, referenceYellow4, referenceYellow5, referenceYellow6,...
    referenceGreen1, referenceGreen2, referenceGreen3, referenceGreen4, referenceGreen5, referenceGreen6,...
    referenceBlue1, referenceBlue2, referenceBlue3, referenceBlue4, referenceBlue5, referenceBlue6] =...
    recordReferences(fs, color1, color2, color3, color4);
i = [ones(1, ntrials) 2*ones(1,ntrials) 3*ones(1,ntrials) 4*ones(1,ntrials)];
ii = randperm(ntrials*4);
for iii = 1:length(ii)
    correctWordNumber = i(ii(iii));
[sampleWord, errorvector]=sampleCompare(colors{correctWordNumber}, fs, nfft,...
    referenceRed1, referenceRed2, referenceRed3, referenceRed4, referenceRed5, referenceRed6,...
    referenceYellow1, referenceYellow2, referenceYellow3, referenceYellow4, referenceYellow5, referenceYellow6,...
    referenceGreen1, referenceGreen2, referenceGreen3, referenceGreen4, referenceGreen5, referenceGreen6,...
    referenceBlue1, referenceBlue2, referenceBlue3, referenceBlue4, referenceBlue5, referenceBlue6);
if min(errorvector) > 10
    disp('too much error');
elseif sampleWord == correctWordNumber
disp('Correctomundo!');
accuracy(iii) = 1;
else disp('Wroooooong!');
%function save(obj)
 %           % Saves the data structure variables into a file we can access
  %          blockData = blockData;
   %         save([directory saveName], 'blockData');    
end
end
 
