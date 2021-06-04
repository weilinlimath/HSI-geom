function array = vec_to_array(vec,n,cutoff)
% given a vec, create array of size n by n whose upper right corner
% contains vec

if nargin < 3
    cutoff = ones(size(vec));
end

array = zeros(n,n);
idx = 1;

for jj = 1:n
    for kk = (jj+1):n
        if cutoff(idx) < 1
            array(jj,kk) = 0;
        else
            array(jj,kk) = vec(idx);
        end
        idx = idx+1;
    end
end

array = array + array';