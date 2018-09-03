
close all; clear;
clc;
mapHaralick = containers.Map; mapHaralick('contraste') = 2; mapHaralick('correlacion') = 3; mapHaralick('varianza') = 4; mapHaralick('suma_promedio') = 6;

PATH_FRAMES = strcat(pwd, '/frames/'); % En esta carpeta est?n las imagenes IVUS y los txt que contienen las marcas hechas por el experto

%Obtenemos lista de imagenes IVUS.
frames = dir(strcat(PATH_FRAMES,'/*.png'));

COUNT_FRAMES = length(frames);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seteamos los par?metros con los que vamos a trabajar:
% 1)VENTANA: es un coeficiente que se utiliza para tomar un tama?o de ventana
% proporcional al tama?o de la imagen original.
% 2) Desplazamiento en Y
% 3) Desplazamiento en X
% 4) LARGO considerado para el calculo del gradiente.
% 5) INDICADOR_NAME el indicador que utilizaremos (contraste, correlacion,
% varianza o suma_promedio).

VENTANA = 22.5;
Y = 2;
X = 3;
LARGO = 10;
INDICADOR_NAME = 'contraste'; %Cambio respecto a MA
count = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for f=1:1:COUNT_FRAMES
    frame = strcat(PATH_FRAMES,frames(f,1).name);
    if isempty(regexp(frame,'\/\d+_polar_1.png$','match')) == 1
        continue;
    end
    
    ivus_polares_original = imread(frame);
    ivus_polares = ivus_polares_original(:,:,1);
    
    % Obtenemos los haralick_features de la imagen IVUS convertida a polares con: x, y y la VENTANA
    % Recordar que VENTANA es un coeficiente. Para 22.5, el tama?o de ventana es 9x23 (alto x ancho).
    indicador = indicadores(ivus_polares,Y,X,VENTANA,frame,mapHaralick(INDICADOR_NAME));                
    
    name = frame; name = strrep(name,PATH_FRAMES,''); name = strcat(INDICADOR_NAME, '_',name,'.png','');    
    tmp = gradiente(indicador,LARGO,name,ivus_polares);
    mapa_gradiente = tmp.mapa;
    
    
    rango = max(indicador(:))-min(indicador(:));
    indicadorNorm = (indicador-min(indicador(:)))/rango;

   
    %Curve fitting
    step = 2*pi / 512;
    timevec=0:step:2*pi;
    xSin=timevec(1:512);
    ySin =tmp.alturas;
    
    [fitresult, gof] = functionFourier1(xSin, ySin);
    
    yFitted = fitresult(xSin);
    
%     figure('Name','gradiente solo'); imshow(ivus_polares);
%     hold on; plot(xSin/step,yFitted,'g'); hold off;
    
%    -------MODIFICACION SEGUN EL VALOR DE INDICADOR POR ENCIMA----------
        
    thContraste = 0.4;
    alturaAnt = tmp.alturas - LARGO;
    alturaAnt = max(ones(size(alturaAnt)),alturaAnt);
    
    ySinModif = [];
    xSinModif = [];
    
    for i=1:length(alturaAnt)
        
        if indicador(alturaAnt(i),i)<thContraste
            ySinModif = [ySinModif,ySin(i)];
            xSinModif = [xSinModif,xSin(i)];
        end
        
    end
    
    [fitresult, gof] = functionFourier1(xSinModif, ySinModif);
    
    yFitted2 = fitresult(xSin);

    marcas = marca_experto(frame,'_L');    
    
    %%Obtengo Metricas %%
    JI = jaccard(frame,'_L',tmp.alturas);
    jaccards(1,count) = JI;
    Hausdorff = HausdorffDist(pares(marcas),pares(yFitted));
    hausdorff(1,count) = Hausdorff;
    count = count+1;

    resultado = pintar_polares(marcas,ivus_polares_original,[0,255,0]);        
    segmentation = pintar_polares(yFitted2,resultado,[255,0,0]);
    %%Completo los pixels correspondinetes al cateter, as? puedo
    %%reconstruir a cartesianas.
    tmp2 = uint8(zeros(192,512,3));
    tmp2(20:192,:,:) = segmentation;
    segmentation = tmp2;

    lado = 384;
    out = uint8(ones(lado,lado,3));
    out(:,:,1) = PolarToIm(segmentation(:,:,1),0,1,lado,lado);        
    out(:,:,2) = PolarToIm(segmentation(:,:,2),0,1,lado,lado);        
    out(:,:,3) = PolarToIm(segmentation(:,:,3),0,1,lado,lado);        
    imshow(out,[]);    
    pause;
    
    close all;
end