close all
clc
clear

plain_i = 101;
plain_f = 102;

while plain_i <= plain_f 
    close all
    
    % Tamaño de la matriz original
    tamano = 256;
    work = "C:\Users\Johan Florez\Desktop\Users and APsOpti final\";
    
    % Generar matriz de ejemplo con 255 y 0
    
    amount_pos = 20;
    count_pos = 1;
    matriz = double(imread("C:\Users\Johan Florez\Desktop\Users and APsOpti final\100users\Plains_t\" + string(plain_i) + ".PNG"));
    
    % Matriz de planos indoor de 256x256
    matriz_indoor = matriz; % Aquí debes ingresar tu matriz de planos indoor de 256x256
    
    % Encontrar las coordenadas de los espacios libres
    [filas, columnas] = find(matriz_indoor == 0);
    
    % Generar una matriz de coordenadas aleatorias sin superposición
    num_coordenadas = 100;
    coordenadas = zeros(num_coordenadas, 2);
    
    while count_pos <= amount_pos
        contador = 1;
        while contador <= num_coordenadas
            % Obtener una coordenada aleatoria
            indice_aleatorio = randi(length(filas));
            fila_aleatoria = filas(indice_aleatorio);
            columna_aleatoria = columnas(indice_aleatorio);
            
            % Verificar si la coordenada está lo suficientemente alejada de las coordenadas existentes
            if contador > 1
                distancias = sqrt((coordenadas(1:contador-1, 1) - fila_aleatoria).^2 + (coordenadas(1:contador-1, 2) - columna_aleatoria).^2);
                if min(distancias) < 5 % Ajusta el valor de 5 según tus necesidades de separación
                    continue; % Coordenada muy cercana, continuar al siguiente ciclo
                end
            end
            
            % Almacenar la coordenada
            coordenadas(contador, :) = [fila_aleatoria, columna_aleatoria];
            contador = contador + 1;
        end
        
        % Obtener una matriz de coordenadas de 100x2
        coordenadas = coordenadas(1:num_coordenadas, :);
        positions_finals{count_pos, 1} = coordenadas;
        save(work + "100users\Data\" + string(plain_i)+ "_results.mat"); % Se va guardando en espacio de trabajo en cada iteración
        
        pos = zeros(tamano, tamano);
        
        for i = 1 : num_coordenadas
            pos(coordenadas(i,2), coordenadas(i,1)) = 255;
        end
        
        % Mostrar las coordenadas seleccionadas
        % disp(coordenadas_seleccionadas);
        figure
        imshow(pos + matriz);
        count_pos = count_pos + 1;
    end
    plain_i = plain_i + 1;
end