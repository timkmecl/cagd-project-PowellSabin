f = @(x,y) sin(x) + y^2 + x*y;
f_x = @(x,y) cos(x) + y;
f_y = @(x, y) 2*y + x;
f_xx = @(x,y) -sin(x);
f_xy = @(x,y) 1;
f_yy = @(x,y) 2;
f_xxx = @(x,y) -cos(x);
f_xxy = @(x,y) 0;
f_xyy = @(x,y) 0;
f_yyy = @(x,y) 0;

H = @(x,y) [f_xx(x,y) f_xy(x,y); f_xy(x,y) f_yy(x,y)];
f3 = @(x,y) [f_xxx(x,y) f_xxy(x,y) f_xyy(x,y) f_yyy(x,y)];

points = [-1.7 -1; -0.5 -1; -0.5 0];
%points = [0 0 ; 1 0; 0 1];

points = [-3 -3 ; 3 -3; -3 3];
TRI = [1 2 3];
[ut, vs, ws] = PS_refinement(TRI, points);


Cs = c2ps(vs{1}, ws{1}, ut, f, f_x, f_y, H, f3);

v = vs{1};
w = ws{1};
u = ut;
Bz = Cs;

Bx = cell(1,6);
By = cell(1,6);

for i = 1:6
    Bx{1,i} = zeros(6);
    By{1,i} = zeros(6);
end

for i = 1:3
    for j = 0:5
        for k = 0:5-j
            D = (5-j-k)/5*v(i,:) + k/5*ut + j/5*w(i,:);
            Bx{1,2*i-1}(k+1,j+1) = D(1);
            By{1,2*i-1}(k+1,j+1) = D(2);
            
            D = (5-j-k)/5*v(mod(i, 3)+1,:) + k/5*ut + j/5*w(i,:);
            Bx{1,2*i}(k+1,j+1) = D(1);
            By{1,2*i}(k+1,j+1) = D(2);
        end
    end
end

BX = Bx;
BY = By;
BZ = Bz;
for i = 1:6
    BX{i} = Bx{i};
    BX{i} = BX{i}(:);
    BX{i} = BX{i}(~isnan(BX{i}));

    BY{i} = By{i};
    BY{i} = BY{i}(:);
    BY{i} = BY{i}(~isnan(BY{i}));

    BZ{i} = Bz{i};
    BZ{i} = BZ{i}(:);
    BZ{i} = BZ{i}(~isnan(BZ{i}));
end


[TRI,U] = trimeshgrid(5);
for i = 1:6
    scatter3(BX{i},BY{i},BZ{i},'MarkerEdgeColor','#272946','MarkerFaceColor','#eda031');
    hold on
end

figure

[TRI,U] = trimeshgrid(50);

B = cell(1,6);
for i = 1:6
    B{i} = bezier3(Bx{i},By{i},Bz{i},U);
end


for i = 1:6
    trisurf(TRI,B{i}(:,1),B{i}(:,2),B{i}(:,3), 'EdgeColor', 'None');
    hold on
end