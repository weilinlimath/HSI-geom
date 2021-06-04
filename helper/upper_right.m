function vec = upper_right(A)
% creates vec of the top right part of a square matrix A

n = size(A,1);
vec = [];

for jj = 1:(n-1)
    for kk = (jj+1):n
        vec = [vec, A(jj,kk)];
    end
end