%% Select dataset
DataNames = {'Indian_pines_corrected','KSC_corrected','PaviaU','Botswana'};
Plotnames = {'Indian Pines','Kennedy Space Center', 'Pavia University', 'Botswana'};

id = 4;
name = DataNames{id};

%% experiment 1 for class distances and angles

stats_raw = class_dist(name,'raw');
stats_fst = class_dist(name,'fst');
stats_eap = class_dist(name,'eap');

save([DataNames{id},'_stats_raw'],'stats_raw')
save([DataNames{id},'_stats_fst'],'stats_fst')
save([DataNames{id},'_stats_eap'],'stats_eap')

%%

figure; imagesc(stats_raw.dist); colorbar
figure; imagesc(stats_fst.dist); colorbar
figure; imagesc(stats_eap.dist); colorbar

figure; imagesc(stats_raw.angles); colorbar
figure; imagesc(stats_fst.angles); colorbar
figure; imagesc(stats_eap.angles); colorbar

%% exeperiment 2 for compression error

per = 1:15;

error_raw = PCA_error(name,'raw',per);
error_fst = PCA_error(name,'fst',per);
error_eap = PCA_error(name,'eap',per);

%
figure; 
hold on 
plot(per,log10(error_raw),'Marker','*','LineWidth',2,'DisplayName','Raw')
plot(per,log10(error_fst),'Marker','*','LineWidth',2,'DisplayName','3DFST')
plot(per,log10(error_eap),'Marker','*','LineWidth',2,'DisplayName','EAP')
xlabel('Percentage of feature dimension')
ylabel('Average relative approximation in log scale')
title(['Compression error for ',Plotnames{id}])
legend('Location','northeast')
ax = gca; % current axes
ax.FontSize = 14;
hold off

saveas(gcf,['compression_',DataNames{id},'.eps'],'epsc')
