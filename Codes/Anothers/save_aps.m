function save_APs(path, size_AP, sc, pos_us, ubiAP, len)

    image_APs = zeros(len(1), len(2));  
    for j = 1 : size_AP
        image_APs(round(ubiAP(j,2)), round(ubiAP(j,1))) =  255;
    end     
    imwrite(image_APs, path + "APs_t\" + string(size_AP) + "APs\" + string(sc) + "_" + string(pos_us) + ".png");
end