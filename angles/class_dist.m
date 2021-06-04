function stats = class_dist(dataname,feat)
% computes various statistics of the dataset with name
% opt = true for features, opt = false for raw

[Y,X,C] = load_normalize_data(dataname,feat);

% data dimensions
nclasses = length(unique(Y));
npoints = size(X,1);
nbands = size(X,2);

% data structures
class_mean = zeros(nbands,nclasses);
rad = zeros(npoints,1);
class_num = zeros(nclasses,1);

for jj = 1:nclasses
    
    % extract data points for j-th class
    Xclass = X(Y==jj,:);
    
    % shift to the center
    cen = mean(Xclass,1);
    Xnew = Xclass - ones(size(Xclass,1),1) * cen;
    temp = sqrt(sum(Xnew.^2,2));
    rad(Y==jj) = temp;
    
    % save results
    class_mean(:,jj) = cen;
    class_num(jj) = size(Xclass,1);
        
end

% calculate pairwise distances between class means
D = zeros(nclasses,nclasses);

for jj = 1:nclasses
    for kk = 1:nclasses
        if jj ~= kk
               
              D(jj,kk) = norm(class_mean(:,kk)-class_mean(:,jj));

        end
    end
end

% calculate pairwise angles between class means
A = find_pairwise_angles(class_mean);

stats.normal = C;
stats.means = class_mean;
stats.num = class_num';
stats.rad = rad';
stats.dist = D;
stats.angles = A;