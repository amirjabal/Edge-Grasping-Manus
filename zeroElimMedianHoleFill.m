function [ R, n ] = zeroElimMedianHoleFill( I )
    n = 1;
    R = zeroElimMedianFilter(I);
    hasHoles = ~all(all(R));
    while hasHoles
        R = zeroElimMedianFilter(R);
        hasHoles = ~all(all(R));
        n = n + 1;
    end
end

