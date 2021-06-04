function A = find_pairwise_angles(M)
% computes the angles between all pairs of vectors in the column of M

n = size(M,2);
A = zeros(n,n);

center = mean(A,2);
center = center(:);
A = A-center*ones(1,n);

for jj=1:n
    for kk=1:n
        vec1 = M(:,jj);
        vec2 = M(:,kk);
        theta = acos(dot(vec1,vec2)/(norm(vec1)*norm(vec2)));
        if theta >= pi
            theta = 2*pi-theta;
        end
        A(jj,kk) = 360*theta/(2*pi);
    end
end

A = real(A);