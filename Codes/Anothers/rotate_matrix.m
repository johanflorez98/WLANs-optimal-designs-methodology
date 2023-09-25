close all
clc
clear

scenario = 1; % Se cambia según el pano que se desee cargar ***************

load("G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\" + string(scenario) + "_results.mat");
path = "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\plains_t\";

plain = imread(path + string(scenario) + ".PNG");

size_po = 3; % Cantidad de distintas distribuciones de usuarios por plano
countaux1 = 1;
countaux2 = 1; % Se debe correr de acuerdo a la cantidad de planos que se
% han guardado ************************************************************

 % Se guarda la imagen original del plano
imwrite(plain, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\plains\" + string(countaux2) + ".PNG");
countaux2 = countaux2 + 1;

% Se guarda la imagen del plano rotada 90°
plain1 = imrotate(plain, -90);
imwrite(plain1, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\plains\" + string(countaux2) + ".PNG");
countaux2 = countaux2 + 1;

% Se guarda la imagen del plano rotada 180°
plain2 = imrotate(plain, -90*2);
imwrite(plain2, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\plains\" + string(countaux2) + ".PNG");
countaux2 = countaux2 + 1;

% Se guarda la imagen del plano rotada 180°
plain3 = imrotate(plain, -90*3);
imwrite(plain3, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\plains\" + string(countaux2) + ".PNG");

while countaux1 <= size_po
    countaux4 = countaux2 - 3;

    positions = cell2mat(positions_finals(countaux1,1));

    % Se guardan las posiciones de los usuarios normal
    img_pos = zeros(256,256);
    for i = 1 : length(positions)
        img_pos(positions(i, 2), positions(i, 1)) = 255;
    end
    imwrite(img_pos, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\users\" + string(countaux4) + "_" + string(countaux1) + ".PNG");

    A = positions; % matriz original de puntos
    A_min = min(A); % coordenadas mínimas de los puntos
    A_trasl = A - A_min; % trasladar los puntos para que el punto de origen tenga coordenadas (0,0)
    R = [0 1; -1 0]; % matriz de rotación (90 grados en sentido horario)
    A_rotada_trasl = A_trasl * R; % matriz de puntos rotados y trasladados
    A_min_rotada = min(A_rotada_trasl); % coordenadas mínimas de los puntos rotados
    A_rotada_trasl2 = A_rotada_trasl - A_min_rotada; % trasladar los puntos rotados para que todos tengan coordenadas positivas
    positions90 = A_rotada_trasl2 + A_min; % trasladar los puntos rotados de vuelta a su posición original

    % ***
    figure
    imshow(plain1)
    axis image;
    set(gca, 'xtick', [], 'ytick', []); % Se eliminan las etiquetas de los ejes
    title(title_, Interpreter = "latex", FontSize= 10)
    hold on

    for j = 1 : length(positions90)

        plot(positions90(j,1),positions90(j,2),"square",...
            "LineWidth",3,...
            "MarkerSize",5,...
            "MarkerEdgeColor",'green',...
            "MarkerFaceColor",'green')
        hold on        
    end
    % ***

    % Se guardan las posiciones de los usuarios rotados 90°
    img_pos = zeros(256,256);
    for i = 1 : length(positions)
        img_pos(positions90(i, 2), positions90(i, 1)) = 255;
    end
    imwrite(img_pos, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\users\" + string(countaux4 + 1) + "_" + string(countaux1) + ".PNG");

    A = positions90; % matriz original de puntos
    A_min = min(A); % coordenadas mínimas de los puntos
    A_trasl = A - A_min; % trasladar los puntos para que el punto de origen tenga coordenadas (0,0)
    R = [0 1; -1 0]; % matriz de rotación (90 grados en sentido horario)
    A_rotada_trasl = A_trasl * R; % matriz de puntos rotados y trasladados
    A_min_rotada = min(A_rotada_trasl); % coordenadas mínimas de los puntos rotados
    A_rotada_trasl2 = A_rotada_trasl - A_min_rotada; % trasladar los puntos rotados para que todos tengan coordenadas positivas
    positions180 = A_rotada_trasl2 + A_min; % trasladar los puntos rotados de vuelta a su posición original 

    % ***
    figure
    imshow(plain2)
    axis image;
    set(gca, 'xtick', [], 'ytick', []); % Se eliminan las etiquetas de los ejes
    title(title_, Interpreter = "latex", FontSize= 10)
    hold on

    for j = 1 : length(positions180)

        plot(positions180(j,1),positions180(j,2),"square",...
            "LineWidth",3,...
            "MarkerSize",5,...
            "MarkerEdgeColor",'green',...
            "MarkerFaceColor",'green')
        hold on        
    end
    % ***

    % Se guardan las posiciones de los usuarios rotados 180°
    img_pos = zeros(256,256);
    for i = 1 : length(positions180)
        img_pos(positions180(i, 2), positions180(i, 1)) = 255;
    end
    imwrite(img_pos, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\users\" + string(countaux4 + 2) + "_" + string(countaux1) + ".PNG");

    A = positions180; % matriz original de puntos
    A_min = min(A); % coordenadas mínimas de los puntos
    A_trasl = A - A_min; % trasladar los puntos para que el punto de origen tenga coordenadas (0,0)
    R = [0 1; -1 0]; % matriz de rotación (90 grados en sentido horario)
    A_rotada_trasl = A_trasl * R; % matriz de puntos rotados y trasladados
    A_min_rotada = min(A_rotada_trasl); % coordenadas mínimas de los puntos rotados
    A_rotada_trasl2 = A_rotada_trasl - A_min_rotada; % trasladar los puntos rotados para que todos tengan coordenadas positivas
    positions270 = A_rotada_trasl2 + A_min; % trasladar los puntos rotados de vuelta a su posición original

    % ***
    figure
    imshow(plain3)
    axis image;
    set(gca, 'xtick', [], 'ytick', []); % Se eliminan las etiquetas de los ejes
    title(title_, Interpreter = "latex", FontSize= 10)
    hold on

    for j = 1 : length(positions90)

        plot(positions270(j,1),positions270(j,2),"square",...
            "LineWidth",3,...
            "MarkerSize",5,...
            "MarkerEdgeColor",'green',...
            "MarkerFaceColor",'green')
        hold on        
    end
    % ***

    % Se guardan las posiciones de los usuarios rotados 270°
    img_pos = zeros(256,256);
    for i = 1 : length(positions270)
        img_pos(positions270(i, 2), positions270(i, 1)) = 255;
    end
    imwrite(img_pos, "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\users\" + string(countaux4 + 3) + "_" + string(countaux1) + ".PNG");

    countaux1 = countaux1 + 1;
end