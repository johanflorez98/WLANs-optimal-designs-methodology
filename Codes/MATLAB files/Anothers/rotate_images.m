% Are rotated the images 90, 180 y 270 grades
clear
close all
clc

scenarios = 102;
size_scenario = 25;

case_aps_ana = "1APs";
case_users_ana = "20users";
case_image_write = "Users";
case_image_read = "Users_t";

count_aux1 = 1;

% path_read = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\" + case_users_ana + "\" + case_image_read + "\" + case_aps_ana + "\";
% path_write = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\" + case_users_ana + "\" + case_image_write + "\" + case_aps_ana + "\";

path_read = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\" + case_users_ana + "\" + case_image_read + "\";
path_write = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\" + case_users_ana + "\" + case_image_write  + "\";

for j = 1 : scenarios
    for i = 1 : size_scenario
    
        img1 = imread(path_read + string(j) + "_" + string(i) + ".PNG");
        
        imwrite(img1, path_write + string(count_aux1) + "_" + string(i) + ".PNG");
   
        img1r = imrotate(img1, -90);
        imwrite(img1r, path_write + string(count_aux1 + 1) + "_" + string(i) + ".PNG");
        
        img1r = imrotate(img1, -90*2);
        imwrite(img1r, path_write + string(count_aux1 + 2) + "_" + string(i) + ".PNG");
        
        img1r = imrotate(img1, -90*3);
        imwrite(img1r, path_write + string(count_aux1 + 3) + "_" + string(i) + ".PNG");
        
    end

    count_aux1 = count_aux1 + 4;
end