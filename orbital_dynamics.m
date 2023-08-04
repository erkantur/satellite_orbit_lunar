function dydt = orbital_dynamics(t, y, G, M_moon, eccentricity, orbitType)
    % Position and Velocity
    r = y(1:3);
    v = y(4:6);

    % Gravitational force from Moon
    r_magnitude = norm(r);
    gravitational_force_moon = -G * M_moon / r_magnitude^3 * r;

    % Non-spherical gravity perturbations (J2, J3 coefficients)
    J2 = 1.08263e-3;
    J3 = -2.5327e-6;
    R_moon = 1737.4e3;
    P2 = (3 * (r(3)^2 / r_magnitude^2) - 1) / 2;
    P3 = (5 * (r(3)^2 / r_magnitude^2) - 3) * (r(3) / r_magnitude) / 2;
    C20 = -J2 * R_moon^2;
    C30 = -J3 * R_moon^3;
    perturbations_force = G * M_moon / r_magnitude^4 * [...
        r(1) * (C20 * (1 - 5 * P2) + C30 * (3 - 7 * P3));
        r(2) * (C20 * (1 - 5 * P2) + C30 * (3 - 7 * P3));
        r(3) * (C20 * (3 - 5 * P2) + C30 * (6 - 7 * P3))];

    % Gravitational force from Earth (for higher fidelity simulation)
    M_earth = 5.972e24; % Earth's mass (kg)
    r_earth_to_moon = 384400e3; % Average distance from Earth to Moon (m)
    r_earth = r + [r_earth_to_moon; 0; 0]; % Assuming simplified model
    r_earth_magnitude = norm(r_earth);
    gravitational_force_earth = -G * M_earth / r_earth_magnitude^3 * r_earth;

    % Total Acceleration
    a = gravitational_force_moon + perturbations_force + gravitational_force_earth;

    % Modify the dynamics based on the specific orbit type if needed
    switch orbitType
        case 1 % Circular
            % Dynamics already handle circular orbits with eccentricity = 0
        case 2 % Elliptical
            % Potential additional code for elliptical orbits, possibly handling the dynamics differently
            % or adding additional forces or constraints
    end

    dydt = [v; a];
end
