function val = sintheta(U,V)
% computes the sin theta distance between U and V
% columns of U and V are assumed orthonormal
% U and V have same dimensions

val = max(abs(sin(acos(svds(U'*V,size(U,2))))));
