function [cen,rad_max,rad_std] = calc_stat(X)
% X is a data matrix whose observations are stored as rows
% clac_stat calculates the center and radius of the data points

% calculate center
cen = mean(X,1);

% shift to the center
Xnew = X - ones(size(X,1),1) * cen;

% calculate radii
rad_max = max(sqrt(sum(Xnew.^2,2)));

% calculate std
rad_std = norm(Xnew,'fro')/sqrt(size(Xnew,1));
