function main()

if ~isdeployed
    disp('adding paths');
    addpath(genpath('/N/u/brlife/git/jsonlab'))
    addpath(genpath('/N/u/brlife/git/vistasoft'))
    addpath(genpath('/N/u/brlife/git/mba'))
    addpath(genpath('/N/u/brlife/git/wma_tools'))
end

config = loadjson('config.json');

centroidSD=config.centroidSD;
lengthSD=config.lengthSD;
maxIter=config.maxIter;

disp('loading inputs')
load(config.classification)
wbfg=fgRead(config.track);

if length(wbfg.fibers) ~= length(classification.index)
    fprintf('wmc(%d) and track fiber(%d) counts do not match\n', length(wbfg.fibers), length(classification.index))
    return
end

%% wma
classification=removeOutliersClassification(classification,wbfg, centroidSD, lengthSD,maxIter);

%save classficiation
mkdir('classification')
save('classification/classification.mat','classification');

fg_classified = bsc_makeFGsFromClassification_v4(classification, wbfg);
generate_productjson(fg_classified);

tractspath='classification/tracts';
mkdir(tractspath);
for it = 1:length(fg_classified)
    tract.name   = fg_classified{it}.name;
    tract.color = fg_classified{it}.colorRgb;
    
    fprintf('saving tract.json for %s\n', tract.name);
    
    %pick randomly up to 1000 fibers (pick all if there are less than 1000)
    fiber_count = min(1000, numel(fg_classified{it}.fibers));
    tract.coords = fg_classified{it}.fibers(randperm(fiber_count))';
    %tract.coords = cellfun(@(x)round(x,3), tract.coords', 'UniformOutput', false);
    savejson('', tract, 'FileName', fullfile(tractspath,sprintf('%i.json',it)), 'FloatFormat', '%.5g');
    
    all_tracts(it).name = fg_classified{it}.name;
    all_tracts(it).color = fg_classified{it}.colorRgb;
    all_tracts(it).filename = sprintf('%i.json',it);
    
    clear tract
end
savejson('', all_tracts, fullfile(tractspath, 'tracts.json'));

disp('all done');

end
