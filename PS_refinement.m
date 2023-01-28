function [incenters, vs, ws] = PS_refinement(TRI, points)
% calculates PS refinement of triangulation
% VHOD:
% t = triangulacije (tringulation object)
%
%IZHOD:
% PS refinement triangulacije (triangulation object)

n = size(TRI, 1);
incenters = get_incenters(TRI, points);
vs = cell(n, 1);
ws = cell(n, 1);

n = size(TRI, 1);
for i = 1:n
    tri1 = TRI(i, :);
    v = [points(tri1(1), :); points(tri1(2), :); points(tri1(3), :)];
    vs{i} = v;
    w = nan(3, 2);
    for j = 1:n
       if i == j
           continue;
       end
       tri2 = TRI(j, :);
       
       c = intersect(tri1, tri2);
       if length(c) == 2
           in1 = incenters(i, :);
           in2 = incenters(j, :);
           v1 = points(c(1), :);
           v2 = points(c(2), :);
           x1 = in1(1);
           y1 = in1(2);
           x2 = in2(1);
           y2 = in2(2);
           x3 = v1(1);
           y3 = v1(2);
           x4 = v2(1);
           y4 = v2(2);
           
           d = (x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4);
           x = ((x1*y2 - y1*x2)*(x3 - x4) - (x1 - x2)*(x3*y4 - y3 * x4)) / d;
           y = ((x1*y2 - y1*x2)*(y3 - y4) - (y1 - y2)*(x3*y4 - y3 * x4)) / d;
           
           if ismember(tri1(1), c) && ismember(tri1(2), c)
            w(1, :) = [x y];
           elseif ismember(tri1(2), c) && ismember(tri1(3), c)
            w(2, :) = [x y];
           elseif ismember(tri1(3), c) && ismember(tri1(1), c)
            w(3, :) = [x y];
           end
       end
    end
    for j = 1:3
        if isnan(w(j, 1))
            w(j, :) = (v(j, :) + v(mod(j, 3) + 1, :))/2;
        end
    end
    ws{i} = w;
end

end