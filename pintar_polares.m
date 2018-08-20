function M = pintar_polares(F,C,marcas,polares,color)
    polares = polares;
    for col=1:1:C
        % La coversi?n a uint8 se necesita porque yFitted tiene 
        % valores double
        polares(uint8(marcas(col,1)),col,:) = color;
    end
M = polares;

