%% Positions of users automatically in plans
% clear
% close all
% click
% The array of cells is created that will store the positions of the
% users
% Plan is loaded:
work = 'G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\Data\';
tipe = {'*.jpg;*.png'};
[file, path] = uigetfile(tipe);
while isequal(file,0)
    [file, path] = uigetfile(tipe);
end
imagepath = fullfile(path, file);
img = imread(imagepath); 
size_users = 1; % Number of user distributions per plan
% _________________________________________________________________________
count_u = 1; % CHANGE EACH TIME AN ERROR IS MADE IN THE GENERATION OF THE IMAGES ***

scenario = str2double(file(1:end-4)); % The name of the current scenario is loaded
% _________________________________________________________________________

load_t = 100; % Maximum number of users
n_APs = 4; % Number APs

while count_u <= size_users
    % Uniform user positions are defined:
    close all
    matrix_p = [];

    title_ = 'Set positions users';
    figure(1)
    imshow(img)
    axis image;
    set(gca, 'xtick', [], 'ytick', []); 
    title(title_, Interpreter = "latex", FontSize= 10)
    hold on
    
    countaux1 = 0;
    img_pos = zeros(256,256);

    while 1

        x = [];
        y = [];
        
        [x, y] = getpts();
        
        %% Uniform user positions are plotted
        pos = [];
        space = 10; % Space between user positions
        i1 = 1;
        i2 = 2;
        i = 0;
        
        % The vectors of the intermediate positions are created:
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
                    "LineWidth",3,...
                    "MarkerSize",5,...
                    "MarkerEdgeColor",'green',...
                    "MarkerFaceColor",'green')
                hold on
                matrix_p = [matrix_p; us(j), y(i1)];  
                
            end
            i1 = i1 +2;
        end
        disp(['Uniforms users for now: ', num2str(countaux1)])
    
        % The image is conformed with the positions of the users:
        i1 = 1;
        for i = 1 : length(pos)
            pos1 = cell2mat(pos(i));
            for j = 1 : length(pos1)
                img_pos(y(i1),pos1(j)) = 255;
            end
            i1 = i1 + 2;
        end

        % The loop is broken if a certain number of users is exceeded
        % uniforms, to go on to add the random ones
        if countaux1 >= 65 
            break;
        end
    end

    %% The random positions of the users are graphed:
    
    % Uniform user positions are marked:

    while countaux1 < load_t
        countaux1 = countaux1 + 1;

        clear roi
        roi = drawpoint;
        point = roi.Position;
        plot(point(1), point(2),"square",...
            "LineWidth",3,...
            "MarkerSize",5,...
            "MarkerEdgeColor",'green',...
            "MarkerFaceColor",'green')
        hold on
        img_pos(point(2),point(1)) = 255;
        matrix_p = [matrix_p; point(1), point(2)]; 
        disp(['Total users for now: ', num2str(countaux1)])

    end

%     %% The initial positions of the APs are enabled
%     countaux2 = 1;
%     positions_ini = [];
%     while countaux2 <= n_APs
% 
%         clear roi
%         roi = drawpoint;
%         point = roi.Position;
%         plot(point(1), point(2),"o",...
%             "LineWidth",3,...
%             "MarkerSize",5,...
%             "MarkerEdgeColor",'red',...
%             "MarkerFaceColor",'red')
%         hold on
%         img_pos(point(2),point(1)) = 255;
%         positions_ini = [positions_ini; point(1), point(2)]; 
%         disp(['Total Aps for now: ', num2str(countaux2)])
% 
%         countaux2 = countaux2 + 1;
% 
%     end
    
    %% users image is saved
    path = "G:\Otros ordenadores\Backup Trabajo Maestria\Trabajo 2 CV Maestria\Fase 2\dataset users\users_t\";
    path = "C:\Users\GIIEE\Desktop\";
    imwrite(img_pos, path + string(file(1:end-4)) + "_" + string(count_u) + ".png");
    disp(['distribution: ', num2str(count_u), ' of: ', num2str(size_users), 'plain: ' , file(1:end-4)])

    positions_finals{count_u, 1} = matrix_p;
%     positions_ini_APs{count_u, 1} = positions_ini;

    count_u = count_u  + 1;

%     save(work + string(scenario)+ "_results.mat"); % Se va guardando en espacio de trabajo en cada iteración
end