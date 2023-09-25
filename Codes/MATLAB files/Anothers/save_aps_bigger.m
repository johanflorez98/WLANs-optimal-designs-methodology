close all
clc

load("G:\Otros ordenadores\False 2 Tesis Maestria\DataSet5GHz\Users and APsOpti final\100users\APs_t\5APs\5APs_optimals.mat")

dimentions = size(pos_AP);
tamano_cuadrado = 30;

for i = 1 : dimentions(4)
    for j = 1 : dimentions(3)
        image = zeros(256,256);
        for k = 1 : dimentions(1)

            fila = pos_AP(k,1,j,i);
            columna = pos_AP(k,2,j,i);

            % Definir las coordenadas del cuadrado
            fila_inicio = max(1, fila - tamano_cuadrado);
            fila_fin = min(256, fila + tamano_cuadrado);
            columna_inicio = max(1, columna - tamano_cuadrado);
            columna_fin = min(256, columna + tamano_cuadrado);
            
            % Asignar valores de 1 alrededor del centro del cuadrado
            image(fila_inicio:fila_fin, columna_inicio:columna_fin) = 1;
        end
        imwrite(image, "G:\Otros ordenadores\False 2 Tesis Maestria\DataSet5GHz\Users and APsOpti final\100users\APs_t\5APs-big\"+string(i)+"_"+string(j)+".png")
    end 
end