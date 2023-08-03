% Constants
G = 6.67430e-11; % Gravitational constant (m^3/kg/s^2)
M_moon = 7.34767309e22; % Moon's mass (kg)
R_moon = 1737.4e3; % Moon's radius (m)

% Initial conditions for satellite (circular orbit at 100 km altitude)
r0 = [0; 100e3 + R_moon]; % Initial position (m)
v0 = [sqrt(G * M_moon / r0(2)); 0]; % Initial velocity (m/s)
initial_conditions = [r0; v0];

% Time span (one lunar day, about 27.3 Earth days)
t_span = [0, 27.3 * 24*60*60];

% Solve the differential equation using ODE45
[t, y] = ode45(@(t,y) orbital_dynamics(t, y, G, M_moon), t_span, initial_conditions);

% Plot the orbit
figure
plot(y(:,1), y(:,2), 'b-', 'LineWidth', 2);
hold on
viscircles([0, 0], R_moon, 'LineWidth', 2, 'EdgeColor', 'r'); % Moon
axis equal
xlabel('X (m)')
ylabel('Y (m)')
title('Satellite Orbit around Moon')
grid on

% Differential Equation Function
function dydt = orbital_dynamics(~, y, G, M_moon)
    r = [y(1); y(2)];
    v = [y(3); y(4)];

    r_magnitude = norm(r);
    acceleration = -G * M_moon / r_magnitude^3 * r;

    dydt = [v; acceleration];
end
