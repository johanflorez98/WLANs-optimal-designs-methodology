% Reduciendo la cantidad de users por cada escenario

clear
close all
clc

% Número de filas a eliminar
numFilasEliminar = 80;

scen = 20;
final = 100 - numFilasEliminar;
plain_t = 102;

for j_re = 1:plain_t
    load("C:\Users\Johan Florez\Desktop\Users and APsOpti final\100users\Data\" + string(j_re) + "_results.mat");
    
    for k_re = 1 : scen
    
        % Crear una matriz de 100x2
        matriz = cell2mat(positions_finals(k_re));
        
        % Generar un vector de índices aleatorios sin repeticiones
        indicesEliminar = randperm(length(matriz), numFilasEliminar);
        
        % Eliminar las filas correspondientes en la matriz
        matrizReducida = matriz;
        matrizReducida(indicesEliminar, :) = [];
        
    %     % Verificar el tamaño de la matriz reducida
    %     size(matrizReducida)
        positions_finals{k_re, 1} = matrizReducida;
        save("C:\Users\Johan Florez\Desktop\Users and APsOpti final\" + string(final) + "users\" + string(j_re)+ "_results.mat"); % Se va guardando en espacio de trabajo en cada iteración
            
    end
end