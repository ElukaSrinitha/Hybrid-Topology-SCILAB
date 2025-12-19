// =====================================================
// HYBRID TOPOLOGY USING BUS + RING + STAR (25 NODES)
// =====================================================
clc;
clear;
clf;
xset("auto clear","off");
 
// -----------------------------
// NODE POSITIONS
// -----------------------------
// Bus nodes (1–10)
bus_x = 1:10;
bus_y = ones(1,10) * 5;
 
// Ring nodes (11–18)
theta = linspace(0, 2*%pi, 9);
ring_x = 6 + cos(theta(1:8));
ring_y = 2 + sin(theta(1:8));
 
// Star nodes (19–25)
star_center_x = 12;
star_center_y = 5;
star_x = [star_center_x, 12.5, 13, 12.5, 11.5, 11, 11.5];
star_y = [star_center_y, 6, 5, 4, 4, 5, 6];
 
// Combine nodes
x = [bus_x, ring_x, star_x];
y = [bus_y, ring_y, star_y];
 
// -----------------------------
// DRAW NODES
// -----------------------------
plot(x, y, 'bo');
 
// Label nodes
for i = 1:25
    xstring(x(i)+0.05, y(i)+0.05, string(i));
end
 
// -----------------------------
// BUS EDGES (RED)
// -----------------------------
for i = 1:9
    plot([bus_x(i), bus_x(i+1)], [bus_y(i), bus_y(i+1)], 'r');
end
 
// -----------------------------
// RING EDGES (GREEN)
// -----------------------------
for i = 1:7
    plot([ring_x(i), ring_x(i+1)], [ring_y(i), ring_y(i+1)], 'g');
end
plot([ring_x(8), ring_x(1)], [ring_y(8), ring_y(1)], 'g');
 
// -----------------------------
// STAR EDGES (MAGENTA)
// -----------------------------
for i = 2:7
    plot([star_x(1), star_x(i)], [star_y(1), star_y(i)], 'm');
end
 
// -----------------------------
// HYBRID CONNECTIONS (BLACK)
// -----------------------------
plot([bus_x(5), ring_x(1)], [bus_y(5), ring_y(1)], 'k');
plot([ring_x(4), star_center_x], [ring_y(4), star_center_y], 'k');
 
xtitle("Hybrid Topology (Bus + Ring + Star)");
 
// -----------------------------
// DEGREE CALCULATION
// -----------------------------
degree = zeros(1,25);
 
// Bus
degree(1) = 1; degree(10) = 1;
for i = 2:9
    degree(i) = 2;
end
 
// Ring
for i = 11:18
    degree(i) = 2;
end
 
// Star
degree(19) = 6;
for i = 20:25
    degree(i) = 1;
end
 
// Hybrid links
degree(5) = degree(5) + 1;
degree(11) = degree(11) + 1;
degree(15) = degree(15) + 1;
degree(19) = degree(19) + 1;
 
// -----------------------------
// MAX DEGREE
// -----------------------------
maxDeg = 0;
maxNode = 0;
 
disp("Node Degrees:");
for i = 1:25
    disp("Node " + string(i) + " : " + string(degree(i)) + " edges");
    if degree(i) > maxDeg then
        maxDeg = degree(i);
        maxNode = i;
    end
end
 
// -----------------------------
// TOTAL COUNT
// -----------------------------
total_nodes = 25;
total_edges = sum(degree)/2;
 
disp(" ");
disp("Node with maximum edges : Node " + string(maxNode));
disp("Maximum edges : " + string(maxDeg));
disp("Total Nodes : " + string(total_nodes));
disp("Total Edges : " + string(total_edges));
