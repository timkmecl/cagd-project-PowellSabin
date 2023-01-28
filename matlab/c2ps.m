function Cs = c2ps(vs, ws, ut, f, f_x, f_y, H, f3)

Cs = cell(6, 1);

% določi vogalnih 10 vozlišč vsakeag trikotnika
for i = 1:3
    v = vs(i, :);
    w = ws(i, :);
    M = robnih10(v,w,ut,f,f_x,f_y,H, f3);
    Cs{2*i - 1} = M;
    
    v = vs(mod(i, 3)+1, :);
    w = ws(i, :);
    M = robnih10(v,w,ut,f,f_x,f_y,H, f3);
    Cs{2*i} = M;
end

% reši sisteme za vmesnih 9 na in ob <w_i, u_T>
for i = 1:3
    M1 = Cs{2*i - 1};
    M2 = Cs{2*i};
    T = [vs(i, :); ws(i, :); ut];
    alpha = pointbary(vs(mod(i, 3)+1, :), T);
    for k = 0:2
        b = [M1(k+1, 6-k); M1(k+1, 6-k-1); M1(k+1, 6-k-2); M1(k+1, 6-k-3)];
        bw = [M2(k+1, 6-k); M2(k+1, 6-k-1); M2(k+1, 6-k-2); M2(k+1, 6-k-3)];
        x = c3sistem(alpha, b, bw);
        
        M1(k+1, 6-k) = x(1);
        M1(k+1, 6-k-1) = x(2);
        M2(k+1, 6-k) = x(1);
        M2(k+1, 6-k-1) = x(3);
    end
    Cs{2*i - 1} = M1;
    Cs{2*i} = M2;
end

% reši sistem na robu <v_1, u_T>
M1 = Cs{1};
M2 = Cs{6};
c = @(i,j,k) M1(k+1,j+1);
cc = @(i,j,k) M2(k+1,j+1);

T = [vs(1, :); ws(1, :); ut];
beta = pointbary(ws(3, :), T);

A = [beta(3)^2 2*beta(2)*beta(3); beta(3)^3 3*beta(3)^2*beta(2)];
C = [cc(1,2,2) - (beta(1)^2*c(3,0,2) + beta(2)^2*c(1,2,2) + 2*beta(1)*beta(2)*c(2,1,2) + 2*beta(1)*beta(3)*c(2,0,3)); 
    cc(1,3,1) - (beta(1)^3*c(4,0,1) + beta(2)^3*c(1,3,1) + 3*beta(1)^2*beta(2)*c(3,1,1) + 3*beta(1)^2*beta(3)*c(3,0,2) + 3*beta(2)^2*beta(1)*c(2,2,1) + 3*beta(2)^2*beta(3)*c(1,2,2) + 3*beta(3)^2*beta(1)*c(2,0,3) + 6*beta(1)*beta(2)*beta(3)*c(2,1,2))];
x = A\C; 
M1(5,1) = x(1);
M1(4,2) = x(2);
M2(5,1) = x(1);
M2(4,2) = beta(1)*M1(4,1) + beta(2)*M1(4,2) + beta(3)*M1(5,1);

Cs{1} = M1;
Cs{6} = M2;


% točke na razdalji 3 od zunanjega roba spodaj
M1 = Cs{1};
M2 = Cs{2};
c = @(i,j,k) M1(k+1,j+1);
cc = @(i,j,k) M2(k+1,j+1);
T = [vs(1, :); ws(1, :); ut];
alpha = pointbary(vs(2, :), T)

M1(4,3) = (M2(4,1) - (alpha(1)^2)*M1(4,1) - 2*(alpha(1)*alpha(2))*M1(4,2))/(alpha(2)^2);
M2(4,3) = M1(4,3);
M2(4,2) = alpha(1)*M1(4,2) + alpha(2)*M1(4,3);

Cs{1} = M1;
Cs{2} = M2;

% točke na razdalji 3 od zunanjega roba zgoraj levo
M1 = Cs{6};
M2 = Cs{5};
c = @(i,j,k) M1(k+1,j+1);
cc = @(i,j,k) M2(k+1,j+1);
T = [vs(1, :); ws(3, :); ut];
alpha = pointbary(vs(3, :), T);

M1(4,3) = (M2(4,1) - (alpha(1)^2)*M1(4,1) - 2*(alpha(1)*alpha(2))*M1(4,2))/(alpha(2)^2);
M2(4,3) = M1(4,3);
M2(4,2) = alpha(1)*M1(4,2) + alpha(2)*M1(4,3);

Cs{6} = M1;
Cs{5} = M2;

% reši sistem na robu <v_2, u_T>
M1 = Cs{2};
M2 = Cs{3};
c = @(i,j,k) M1(k+1,j+1);
cc = @(i,j,k) M2(k+1,j+1);

T = [vs(2, :); ws(1, :); ut];
beta = pointbary(ws(2, :), T);

M1(5,1) = (cc(1,2,2) - (beta(1)^2*c(3,0,2) + beta(2)^2*c(1,2,2) + 2*beta(1)*beta(2)*c(2,1,2) + 2*beta(1)*beta(3)*c(2,0,3) + 2*beta(2)*beta(3)*c(1,1,3))) / beta(3)^2;
M2(5,1) = M1(5,1);
M2(4,2) = beta(1)*M1(4,1) + beta(2)*M1(4,2) + beta(3)*M1(5,1);

