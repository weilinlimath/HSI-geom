% script to create training files used in hyper_svm_experiments

% 3 variables for the user to set
OUT_PATH = '.';
DATASET_PATH = 'datasets'

% initialize
groundtruthfiles = { 'Indian_pines_gt', 'KSC_gt', 'PaviaU_gt', 'Botswana_gt'};
datasetsamples = cell(length(groundtruthfiles), 1);

for datasetidx = 4
    sample = datasetsamples{datasetidx};
    Y = get_hyperdata(DATASET_PATH, groundtruthfiles{datasetidx});
    labels = reshape(Y,[1 prod(size(Y))]);
    nclasses = max(unique(labels)); 
    
    outfilenames = cell(nclasses*(nclasses-1)/2,1);
    num = 1;
    for jj = 1:nclasses
        for kk = (jj+1):nclasses 
            
            train_mask = zeros(1,numel(Y));
            train_mask(find(Y==jj)) = 1;
            train_mask(find(Y==kk)) = 1;
            test_mask = train_mask;

            %id = DataHash([train_mask test_mask]);
            outfilenames{num} = sprintf('%s_traintest_%d_%d.mat', groundtruthfiles{datasetidx}, jj, kk);
            outfile = fullfile(OUT_PATH, outfilenames{num});
            save(outfile, 'train_mask', 'test_mask');
            num = num+1;
        end
    end
    fprintf('traintestfilenames = [ ''%s'' ];\n', strjoin(outfilenames, ''', '''));
end

