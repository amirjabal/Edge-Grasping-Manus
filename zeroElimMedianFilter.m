function [ R ] = zeroElimMedianFilter( I )
    rows = size(I, 1);
    cols = size(I, 2);
    R = zeros(rows, cols, class(I));
    I = hhf_pad(I);
   
    i = (-2:2);
    j = i;
    for m = 0:rows-1
        for n = 0:cols-1
            A = I(m+i+3, n+j+3);
            A = reshape(A, 1, size(A, 1) * size(A, 2));
            A = A(A ~= 0);
            if ~isempty(A)
                A = sort(A);
                R(m+1, n+1) = A(ceil(size(A, 2) / 2));
            else
                R(m+1, n+1) = I(m+1, n+1);
            end
        end
    end
end

