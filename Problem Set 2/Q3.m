%%

% initializing variables. Run this section
clear vars;
clc;

c  = 1;
L  = 1;
dx = 0.1;
dt = 0.1;
T  = 1;
x  = 0:dx:L;
nx = length(x);
nt = round(T/dt);

%%

% Method 1

u     = 2 * x .* (1 - x);
u_new = zeros(1, nx);
u_old = u;

for t = 1:nt
    d2u_dx2      = [0, diff(u, 2), 0] / dx^2;

    for i        = 2:nx-1
        u_new(i) = 2 * u(i) - u_old(i) + c^2 * dt^2 * d2u_dx2(i);
    end

    u_new(1)     = 0;
    u_new(end)   = 0;

    u_old        = u;
    u            = u_new;
end

%% 

% Alternate Approach, Using Foreier Series
% Run either of the sections, this or the previous one.

u     = zeros(size(x));
for n = 1:100 
    A_n = 2 * (1 - (-1)^n) / (pi^3 * n^3);
    u   = u + A_n * cos(pi * n * T) .* sin(pi * n * x);
end

%%

% Run this section

plot(x, u);
xlabel('Position');
ylabel('Displacement');
title('Displacement of the string at T = 1 second');
grid on;

%%