function [w,r] = half(T)
% function [w,r] = half(T)

T(4,:) = T(1,:);

w = zeros(3,2);
r = 0.5*ones(3,2);

for i = 1:3
    w(i,:) = r(i,1)*T(i,:) + r(i,2)*T(i+1,:);
end

end