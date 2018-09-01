function M = gradiente(I,largo,name,ivus_polares)

% Este m?todo seguramente se puede implementar de manera m?s eficiente con
% circshift, pero me complic? un poco hacerlo con 'largo' variable y como
% tampoco es la prioridad por ahora, lo dej? as?.

[t1,t2] = size(I);
out = zeros(t1,t2);
gradientes = ones(t1,t2);
maximos = [1,t2];
alturas = [1,t2];
medias = [1,t2];
S = 15;
W = ones(S) ./ (S*S);
media = conv2(single(ivus_polares),single(W));

for i=1:1:t2
    maxi = ones(1,4);
    for j=largo+1:1:t1-largo
        gradientes(j,i) = sum(I(j-largo:j-1,i),'omitnan') - sum(I(j+1:j+largo,i),'omitnan');
        if gradientes(j,i) < maxi(1,3)
            maxi(1,1) = j;
            maxi(1,2) = i;
            maxi(1,3) = gradientes(j,i);
            maxi(1,4) = media(j,i);
        end
    end
    
    maximos(1,i) = maxi(1,3); 
    alturas(1,i) = maxi(1,1); 
    medias(1,i) = maxi(1,4);
    out(maxi(1,1),maxi(1,2)) = 1;
end

ret.mapa = uint8(out);
ret.maximos = maximos;
ret.alturas = alturas;
ret.medias = medias;
M = ret;
