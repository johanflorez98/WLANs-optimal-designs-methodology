%% Posiciones de usuarios de forma autimatica en planos
% clear
% close all
% clc

% Se crea el arreglo de celdas que almacenará las posiciones de los
% usuarios

% Se carga el plano:
work = "C:\Users\Johan Florez\Desktop\Users and APsOpti final\";
tipe = {'*.jpg;*.png'};
[file, path] = uigetfile(tipe);
while isequal(file,0)
    [file, path] = uigetfile(tipe);
end
imagepath = fullfile(path, file);
img = imread(imagepath); 
size_users = 20;
% _________________________________________________________________________
count_u = 3; % CAMBIAR CADA VEZ QUE SE COMETA UN ERROR EN LA GENERACIÓN DE LAS IMÁGENES ***

% scenario = 1; %  CADA VEZ QUE SE CARGUE UN PLANO NUEVO *************
scenario = str2double(file(1:end-4)); % Se carga el nombre del escenario actual
% _________________________________________________________________________

% positions_finals = cell(50, 500); % Arreglo que almacenará las posiciones de los usuarios por distibución y por escenario

load_t = 100;
                
while count_u <= size_users
    %% Se definen las posiciones uniformes de los usuarios:
    close all
    matrix_p = [];

    title_ = 'Defina las posiciones de los usuarios';
    figure(1)
    imshow(img)
    axis image;
    set(gca, 'xtick', [], 'ytick', []); % Se eliminan las etiquetas de los ejes
    title(title_, Interpreter = "latex", FontSize= 10)
    hold on
    
    countaux1 = 0;
    img_pos = zeros(256,256);

    while 1

        x = [];
        y = [];
        % Se marcan las posiciones uniformes de los usuarios:
        [x, y] = getpts();
    %     roi = drawpoint;
        
        %% Se grafican las posiciones uniformes de los usuarios
        pos = [];
        space = 10; % Espacio entre posicones de usuarios
        i1 = 1;
        i2 = 2;
        i = 0;
        
        % Se crean los vectores de las posiciones intermedias:
        while i1 <= length(x)
            i = i + 1;
            size = floor((x(i2) - x(i1))/10);
            pos{i} = x(i1):space:(space*size + x(i1));
            i1 = i1 + 2;
            i2 = i2 + 2;
        end
        
        i1 = 1;
        
        for i = 1 : length(pos)
            us = cell2mat(pos(i));
            for j = 1 : length(us)
                countaux1 = countaux1 + 1;
 
                plot(us(j),y(i1),"square",...
                    "LineWidth",2,...
                    "MarkerSize",3,...
                    "MarkerEdgeColor",'blue',...
                    "MarkerFaceColor",'blue')
                hold on
                matrix_p = [matrix_p; us(j), y(i1)];  
                
            end
            i1 = i1 +2;
        end
        disp(['Se han agregado hasta el momento: ', num2str(countaux1), ' usuarios uniformes'])
    
        % Se va conformando la imagen con las posiciones de los usuarios:
        i1 = 1;
        for i = 1 : length(pos)
            pos1 = cell2mat(pos(i));
            for j = 1 : length(pos1)
                img_pos(y(i1),pos1(j)) = 255;
            end
            i1 = i1 + 2;
        end

        % Se rompe el loop si se supera cierta cantidad de usuarios
        % uniformes, para pasar a añadir los aleatorios
        if countaux1 >= 65 
            break;
        end
    end
    % figure(2)
    % imshow(img_pos)
    
    %% Se grafican las posiciones aleatorias de los usuarios:
    
    % Se marcan las posiciones uniformes de los usuarios:
    
%     x = [];
%     y = [];

%     [x, y] = getpts();

    while countaux1 < load_t
        countaux1 = countaux1 + 1;

        clear roi
        roi = drawpoint;
        point = roi.Position;
%         numero_aleatorio = randi(cantidad_colores);
%         color_aleatorio = colors(numero_aleatorio);
        plot(point(1), point(2),"square",...
            "LineWidth",2,...
            "MarkerSize",3,...
            "MarkerEdgeColor",'yellow',...
            "MarkerFaceColor",'yellow')
        hold on
        img_pos(point(2),point(1)) = 255;
        matrix_p = [matrix_p; point(1), point(2)]; 
        disp(['Se han agregado hasta el momento: ', num2str(countaux1), ' usuarios totales'])

    end
    
    %% Se guarda la imagen de los usuarios
    path = work + "100users\Users_t\";
    imwrite(img_pos, path + string(file(1:end-4)) + "_" + string(count_u) + ".png");
    disp(['distribución: ', num2str(count_u), ' de: ', num2str(size_users), ' generada, plano: ' , file(1:end-4)])

    positions_finals{count_u, 1} = matrix_p;

    save(work + "100users\Data\" + string(scenario)+ "_results.mat"); % Se va guardando en espacio de trabajo en cada iteración
    clear positions_finals
    load(work + "100users\Data\" + string(scenario)+ "_results.mat");

    pos_pru = cell2mat(positions_finals(count_u));

    im = zeros(256,256);

    for i = 1 : length(pos_pru)
        im(pos_pru(i,2), pos_pru(i,1)) = 255;
    end

    figure 
    imshow(im)
    figure
    aux = imread(path + string(file(1:end-4)) + "_" + string(count_u) + ".png");
    imshow(aux);
    pause(10)

    count_u = count_u  + 1;

end