
function errors = errorCompare(reference, voice)
[x, lag] = xcorr(voice, reference);
[mx, indicex] =max(x);
frequencyShift = lag(indicex);
if indicex <length(x)/2
    q = 1:(indicex-1);
    p = indicex +length(q):-1:indicex+1;
    x_left = x(q);
    x_right = x(p);
    errors = std((abs(x_right-x_left).^2));
else
    q=1+frequencyShift*2:indicex-1;
    p=length(x):-1:indicex+1;
    x_left=x(q);
    x_right=x(p);
    errors = std((abs(x_right-x_left)).^2);
end


end
