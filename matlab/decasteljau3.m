function b = decasteljau3(B, u)
n = size(B, 1) - 1;
for k = 1:n 
    BB = zeros(size(B));
    for i = 1:(n+2-k)
       for j = 1:(n+2-k-i)
           BB(i, j) = u(1)*B(i,j) + u(2)*B(i,j+1) + u(3)*B(i+1,j);
       end
    end
    B = BB;
end

b = B(1,1);
end