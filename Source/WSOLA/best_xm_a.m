function [ b_p ] = best_xm_a( x, l, r, x_p, N, threshold)
%BEST_XM 此处显示有关此函数的摘要
%   此处显示详细说明

    b_p = l;
    b_c = 0;
    target = threshold;
    dm = 0;
    
    for j = l:l+N-1
        b_c = b_c + x(j)*x_p(j-l+1);
        dm = dm + x(j)^2 + x_p(j-l+1)^2;
    end
    b_c = 2*b_c / dm;
    
    if b_c > target
        return;
    end
    for i = l+1:r
        c = 0;
        for j = i:i+N-1
            c = c + x(j)*x_p(j-i+1);
        end
        dm = dm - x(i-1)^2 + x(i+N-1)^2;
        c = 2*c / dm;
        if c > b_c
            b_p = i;
            b_c = c;
            if b_c > target
                return;
            end
        end
    end
end

