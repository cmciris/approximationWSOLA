function y = BSD(x1, x2, a, fs)
w = 1200; %Ö¡¿í¶È
%w2 = round(w * a);
w2 = w;
step2 = w2 / 2;
step1 = round(step2 / a);

lx1 = size(x1,2);
lx2 = size(x2,2);

m = floor((lx1-w)/step1);
m2 = floor((lx2-w2)/step2);
m = min(m, m2);

window = hamming(w)';
window2 = hamming(w2)';
b = [20 100 200 300 400 510 630 770 920 1080 1270 1480 1720 2000 2320 2700 3150 3700 4400 5300 6400 7700 9500 12000 15500];

BSD_up = 0;
BSD_down = 0;

f = zeros(1,24);
for i = 1:24
    f(i) = 10^((7-7.5*(i-0.215)-17.5*(0.196+(i-0.215)^2)^0.5)/10);
end

for i = 1:m
    %size(x1((i-1)*step1+1:(i-1)*step1+w))
    %size(window)
    if (i-1)*step1+w > lx1
        break;
    end
    if (i-1)*step2+w2 > lx2
        break;
    end
    f_x1 = x1((i-1)*step1+1:(i-1)*step1+w) .* window;
    f_x2 = x2((i-1)*step2+1:(i-1)*step2+w2) .* window2;
    p_x1 = abs(fft(f_x1)).^2;
    p_x1 = p_x1(1:w/2+1);
    p_x2 = abs(fft(f_x2)).^2;
    p_x2 = p_x2(1:w2/2+1);
    y1 = zeros(1,24);
    y2 = zeros(1,24);
    d1 = zeros(1,24);
    d2 = zeros(1,24);
    count = zeros(1,24);
    count2 = zeros(1,24);
    p1 = zeros(1,24);
    p2 = zeros(1,24);
    for j = 1:w/2+1
        fff = (j-1)*fs/w;
        for k = 1:25
            if fff<b(k)
                if k ~= 1
                    count(k-1) = count(k-1) + 1;
                    y1(k-1) = y1(k-1) + p_x1(j);
                    break;
                end
            end
        end
    end
    for j = 1:w2/2+1
        fff = (j-1)*fs/w2;
        for k = 1:25
            if fff<b(k)
                if k ~= 1
                    count2(k-1) = count2(k-1) + 1;
                    y2(k-1) = y2(k-1) + p_x2(j);
                    break;
                end
            end
        end
    end

    for j = 1:24
        d1(j) = y1(j) * f(j);
        d2(j) = y2(j) * f(j);
    end
    
    for j = 1:w/2+1
        fff = (j-1)*fs/w;
        for k = 1:25
            if fff<b(k)
                if k ~= 1
                    p1(k-1) = p1(k-1) + abs(H_function(fff)) * d1(k-1) / count(k-1);
                    break;
                end
            end
        end
    end
    for j = 1:w2/2+1
        fff = (j-1)*fs/w2;
        for k = 1:25
            if fff<b(k)
                if k ~= 1
                    p2(k-1) = p2(k-1) + abs(H_function(fff)) * d2(k-1) / count(k-1);
                    break;
                end
            end
        end
    end
    
    for j = 1:24
        p1(j) = 20 * log(p1(j));
        p2(j) = 20 * log(p2(j));
    end

    l1 = 2.^((p1-40)/10);
    l2 = 2.^((p2-40)/10);

    BSD_up = BSD_up + sum((l1 - l2).^2);
    BSD_down = BSD_down + sum(l1.^2);
end
% BSD_up
% BSD_down
y = BSD_up / BSD_down;
end