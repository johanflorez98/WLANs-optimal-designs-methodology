%% Read optimal positions APs

clear
close all
clc

path = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\";
case_r = "60users"; % **************
amount_aps = "3APs"; % ******************
format = '.png';
amo_sc  = 102;
images = 25; % ******************

for i = 1 : amo_sc
    for j = 1 : images
        aps_c = [];
        aps = imread(path + case_r + '\APs_t\' + amount_aps + "\" + string(i) + '_' + string(j) + format);
        [rows, columns] = find(aps);
        aps_c = [aps_c; rows, columns];
        pos_AP(:,:,j,i) = aps_c;
    end
end

save(path + case_r + '\APs_t\' + amount_aps + "\" + amount_aps + "_optimals.mat");