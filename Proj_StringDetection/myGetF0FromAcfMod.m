function [f0] = myGetF0FromAcfMod(acfVector, fs)
%% get f0 by acf
len_v = length(acfVector);
pre_diff = acfVector(21)-acfVector(20);
t_init = 0;
y_init = 0;
for i = 22 : len_v
    cur_diff = acfVector(i) - acfVector(i-1);
    if pre_diff >= 0 && cur_diff<0 && (acfVector(i) > y_init)
        t_init = i;
        y_init = acfVector(i);
    end
    pre_diff = cur_diff;
end
f0 = fs/(t_init-1);
end


