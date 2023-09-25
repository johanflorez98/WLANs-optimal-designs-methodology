function grapichs(number, plain1, size_users, ...
                    size_AP, positions_users, ...
                    ubiAP, colors, partition, title_)
    
    map = figure(number);
    map.Color = 'white';
    a = plain1;
    imshow(a);
    hold on 
    axis image;
    set(gca, 'xtick', [], 'ytick', []); 
    % title(title_, Interpreter = "latex", FontSize= 15)
    for i = 1 : size_users
        plot(positions_users(i,1),positions_users(i,2),"square",...
            "LineWidth",3,...
            "MarkerSize",5,...
            "MarkerEdgeColor",colors(partition(i)),...
            "MarkerFaceColor",colors(partition(i)))
        hold on
    end
    for i = 1 : size_AP
        plot(ubiAP(i,1),ubiAP(i,2),"o",...
            "LineWidth",3,...
            "MarkerSize",10,...
            "MarkerEdgeColor",colors(i),...
            "MarkerFaceColor",colors(i))
        text(ubiAP(i,1),ubiAP(i,2),string(i),Color='white',FontSize=15,Interpreter='latex')
    end

    % % The image is saved in RGB:
    % fileName = "G:\Otros ordenadores\False-2-Tesis-Maestria\DataSet5GHz\Users-and-APsOpti-final\Writing\sample_5.png";
    % 
    % Fig = getframe(gca);
    % imwrite(Fig.cdata,  fileName);
end