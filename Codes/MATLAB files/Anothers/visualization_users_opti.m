clear
close all
clc

caso = 40;
plain_t = 102;
scen_tot = 25;

for m_re = 1 : plain_t
    load("E:\DataSet5GHz\Users and APsOpti final\" + string(caso) + "users\Data\" + string(m_re) + "_results.mat");
    plan_s = double(imread("E:\DataSet5GHz\Users and APsOpti final\100users\Plains_t\" + string(m_re) + ".PNG"));
    for k_re = 21 : scen_tot
        pos_pru = cell2mat(positions_finals(k_re));
    
        im = zeros(256,256);
    
        for i = 1 : length(pos_pru)
            im(pos_pru(i,2), pos_pru(i,1)) = 255;
        end
    
%         figure
%         imshow(im + plan_s)
        imwrite(im, "E:\DataSet5GHz\Users and APsOpti final\" + string(caso) + "users\Users_t\" + string(m_re) + "_" + string(k_re) + ".png")
    end
end