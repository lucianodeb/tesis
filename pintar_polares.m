function M = pintar_polares(marcas,polares,color)
    C = numel(polares(1,:,1));    
    for col=1:1:C
        % La coversi?n a uint8 se necesita porque yFitted tiene 
        % valores double
        polares(uint8(marcas(col,1)),col,:) = color;
    end
M = polares;

