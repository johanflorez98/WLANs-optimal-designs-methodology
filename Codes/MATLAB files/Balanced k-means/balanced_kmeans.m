function [partition_best, ubiAP_best, CapUsers_best] = balanced_kmeans(size_AP, positions_users, size_users, ...
                                plain, PT, GT, GR, v_ligth, F, bpd, ...
                                P_walls, K, T, B, colors, users_max, path_fi, case_ana, sc, pos_us, len)

%     xs = randi([1 256], size_AP, 1000);
%     ys = randi([1 256], size_AP, 1000);
%     xs = [1; 256; 1; 256];
%     ys = [1; 1; 256; 256];

    load("G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\Random positions APs\pos_" + string(size_AP) + "APs.mat");

    CapUsers_best = 0;
    number = 1;

    for p = 1 : length(xs)
        initial_APs = [xs(:,p) ys(:,p)];
            
        title_ = "Optimization's process about APs positions";
    
        % Iterations of the algorithm in general: 
        % The initial positions are established among all the 
        % space available for each iteration for the APs:                                                                                                                                                                                                                                                                                   
    
    %     switch size_AP
    %         case 1
    %             initial_APs = [128 128];
    %         case 2
    %             initial_APs = [128 1; 1 128];
    %         case 3
    %             initial_APs = [1 1; 256 1;Capusers_best 256 128];
    %         case 4
    %             initial_APs = [1 1; 256 1; 1 256; 256 256];
    %         case 5
    %             initial_APs = [1 1; 256 1; 1 256; 256 256; 128 128];
    %     end
    
         % Repetitions for each starting position:
         for iterations = 1 : 10 % Variations of balanced k-means iterations***
            % The cost matrix is formed:
            [matrix_cost, capacity] = cost_matrix(positions_users, initial_APs, size_AP, size_users, ...
                        plain, PT, GT, GR, v_ligth, F, bpd, P_walls, K, T, B);
            
            % Hungarian algorithm is executed:
            [assignment, cost] = munkres(matrix_cost);
    
            % The assignment of users to APs is carried out
            partition=zeros(1,size_users);
            for i = 1 : size_users
                if assignment(i) ~= 0
                        partition(assignment(i)) = mod(i,size_AP)+1;
                end
            end
    
            % Update AP location
            norm_AP = [];
            for j = 1:size_AP
                ubiAP(j,:) = mean(positions_users(find(partition == j),:)); 
                norm_AP = [norm_AP norm(initial_APs(j,:) - ubiAP(j,:))];
            end
            initial_APs = ubiAP;
            
            % If the APs do not move more than 50 cm each in the
            % current solution, k-means iteration breaks:
            if sum(norm_AP)*20/256 < 5/100*size_AP
                break;
            end
    
            %Get capacity from each of the users according to assigned AP
            for i = 1 : size_users
                [ca in] = max(capacity(:, i));
                cap_users(1,i) = capacity(in, i);
            end
        
            CapUsers_total = sum(cap_users)/users_max; % Total capacity of the users
            
            if (CapUsers_total > CapUsers_best)
                CapUsers_best = CapUsers_total;
                ubiAP_best = ubiAP;
                partition_best = partition;
                disp(['New capacity:, ', num2str(CapUsers_best),' bps, iteration: ', num2str(iterations), ' - ', num2str(p), '/', num2str(length(xs))])
            
                % A portion of the optimization process is shown each iteration to not load memory
%                 close all
                grapichs(number, plain, size_users, ...
                            size_AP, positions_users, ...
                            ubiAP_best, colors, partition, title_);
%                 disp('save')
                % save_aps(path_fi + string(case_ana) + "users\", size_AP, sc, pos_us, ubiAP_best, len)
%                 number = number + 1;
            end
    
         end % Balanced k-means is terminated***
    end
end