Cs{2} = M1;
Cs{3} = M2;

% reši sistem na robu <v_3, u_T>
M1 = Cs{5};
M2 = Cs{4};
c = @(i,j,k) M1(k+1,j+1);
cc = @(i,j,k) M2(k+1,j+1);

T = [vs(3, :); ws(3, :); ut];
beta = pointbary(ws(2, :), T);

M1(5,1) = (cc(1,2,2) - (beta(1)^2*c(3,0,2) + beta(2)^2*c(1,2,2) + 2*beta(1)*beta(2)*c(2,1,2) + 2*beta(1)*beta(3)*c(2,0,3) + 2*beta(2)*beta(3)*c(1,1,3))) / beta(3)^2;
M2(5,1) = M1(5,1);
M2(4,2) = beta(1)*M1(4,1) + beta(2)*M1(4,2) + beta(3)*M1(5,1);

Cs{5} = M1;
Cs{4} = M2;



% zadnja točka na oddaljenosti 3 od zunanjega roba
M1 = Cs{3};
M2 = Cs{4};
T = [vs(i, :); ws(i, :); ut];
alpha = pointbary(vs(mod(i, 3)+1, :), T);

M1(4, 3) = (M2(4,2) - alpha(1)*M1(4,2)) / alpha(2);
M2(4, 3) = M1(4,3);

Cs{3} = M1;
Cs{4} = M2;


% sredinske točke na razdalji 4 od zunanjega roba
for i = 1:3
    M1 = Cs{2*i - 1};
    M2 = Cs{2*i};
    T = [vs(i, :); ws(i, :); ut];
    alpha = pointbary(vs(mod(i, 3)+1, :), T);
    
    M1(5, 2) = (M2(5,1) - alpha(1)*M1(5,1)) / alpha(2);
    M2(5, 2) = M1(5,2);
    
    Cs{2*i - 1} = M1;
    Cs{2*i} = M2;
end


% cisto na sredini
gamma = pointbary(ut, vs);
x = gamma(1)*Cs{1}(5,1) + gamma(2)*Cs{3}(5,1) + gamma(3)*Cs{5}(5,1);
for i = 1:6
    Cs{i}(6,1) = x;
end

end



function x = c3sistem(alpha, b, bw)
    A = [alpha(2)^2 2*alpha(1)*alpha(2); alpha(2)^3 3*alpha(1)*alpha(2)^2];
    c = [bw(3) - b(3)*alpha(1)^2 ; bw(4) - b(4)*alpha(1)^3 - 3*b(3)*alpha(2)*alpha(1)^2];
    x = A\c;
    x(3) = alpha(1)*x(2) + alpha(2)*x(1);
end



function M = robnih10(v, w, ut, f, f_x, f_y, H, f3) 
d1 = w - v;
d2 = ut - v;
c500 = f(v(1), v(2));
c410 = f(v(1), v(2)) + (1/5)*(d1(1)*f_x(v(1), v(2)) + (d1(2))*f_y(v(1), v(2)));
c401 = f(v(1), v(2)) + (1/5)*(d2(1)*f_x(v(1), v(2)) + (d2(2))*f_y(v(1), v(2)));

c320 = -c500 + 2*c410 + (1/20)* d1*H(v(1), v(2))*d1';
c302 = -c500 + 2*c401 + (1/20)* d2*H(v(1), v(2))*d2';
c311 = -c500 + c410 + c401 + (1/20)* d1*H(v(1), v(2))*d2';

c230 = c500 - 3*c410 + 3*c320 + (1/60)*D3f(f3, d1, d1, d1, v);
c203 = c500 - 3*c401 + 3*c302 + (1/60)*D3f(f3, d2, d2, d2, v);
c221 = c500 - c401 - 2*c410 + 2*c311 + c320 + (1/60)*D3f(f3, d2, d1, d1,v);
c212 = c500 - c410 - 2*c401 + 2*c311 + c302 + (1/60)*D3f(f3, d2, d2, d1,v);

M = zeros(6);
M(1, 1) = c500;

M(1, 2) = c410;
M(2, 1) = c401;

M(1, 3) = c320;
M(2, 2) = c311;
M(3, 1) = c302;

M(1, 4) = c230;
M(2, 3) = c221;
M(3, 2) = c212;
M(4, 1) = c203;
end

function d = D3f(f3, d1, d2, d3,v)
f3v = f3(v(1), v(2));
fxxx = f3v(1);
fyxx = f3v(2);
fyyx = f3v(3);
fyyy = f3v(4);

d = fxxx*d1(1)*d2(1)*d3(1);
d = d + fyxx*(d1(2)*d2(1)*d3(1) + d1(1)*d2(2)*d3(1) + d1(1)*d2(1)*d3(2));
d = d + fyyx*(d1(2)*d2(2)*d3(1) + d1(2)*d2(1)*d3(2) + d1(1)*d2(2)*d3(2));
d = d + fyyy*d1(2)*d2(2)*d3(2);
end