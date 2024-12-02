function dist = calcDistance(pos1, pos2)
    dist = sqrt(sum((pos1-pos2).^2));
end