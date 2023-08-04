function [t, y] = runLunarOrbitSimulation(altitude, inclination_deg, eccentricity, orbitType)
    % Constants
    G = 6.67430e-11; % Gravitational constant (m^3/kg/s^2)
    M_moon = 7.34767309e22; % Moon's mass (kg)
    R_moon = 1737.4e3; % Moon's radius (m)

    % Initial conditions for satellite
    r0_magnitude = altitude + R_moon; % Initial distance from moon center
    v0_magnitude = sqrt(G * M_moon * (1 + eccentricity) / (r0_magnitude * (1 - eccentricity))); % Initial velocity magnitude for given eccentricity

    % Convert inclination to radians
    inclination_rad = deg2rad(inclination_deg);

    % Initial position and velocity in polar coordinates
    r0 = [r0_magnitude; 0];
    v0 = [0; v0_magnitude];

    % Rotate by inclination angle
    rotation_matrix = [cos(inclination_rad), -sin(inclination_rad); sin(inclination_rad), cos(inclination_rad)];
    r0 = rotation_matrix * r0;
    v0 = rotation_matrix * v0;

    initial_conditions = [r0; v0];

    % Time span (one lunar day, about 27.3 Earth days)
    t_span = [0, 27.3 * 24*60*60];

    % Options for ODE solver
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);

    % Solve the differential equation using ODE45
    [t, y] = ode45(@(t,y) orbital_dynamics(t, y, G, M_moon, eccentricity, orbitType), t_span, initial_conditions, options);
end

function dydt = orbital_dynamics(~, y, G, M_moon, eccentricity, orbitType)
    r = [y(1); y(2)];
    v = [y(3); y(4)];

    r_magnitude = norm(r);
    
    % Gravitational force calculation
    gravitational_force = -G * M_moon / r_magnitude^3 * r;

    % Perturbations or additional forces can be added here based on the orbit type

    % Modify the dynamics based on the specific orbit type if needed
    switch orbitType
        case 1 % Circular
            % Dynamics already handle circular orbits with eccentricity = 0
        case 2 % Elliptical
            % Potential additional code for elliptical orbits, possibly handling the dynamics differently
            % or adding additional forces or constraints
    end

    dydt = [v; gravitational_force];
end
