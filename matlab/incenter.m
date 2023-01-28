function u = incenter(T)
% function u = incenter(T)

u = zeros(1,2);

A = T(1,:);
B = T(2,:);
C = T(3,:);

a = sqrt((B(1)-C(1))^2 + (B(2)-C(2))^2);
b = sqrt((A(1)-C(1))^2 + (A(2)-C(2))^2);
c = sqrt((B(1)-A(1))^2 + (B(2)-A(2))^2);

p = a + b + c;

for i = 1:2
    u(i) = (a*A(i)+b*B(i)+c*C(i))/p;
end

end