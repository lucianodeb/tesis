function M = marcar_limite(puntos,original,color)
    tmp = uint8(zeros(192,512,3));
    puntos = puntos + 19;
    marca = pintar_polares(puntos,tmp, [255,0,0]);
    marca = marca(:,:,1);
   [rows,cols,d] = size(original);
   cy          = round(rows/2);
   cx          = round(cols/2);
   
   if exist('radius','var') == 0
      radius = min(round(rows/2),round(cols/2))-1;
   end
   
   if exist('angle','var') == 0
      angle = 512;
   end
   
   i = 1;
   for r=0:radius
      j = 1;
      for a=0:2*pi/angle:2*pi-2*pi/angle
       if marca(i,j) == 255
            original(cy+round(r*sin(a)),cx+round(r*cos(a)),1) = color(1);
            original(cy+round(r*sin(a)),cx+round(r*cos(a)),2) = color(2);
            original(cy+round(r*sin(a)),cx+round(r*cos(a)),3) = color(3);
        end;
         j = j + 1;
      end
      i = i + 1;
   end

M = original;

