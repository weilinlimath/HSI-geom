function [Xreg,Ureg] = trunPCA(X,k)
% X matrix contains each observation as a row
% k number of top singular vectors used

% calculate center
cen = mean(X,1);

% shift to the center
Xnew = X - ones(size(X,1),1) * cen;

% calculate eigenvalues of covariance matrix
[U,D] = eig(Xnew'*Xnew);

% find eigenvectors for largest k 
[~,ind] = sort(diag(D),'descend');
Ureg = U(:,ind(1:k));
Xreg = Xnew * (Ureg * Ureg') + ones(size(X,1),1) * cen;
