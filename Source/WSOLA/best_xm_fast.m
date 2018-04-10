function [ b_p ] = best_xm_fast( x, l, r, x_p, N )
%BEST_XM �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    tmp_b_p = l;
    b_c = 0;
    dm = 0;
    step = round(N/40);
    for j = l:step:l+N/2-1 % Here we set p+N-1 to p+N/2-1
        b_c = b_c + x(j)*x_p(j-l+1);
        dm = dm + x(j)^2 + x_p(j-l+1)^2;
    end
    b_c = 2*b_c / dm;
    
    for i = l+step:step:r
        c = 0;
        for j = i:step:i+N/2-1
            c = c + x(j)*x_p(j-i+1);
        end
        dm = dm - x(i-step)^2 + x(j)^2;
        c = 2*c / dm;

        if c > b_c
            tmp_b_p = i;
            b_c = c;
        end
    end
    tmp_l = tmp_b_p - step + 1;
    tmp_r = tmp_b_p + step - 1;
    if tmp_l <= l
        tmp_l = l+1;
    end
    if tmp_r >= r
        tmp_r = r-1;
    end
    %�޷�ʹ��ǰһ���Ľ��������ÿ�ζ���Ҫ���¼����ĸ
    for i = tmp_l:tmp_r
        c = 0;
        dm = 0;
        for j = i:step:i+N/2-1
            c = c + x(j)*x_p(j-i+1);
            dm = dm + x(j)^2 + x_p(j-i+1)^2;
        end
        c = 2*c / dm;
        if c > b_c
            tmp_b_p = i;
            b_c = c;
        end
    end
    b_p = tmp_b_p;
end

