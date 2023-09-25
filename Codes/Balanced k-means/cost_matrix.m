function [matrix_cost, capacity1] = cost_matrix(positions_users, positions_APs, size_AP, size_users, ...
                                                plain, PT, GT, GR, v_ligth, F, bpd, P_walls, K, T, B)
        
    % The Euclidean distance between users and APs is calculated:
    Distance = pdist2(positions_users, positions_APs)';

    Distance = Distance*20/256; % The distances are scaled according to the dimension of the plane,
                                % in this case a maximum distance of 20
                                % meters

    % The capacity of each user is calculated with respect to the number of
    % APs
    % tic
    capacity1 = capacity(Distance, size_AP, size_users, ...
            plain, positions_users, positions_APs, ...
            PT, GT, GR, v_ligth, F, bpd, P_walls, K, T, B);
    % toc

    % The cost matrix is formed:
    for i=1:size_users
        matrix_cost(i, :) = capacity1((mod(i, size_AP)+1),:);
    end

    cap_max = max(max(matrix_cost));
    cap_min = min(min(matrix_cost));
    matrix_cost = cap_max+cap_min-matrix_cost;
end