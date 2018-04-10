function [y] = wsola(x, rate, a, threshold)
    tic
    switch a
        case 0
            disp('原版')
        case 1
            disp('近似')
        case 2
            disp('fft')
        case 3
            disp('fft近似')
        case 4
            disp('隔点')
        case 5
            disp('隔点近似')
    end
    lx = size(x,2);
    N = 1024;
    delta = N / 2;
    Hs = N / 2;
    Ha = round(Hs / rate);
    w = hanning(N)';
    ly = round(lx*rate);
    y = zeros(1,ly);

    flag = 0;

    xm = x(1:N);
    ym = xm.*w;
    for j = 1:N
        y(j) = y(j) + ym(j);
    end
    x_p = x(N/2+1:3*N/2);
    s = N/2+1;
    p = Ha + 1;
    l = p - delta;
    r = p + delta - 1;
    count = 1;
    while r+N-1 <= lx
        if l < 1
            l = 1;
        end
        switch a
            case 0
                b_p = best_xm(x, l, r, x_p, N);
            case 1
                if (s >= l) && ( s <= r)
                    b_p = s;
                else
                    b_p = best_xm_a(x, l, r, x_p, N, threshold);
                end
            case 2
                b_p = best_xm_fft(x, l, r, x_p, N);
            case 3
%                 b_p = best_xm_fft_a(x, l, r, x_p, N);
                if (s >= l) && ( s <= r)
                    b_p = s;
                else
                    b_p = best_xm_fft_a(x, l, r, x_p, N, threshold);
                end
            case 4
                b_p = best_xm_fast(x, l, r, x_p, N);
            case 5
%                 b_p = best_xm_fast_a(x, l, r, x_p, N);
                if (s >= l) && ( s <= r)
                    b_p = s;
                else
                    b_p = best_xm_fast_a(x, l, r, x_p, N, threshold);
                end
        end
        xm = x(b_p:b_p + N - 1);
        p = p + Ha;
        l = p - delta;
        r = p + delta - 1;
        ym = xm.*w;
        count = count + 1;
        temp = (count-1)*Hs;
        if temp+N > ly
            for j = 1:Hs
                y(temp+j) = y(temp+j) + ym(j);
            end
            for j = temp+Hs+1:ly
                y(j) = y(j) + ym(j-temp);
            end
            flag = 1;
            break;
        else
            for j = 1:N
                y(temp+j) = y(temp+j) + ym(j);
            end
        end
        s = b_p + N/2;
        if s+ N - 1 > lx
            break;
        end
        x_p = x(s:s + N - 1);
    end
    
    if flag == 0
        if rate <= 1
            for j = temp + N/2+1:ly
                mm = b_p + j - temp - 1;
                if mm > lx
                    break;
                else
                    y(j) = x(mm);
                end
            end
        else
            r = lx - N +1;
            l = r - 2*delta + 1;

            while 1
                x_p = x(b_p + N/2:b_p + N - 1);
                b_p = best_xm(x, l, r, x_p, N / 2);
                xm = x(b_p:b_p + N - 1);
                ym = xm.*w;
                temp = temp + Hs;
                if temp + N <= ly
                    for j = 1:N
                        y(temp+j) = y(temp+j) + ym(j);
                    end
                else
                    for j = 1:Hs
                        y(temp+j) = y(temp+j) + ym(j);
                    end
                    for j = temp + Hs + 1:ly
                        y(j) = xm(j- temp);
                    end
                    break;
                end
            end
        end
    end
    toc
end