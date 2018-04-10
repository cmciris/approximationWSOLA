function [ b_p ] = best_xm_fft( x, l, r, x_p, N )
%BEST_XM 此处显示有关此函数的摘要
%   此处显示详细说明
    a = x(l:r+N-1);
    b = [x_p zeros(1, r+N-l-size(x_p,2))];
    rf = ifft( fft(a) .* conj(fft(b)) );
    b_p = l;
    b_c = rf(1);
    dm = 0;
    for j = l:l+N-1
        dm = dm + x(j)^2 + x_p(j-l+1)^2;
    end
    b_c = 2*b_c / dm;
    for j = 2:r-l+1
        dm = dm - x(j+l-2)^2 + x(j+l+N-3)^2;
        rf(j) = 2*rf(j) / dm;
        if rf(j) > b_c
            b_c = rf(j);
            b_p = j - 1 + l;
        end
    end
end

