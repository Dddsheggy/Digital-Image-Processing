function C = Pruning(A, len)
% pruning branches shorter than len pixels
B = CreateEndpointSE();

X1 = A;
for k = 1:len
    endpoints = false(size(A));
    for m = 1:size(B,1)
        endpoints = endpoints | bwhitmiss(X1, B{m,1}, B{m,2});
    end
    X1(endpoints) = 0;
end

X2 = false(size(A));
for m = 1:size(B,1)
    endpoints = bwhitmiss(X1, B{m,1}, B{m,2});
    X2(endpoints) = 1;
end

se = strel(ones(3,3));
X3 = X2;
for k = 1:len
    X3 = imdilate(X3, se) & A;
end

C = X3 | X1; 

%--------------------
function B = CreateEndpointSE()
B{1,1} = [0 0 0; 1 1 0; 0 0 0];
B{1,2} = [0 1 1; 0 0 1; 0 1 1];
for k = 2:4
    B{k,1} = rot90(B{k-1,1});
    B{k,2} = rot90(B{k-1,2});
end
B{5,1} = [1 0 0; 0 1 0; 0 0 0];
B{5,2} = [0 1 1; 1 0 1; 1 1 1];
for k = 6:8
    B{k,1} = rot90(B{k-1,1});
    B{k,2} = rot90(B{k-1,2});
end
