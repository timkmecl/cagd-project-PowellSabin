function incenters = get_incenters(TRI, points)

n = size(TRI, 1);
incenters = nan(n, 2);

for i = 1:n
    tri = TRI(i, :);
    v1 = points(tri(1), :);
    v2 = points(tri(2), :);
    v3 = points(tri(3), :);
    T = [v1; v2; v3];
    incenters(i, :) = incenter(T);
end
end