function M = indicadores(I,disty,distx,coeficiente_ventana,frame,num_indicador)

frame = regexp(frame,'\d+_polar_\d+','match');
ROOT = strcat(pwd,'/INDICADORES/');
folder = strcat(ROOT,frame);
folder = folder{1,1};
mkdir(folder);

destino = strcat(ROOT,frame,'/','indicadores_v',int2str(coeficiente_ventana),'y',int2str(disty),'x',int2str(distx),'.mat');
destino = destino{1,1};

[fil,col] = size(I);
margen_ancho = int16(col / (coeficiente_ventana));
margen_alto = int16(fil / coeficiente_ventana);

S1 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S2 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S3 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));
S4 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S5 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S6 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));
S7 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S8 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S9 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));
S10 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S11 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S12 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));
S13 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));S14 = zeros(fil-(2*margen_alto),col-(2*margen_ancho));

if exist(destino, 'file') == 2
    indicadores = load(destino);
    if num_indicador == 1
        M = indicadores.S1;
    elseif num_indicador == 2
        M = indicadores.S2;
    elseif num_indicador == 3
        M = indicadores.S3;
    elseif num_indicador == 4
        M = indicadores.S4;
    elseif num_indicador == 5
        M = indicadores.S5;
    elseif num_indicador == 6
        M = indicadores.S6;
    elseif num_indicador == 7
        M = indicadores.S7;
    elseif num_indicador == 8
        M = indicadores.S8;
    elseif num_indicador == 9
        M = indicadores.S9;
    elseif num_indicador == 10
        M = indicadores.S10;
    end;    
else
    
    I = completa_ancho(I,coeficiente_ventana);
    I = uint8(I);


    [fil,col] = size(I);
    for i=1:1:(fil-margen_alto * 2)
        for j=1+margen_ancho:1:col-margen_ancho

            subImagen = I(i:i+2 * margen_alto,j-margen_ancho:j+margen_ancho);
            matrizCoOcurrencia =  graycomatrix(subImagen, 'offset', [disty distx]);
            matrizCoOcurrencia = matrizCoOcurrencia/sum(matrizCoOcurrencia(:));
            indicadores = haralickTextureFeatures(matrizCoOcurrencia);

            S1(i,j-margen_ancho) = indicadores(1);   
            S2(i,j-margen_ancho) = indicadores(2);   
            S3(i,j-margen_ancho) = indicadores(3);   
            S4(i,j-margen_ancho) = indicadores(4);   
            S5(i,j-margen_ancho) = indicadores(5);   
            S6(i,j-margen_ancho) = indicadores(6);   
            S7(i,j-margen_ancho) = indicadores(7);   
            S8(i,j-margen_ancho) = indicadores(8);   
            S9(i,j-margen_ancho) = indicadores(9);   
            S10(i,j-margen_ancho) = indicadores(10);   
            S11(i,j-margen_ancho) = indicadores(11);   
            S12(i,j-margen_ancho) = indicadores(12);   
            S13(i,j-margen_ancho) = indicadores(13);   
            S14(i,j-margen_ancho) = indicadores(14);   
        end
    end
    save(destino,'S1','S2','S3','S4','S5','S6','S7','S8','S9','S10');

    if num_indicador == 1
        M = S1;
    elseif num_indicador == 2
        M = S2;
    elseif num_indicador == 3
        M = S3;
    elseif num_indicador == 4
        M = S4;
    elseif num_indicador == 5
        M = S5;
    elseif num_indicador == 6
        M = S6;
    elseif num_indicador == 7
        M = S7;
    elseif num_indicador == 8
        M = S8;
    elseif num_indicador == 9
        M = S9;
    elseif num_indicador == 10
        M = S10;
    end;

end 