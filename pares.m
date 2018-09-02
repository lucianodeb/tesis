function M = pares(Ys)
    N = numel(Ys);
    Ys = uint16(Ys);
    points = uint16(ones(N,2));
    for i=1:1:N
        points(i,:) = [Ys(i),i];
    end
    M = points;
end
