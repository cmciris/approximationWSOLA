filename2 = 'C:\Users\22751\Desktop\t1.mp3';
[x, Fs] = audioread(filename2);
x = x(:,1)';

t = 30;
threshold = 0.8;

x = x(1:Fs * t);

a = 3;

y0 = wsola(x, a, 0, threshold);
bsd0 = BSD(x, y0, a, Fs)

y1 = wsola(x, a, 1, threshold);
bsd1 = BSD(x, y1, a, Fs)

y2 = wsola(x, a, 2, threshold);
bsd2 = BSD(x, y2, a, Fs)

y3 = wsola(x, a, 3, threshold);
bsd3 = BSD(x, y3, a, Fs)

y4 = wsola(x, a, 4, threshold);
bsd4 = BSD(x, y4, a, Fs)

y5 = wsola(x, a, 5, threshold);
bsd5 = BSD(x, y5, a, Fs)

audiowrite('C:\Users\22751\Desktop\t100.wav', y0, Fs);
audiowrite('C:\Users\22751\Desktop\t101.wav', y1, Fs);
audiowrite('C:\Users\22751\Desktop\t102.wav', y2, Fs);
audiowrite('C:\Users\22751\Desktop\t103.wav', y3, Fs);
audiowrite('C:\Users\22751\Desktop\t104.wav', y4, Fs);
audiowrite('C:\Users\22751\Desktop\t105.wav', y5, Fs);