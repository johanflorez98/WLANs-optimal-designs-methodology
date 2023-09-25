function C_c = capacity(Distance, size_AP, size_users, ...
                                    plain, positions_users, positions_APs, ...
                                    PT, GT, GR, v_ligth, F, bpd, P_walls, K, T, B)

    m = 0;
    
    for i = 1:size_AP
        for j = 1:size_users

            m = calculate_wall_count(plain, [positions_APs(i,1) positions_APs(i,2)],[positions_users(j,1) positions_users(j,2)]);
            
            D = Distance(i,j);
            if D <= bpd
                PR1 = PT + GT + GR + 20*log10(v_ligth/(4*pi)) - 20*log10(F) - 20*log10(D) - P_walls*m;
                if PR1 == inf 
                    PR1 = PT;
                end
                PRw(i,j) = 10^(PR1/10)/1000; 
            end
            if D > bpd
                PR1 = PT + GT + GR + 20*log10(v_ligth/(4*pi)) - 20*log10(F) - 20*log10(D) - P_walls*m - 35*log10(D/bpd);
                if PR1 == inf 
                    PR1 = PT;
                end
                if PR1 <= 10*log10((K*T*B)/1e-3)
                    PR1 = 10*log10((K*T*B)/1e-3);
                end
                PRw(i,j) = 10^(PR1/10)/1000;
            end
        end
    end

    SINR = PRw/(K*T*B);

    C_c = log2(1 + SINR);
end