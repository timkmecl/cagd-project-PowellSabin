f = @(x,y) 3*(1-x).^2.*exp(-x.^2 - (y+1).^2) ...
- 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
- 1/3*exp(-(x+1).^2 - y.^2);

dxf = @(x,y) (exp(-(x + 1)^2 - y^2)*(2*x + 2))/3 ...
+ 3*exp(- (y + 1)^2 - x^2)*(2*x - 2) ...
+ exp(- x^2 - y^2)*(30*x^2 - 2) ...
- 6*x*exp(- (y + 1)^2 - x^2)*(x - 1)^2 ...
- 2*x*exp(- x^2 - y^2)*(10*x^3 - 2*x + 10*y^5);

dyf = @(x,y) (2*y*exp(- (x + 1)^2 - y^2))/3 ...
+ 50*y^4*exp(- x^2 - y^2) ...
- 3*exp(- (y + 1)^2 - x^2)*(2*y + 2)*(x - 1)^2 ...
- 2*y*exp(- x^2 - y^2)*(10*x^3 - 2*x + 10*y^5);

Df = @(x,y) [dxf(x,y); dyf(x,y)];

T = [-1.7 -1; -0.5 -1; -0.5 0];
u = incenter(T);
[w,r] = half(T);
Tpom = [T(1,:); w(1,:); T(2,:); w(2,:); T(3,:); w(3,:); T(1,:)];
Bz = PowellSabine(T,u,w,r,f,Df);

Bx = cell(1,6);
By = cell(1,6);

for i = 1:6
    Bx{1,i} = nan(3);
    By{1,i} = nan(3);
end

for i = 1:6
    for j = 0:2
        for k = 0:2-j
            D = (2-j-k)/2*Tpom(i,:) + k/2*Tpom(i+1,:) + j/2*u;
            Bx{1,i}(j+1,k+1) = D(1);
            By{1,i}(j+1,k+1) = D(2);
        end
    end
end

[TRI,U] = trimeshgrid(50);

B = cell(1,6);
for i = 1:6
    B{1,i} = bezier3(Bx{1,i},By{1,i},Bz{1,i},U);
end

for i = 1:6
    trisurf(TRI,B{1,i}(:,1),B{1,i}(:,2),B{1,i}(:,3), 'EdgeColor', 'None');
    hold on
end

%for i = 1:6
%    plot3([Bx{1,i}(1,1); Bx{1,i}(1,2); Bx{1,i}(2,1); Bx{1,i}(1,1)],[By{1,i}(1,1); By{1,i}(1,2); By{1,i}(2,1); By{1,i}(1,1)],[Bz{1,i}(1,1); Bz{1,i}(1,2); Bz{1,i}(2,1); Bz{1,i}(1,1)],'Color','#272946','LineWidth',1);
%    plot3([Bx{1,i}(2,1); Bx{1,i}(2,2); Bx{1,i}(3,1); Bx{1,i}(2,1)],[By{1,i}(2,1); By{1,i}(2,2); By{1,i}(3,1); By{1,i}(2,1)],[Bz{1,i}(2,1); Bz{1,i}(2,2); Bz{1,i}(3,1); Bz{1,i}(2,1)],'Color','#272946','LineWidth',1);
%    plot3([Bx{1,i}(1,3); Bx{1,i}(2,2); Bx{1,i}(1,2); Bx{1,i}(1,3)],[By{1,i}(1,3); By{1,i}(2,2); By{1,i}(1,2); By{1,i}(1,3)],[Bz{1,i}(1,3); Bz{1,i}(2,2); Bz{1,i}(1,2); Bz{1,i}(1,3)],'Color','#272946','LineWidth',1);
%    scatter3(Bx{1,i},By{1,i},Bz{1,i},'MarkerEdgeColor','#272946','MarkerFaceColor','#eda031');
%end

