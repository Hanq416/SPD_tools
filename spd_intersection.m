clc; clear all; %#ok<*CLALL>
warning('off'); %#ok<*CLALL>
% Hankun Li, Lighting Research Laboratory, University of Kansas
% Sep 28, 2021

%% Load task spoectrum data
spec_task = curveGen_task;

%% Load measured spoectrum data
spec_measured = curveGen_measured;

%% Get results
result = SPD_calculation(spec_task, spec_measured);

%% end here...













%% functions lib

function res = SPD_calculation(spec_task, spec_measured)
workload = size(spec_measured,2);res = zeros(workload-1,2);
for i = 1:workload-1
    spec_tar = spec_measured(:,[1,i+1]);
    [marea,sarea,tarea,f] = SPD_intersection(spec_task, spec_tar);
    matched = marea/sarea; used = marea/tarea;
    res(i,1) = matched; res(i,2) = used;
    fprintf('[1] Ratio: Desired spectrm MATCHED: %f \n', matched);
    fprintf('[2] Ratio: Supplied spectrm USED: %f \n', used);
    uiwait(f);
    input("Press ENTER to continue! \n");
end
end


function [marea,sarea,tarea,f] = SPD_intersection(spec1, spec2)
%%
f = figure(1); plot(spec1(:,1),spec1(:,2), '-b'); 
hold on; plot(spec2(:,1),spec2(:,2), '-m');
title ('spectrum intersection'); grid on;
spec_matched = spec1; 
spec_matched(:,2) = min(spec1(:,2),spec2(:,2));
area(spec_matched(:,1),spec_matched(:,2),'LineStyle',':',...
    'FaceColor','#D95319'); 
legend('task spectrum','supplied spectrum','matched spectrum');
legend('Location','northwest'); hold off;
marea = sum(spec_matched(:,2));
sarea = sum(spec1(:,2));
tarea = sum(spec2(:,2));
end

% input task spectrum
function [spec] = curveGen_task
%%
[fn,pn] = uigetfile('*.csv','load measured spectrum data');
fname = [pn,fn]; tlc = readmatrix(fname);
datasize = size(tlc,2); spec(:,1) = 200 : 1 : 850; spec(:,2) = 0;
%%
tmp = tlc(2,:); length = (tlc(1,datasize)-tlc(1,1)+1);
scaled = reshape(imresize(tmp,[1 length]),length,1);
spec(tlc(1,1) - 199:tlc(1,1) - 200 + length,2) = abs(scaled);
end

% input measured spectrum
function [spec] = curveGen_measured
%%
[fn,pn] = uigetfile('*.csv','load measured spectrum data');
fname = [pn,fn]; tlc = readmatrix(fname);
dataSize = size(tlc,2); measureSize = size(tlc,1);
%%
spec(:,1) = 200 : 1 : 850; spec(:,2:measureSize) = 0;
for i = 2:measureSize
    tmp = tlc(i,:); length = (tlc(1,dataSize)-tlc(1,1)+1);
    scaled = reshape(imresize(tmp,[1 length]),length,1);
    spec(tlc(1,1) - 199:tlc(1,1) - 200 + length,i) = abs(scaled);
end
end