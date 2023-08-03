function LunarOrbitGUI
    % Create figure
    f = figure('Visible','off','Position',[360,500,600,400]);

    % Create input for altitude
    altitudeEdit = uicontrol('Style', 'edit', 'Position', [100, 320, 100, 20]);
    uicontrol('Style', 'text', 'Position', [100, 340, 100, 20], 'String', 'Altitude (km)');

    % Create start simulation button
    startButton = uicontrol('Style', 'pushbutton', 'String', 'Start Simulation', 'Position', [100, 280, 100, 20], 'Callback', @startSimulation);

    % Create axes for plot
    ax = axes('Parent', f, 'Position', [0.4, 0.1, 0.55, 0.8]);

    % Move the GUI to the center of the screen.
    movegui(f,'center')

    % Make the GUI visible.
    f.Visible = 'on';

    % Callback function for start simulation button
    function startSimulation(~, ~)
        % Get altitude from text box
        altitude_km = str2double(altitudeEdit.String);

        % Run the simulation with the given altitude
        [t, y] = runLunarOrbitSimulation(altitude_km * 1e3); % Convert to meters

        % Plot the results in the axes
        plot(ax, y(:,1), y(:,2), 'b-', 'LineWidth', 2);
        hold(ax, 'on');
        viscircles(ax, [0, 0], 1737.4e3, 'LineWidth', 2, 'EdgeColor', 'r'); % Moon
        axis(ax, 'equal');
        xlabel(ax, 'X (m)');
        ylabel(ax, 'Y (m)');
        title(ax, 'Satellite Orbit around Moon');
        grid(ax, 'on');
    end
end

function [t, y] = runLunarOrbitSimulation(altitude)
    % Constants
    G = 6.67430e-11; % Gravitational constant (m^3/kg/s^2)
    M_moon = 7.34767309e22; % Moon's mass (kg)
    R_moon = 1737.4e3; % Moon's radius (m)

    % Initial conditions for satellite (circular orbit at given altitude)
    r0 = [0; altitude + R_moon]; % Initial position (m)
    v0 = [sqrt(G * M_moon / r0(2)); 0]; % Initial velocity (m/s)
    initial_conditions = [r0; v0];

    % Time span (one lunar day, about 27.3 Earth days)
    t_span = [0, 27.3 * 24*60*60];

    % Solve the differential equation using ODE45
    [t, y] = ode45(@(t,y) orbital_dynamics(t, y, G, M_moon), t_span, initial_conditions);
end

function dydt = orbital_dynamics(~, y, G, M_moon)
    r = [y(1); y(2)];
    v = [y(3); y(4)];

    r_magnitude = norm(r);
    acceleration = -G * M_moon / r_magnitude^3 * r;

    dydt = [v; acceleration];
end
