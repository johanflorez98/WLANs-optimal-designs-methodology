%% To read model keras in matlab and linked with balanced k-meand algorithm

clear
close all
clc

modelfile = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Models\1AP\maps_1_model.h5";
net = importKerasNetwork(modelfile)

%%
im_plain = double(imread("G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Scennarios init\Scennarios B\100.png")/255);
im_ap = double(imread("G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Txs\1AP\1_1.png")/255);

input(:,:,1) = im_plain;
input(:,:,2) = im_ap;

%%

close all 

tic
ypred = predict(net,input);
toc
imshow(ypred)
