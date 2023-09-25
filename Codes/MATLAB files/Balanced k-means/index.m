%% Balanced k-means algorithm for distribution of users by AP

% memory cleaning:
clear
close all
clc

%%
% Minimum number of APs to not exceed the maximum number of users:

size_AP = 5;
case_ana = 100;

%******************************
% The drawing is loaded in .jpg format with a depth of 8 bits:
scenarios = 102; % Number of Plans Available

pos_users_scenario = 25; % Number of user distributions per plan
users_max = case_ana/size_AP;
% ini_positions = 1000;
number = 0;
path_fi = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\";

%% Some network parameters:
F = 5.610e9;
colors = ["#FF5733" ,"#9FFF33", "#33FFEC", "#F7DC6F", "#F16FF7"];
v_light = 3e8; % [m/s^2] Speed of light
K = 1.380649e-23; % Boltzmann constant [J]
B = 80e6; % Bandwidth [Hz]
T = 290; % T ambient in [°K]
PT = 26; % [dBm]
GT = 3; % [dBi]   
GR = 0; % [dBi]
bpd = 10; % Break point distance [m]
P_walls = 5; % losses due to wall penetration [dB]
% This program is carried out for a fixed distribution of users and
% for a specific plane.

for sc = 101 : 101%scenarios % ***************************************

    plain = imread(path_fi + "100users\Plains_t\" + string(sc) + ".PNG");
    len = size(plain);
    positions_users = load(path_fi + string(case_ana) + "users\Data\" + string(sc) +"_results.mat");

    for pos_us = 20 : 20 %pos_users_scenario % ************************************
        
        disp(['Plano: ', num2str(sc), ', distribución: ', num2str(pos_us)])
      
        % The positions of the users are established in a fixed way. are simulated
        % uniform positions with some random ones:
        positions_users_ = positions_users.positions_finals{pos_us, 1};
        size_users = length(positions_users_);
        
        %% Balanced K-Means process for original positions
        % The optimal positions are now calculated according to the user load,
        % evaluating the balanced k-means algorithm:
        tic
        [partition, ubiAP, CapUsers_best] = balanced_kmeans(size_AP, positions_users_, size_users, ...
            plain, PT, GT, GR, v_light, F, bpd, P_walls, K, T, B, colors, users_max, path_fi, case_ana, sc, pos_us, len);
        time = toc;


        % Save users groups
        % Define the size of the images and the partition number
        imageSize = [256, 256];  
        numLabels = max(partition); % partition number
        
        % Create an array to store the separate images
        separateImages = zeros(imageSize);
        
        % Loop through each coordinate and its corresponding label
        for i = 1:size(positions_users_, 1)
            x = positions_users_(i, 2);
            y = positions_users_(i, 1);
            label = partition(i);
            
            % Place a blank pixel at the corresponding coordinate of the label image
            separateImages(x, y) = label;
        end

        % Save as CSV
        name_file = path_fi + string(case_ana) +  "users\Users_groups\" + string(size_AP) + "APs\" + string(sc) + "_" + string(pos_us) + ".csv";
        dlmwrite(name_file, separateImages, ',');
        
        disp(['Time about the solution: ', num2str(time/60), ' minutes'])
        disp(' ')
            
%         save_aps(path_fi + string(case_ana) + "users\", size_AP, sc, pos_us, ubiAP, len)
    end
end