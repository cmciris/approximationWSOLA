filename = 'C:\Users\22751\Desktop\���°�-�����midi-9��\���°�-�����midi-9��\����ѩ\ԭ��-����ѩ-�ܽ���.mp3';
filename2 = 'C:\Users\22751\Desktop\t1.mp3';
[x, Fs] = audioread(filename2);
x = x(:,1);
y = [];
for i = 1:10
    y = [y;x];
end

audiowrite('C:\Users\22751\Desktop\t_10.wav', y(1:Fs*10), Fs);
audiowrite('C:\Users\22751\Desktop\t_30.wav', y(1:Fs*30), Fs);
audiowrite('C:\Users\22751\Desktop\t_60.wav', y(1:Fs*60), Fs);
audiowrite('C:\Users\22751\Desktop\t_300.wav', y(1:Fs*300), Fs);
audiowrite('C:\Users\22751\Desktop\t_600.wav', y(1:Fs*600), Fs);
