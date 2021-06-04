function [Yreshape,Xreshape,C] = load_normalize_data(dataname,feat)

% load dataset
switch feat
    case 'raw'
        [Y,X] = get_hyperdata('datasets',[dataname,'_gt'],dataname);
    case 'fst'
        [Y,X] = get_hyperdata('datasets',[dataname,'_gt'],[dataname,'_fst']);
    case 'eap'
        [Y,X] = get_hyperdata('datasets',[dataname,'_gt'],[dataname,'_eap']);
end

% dimensions of the data
nbands = size(X,3);
npoints = numel(Y);

% reshaped arrays
Xtemp = reshape(X,[npoints,nbands]);
Ytemp = reshape(Y,[npoints,1]);

% only keep labeled data
idx = find(Y>0);
Xreshape = Xtemp(idx,:);
Yreshape = Ytemp(idx,:);

clear X Y Xtemp Ytemp;

% normalize by maximum L2 norm
C = sqrt(max(sum(Xreshape.^2,2)));
Xreshape = Xreshape/C;