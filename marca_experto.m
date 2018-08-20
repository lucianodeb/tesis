function M = marca_experto(frame,membrana)
    frame = strrep(frame,'_1',membrana);
    I = imread(frame);
    [F,C] = size(I);        
    out = uint8(ones(C,1));
    for i=1:1:F-1
        for j=1:1:C
            if I(i,j) ~= I(i+1,j)
                out(j,1) = i;
            end;
        end
    end

M = out;

