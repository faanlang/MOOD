function [orde] = orden(deso);

N = length(deso);
orde = ones(N,1);
val = 1;
orde(1) = 1;
for i=2:N
    if deso(i) ~= deso(i-1)
    val = val +1;    
    end
    orde(i) = val;
end

end