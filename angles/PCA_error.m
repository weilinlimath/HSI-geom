function error = PCA_error(dataname,feat,per)
% computes the average relative approximation error using low dimensional
% hyperplanes to approximate each class
% opt = true for features, opt = false for raw
% per is a vector of values in [0,100]

% load data
[Yreshape,Xreshape,~] = load_normalize_data(dataname,feat);

% dimensions of the data
npoints = size(Xreshape,1);
nbands = size(Xreshape,2);
nclasses = length(unique(Yreshape));

% dimension of approx
ndim = ceil(nbands*per/100);
npara = length(ndim);

% data structures
%class_num = zeros(nclasses,1);
%Uspaces = zeros(nbands,ndim,nclasses);
error = zeros(nclasses,npara);

for jj = 1:nclasses
    
    % extract features for j-th class
    Xclass = Xreshape(Yreshape==jj,:);
    
    for kk = 1:npara
    
        % calc statistics and perform truncated SVD
        [Xreg,~] = trunPCA(Xclass,ndim(kk));

        % relative approximation error (as a percentange)
        error(jj,kk) = sum(sqrt(sum((Xreg-Xclass).^2,2)./sum(Xclass.^2,2)));
    
    end
    
end

error = sum(error,1)/npoints;