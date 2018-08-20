function M = completa_ancho(I,ventana)
    [F,C] = size(I);
    ancho_extra = int16(C / (ventana));
    alto_extra = int16(F / ventana);
    
    N = double(ones(F+alto_extra*2,C+ancho_extra*2));
    
    N(alto_extra+1:alto_extra+F,ancho_extra+1:ancho_extra+C) = I;

    N(1:alto_extra,ancho_extra+1:ancho_extra+C) = flipud(I(1:alto_extra,:));
    N(alto_extra+F+1:F+alto_extra*2,ancho_extra+1:ancho_extra+C) = flipud(I(F-alto_extra+1:F,:));
    
    N(:,1:ancho_extra) = fliplr(N(:,ancho_extra+1:ancho_extra*2));
    N(:,ancho_extra+1+C:ancho_extra*2+C) = fliplr(N(:,C+1:C+ancho_extra));    
    
    
    M = N;
