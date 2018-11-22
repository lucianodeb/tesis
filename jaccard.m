function M = jaccard(frame,membrana,alturas)
    frame = strrep(frame,'_1',membrana);
    ground_truth_cartesianas = imread(frame);
    ground_truth_cartesianas = ground_truth_cartesianas(:,:,1);
    [F,C] = size(ground_truth_cartesianas);   
    gradiente_cartesianas = uint8(zeros(F,C));
    for i=1:1:numel(alturas)
        gradiente_cartesianas(1:floor(alturas(1,i)),i) = 255;
    end
    ground_truth_cartesianas = ground_truth_cartesianas(:,:,1);
    
    lado = 384;
    tmp1 = uint8(zeros(192,512));
    tmp1(1:19,:) = tmp1(1:19,:) + 255;
    tmp1(20:192,:) = ground_truth_cartesianas;
    out = uint8(ones(lado,lado));
    out(:,:) = PolarToIm(tmp1(:,:),0,1,lado,lado);        
    ground_truth_cartesianas = out;
    
    lado = 384;
    tmp1 = uint8(zeros(192,512));
    tmp1(1:19,:) = tmp1(1:19,:) + 255;
    tmp1(20:192,:) = gradiente_cartesianas;
    out = uint8(ones(lado,lado));
    out(:,:) = PolarToIm(tmp1(:,:),0,1,lado,lado);        
    gradiente_cartesianas = out;
M = sum(ground_truth_cartesianas(:) & gradiente_cartesianas(:)) / sum(ground_truth_cartesianas(:) | gradiente_cartesianas(:));

