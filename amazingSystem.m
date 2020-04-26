% test 
% day 2 with aaron
% pysic
Cd = 0.5;
m = 5;
alpha = 0.004;

% ramp input force up and down
Fin = horzcat((0:0.5:10),(10:-0.5:0)) ./ m;

% system
A = [0 1; 0  -(Cd/m - alpha/m)];
B = [0 1]';
C = [1 0; 0 1];
D = [0 0]';

sys = ss(A, B, C, D);

t = linspace(0,30,42);
bleh = zeros(1, length(Fin));
inputMat = horzcat(bleh', Fin');
lsim(sys, Fin', t')

