function M = jaccard(frame,membrana,alturas)
    frame = strrep(frame,'_1',membrana);
    ground_truth_cartesianas = imread(frame);
    [F,C] = size(ground_truth_cartesianas);   
    gradiente_cartesianas = uint8(zeros(F,C));
    for i=1:1:numel(alturas)
        gradiente_cartesianas(1:alturas(1,i),i) = 255;
    end
M = sum(ground_truth_cartesianas(:) & gradiente_cartesianas(:)) / sum(ground_truth_cartesianas(:) | gradiente_cartesianas(:));

