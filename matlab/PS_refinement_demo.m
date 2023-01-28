TRI = [1 2 3; 4 2 3; 4 5 2; 5 1 2];
points = [0 0; 1 0; 0 1; 2 1.5; 2.2 -1];

[incenters, vs, ws] = PS_refinement(TRI, points);

n = size(vs, 1);

figure
hold on
for i = 1:n
   for j = 1:3
      plot([vs{i}(j, 1), vs{i}(mod(j, 3) + 1, 1)], [vs{i}(j, 2), vs{i}(mod(j, 3) + 1, 2)], 'LineWidth',2, 'Color', 'k')
   end
end
axis equal

pause;

for i = 1:n
   scatter(incenters(:, 1), incenters(:, 2), 'filled')
end

pause;

for i = 1:n
   for j = 1:3
      scatter(ws{i}(j, 1), ws{i}(j, 2));
   end
end

pause;

for i = 1:n
   for j = 1:3
      plot([vs{i}(j, 1), incenters(i, 1)], [vs{i}(j, 2), incenters(i, 2)], 'Color', 'k');
      plot([ws{i}(j, 1), incenters(i, 1)], [ws{i}(j, 2), incenters(i, 2)], 'Color', 'k');
   end
end