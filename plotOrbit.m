function plotOrbit(t, y, orbitType, inclination_deg)
    % Moon Constants
    R_moon = 1737.4e3; % Moon's radius (m)
    
    % Extract the position components
    r = y(:, 1:3);
    
    % Plot the Moon
    [X_moon, Y_moon, Z_moon] = sphere(50);
    surf(R_moon * X_moon, R_moon * Y_moon, R_moon * Z_moon, 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'none');
    hold on;
    axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    grid on;

    % Plot the Orbit
    plot3(r(:,1), r(:,2), r(:,3), 'r', 'LineWidth', 2);
    
    % If Earth is part of the simulation, plot it (assuming a specific relative position)
    if exist('t', 'var') && exist('y', 'var') 
        r_earth_to_moon = 384400e3; % Average distance from Earth to Moon (m)
        [X_earth, Y_earth, Z_earth] = sphere(50);
        R_earth = 6371e3; % Earth's radius (m)
        surf(r_earth_to_moon + R_earth * X_earth, R_earth * Y_earth, R_earth * Z_earth, 'FaceColor', [0.0, 0.5, 1.0], 'EdgeColor', 'none');
    end

    % Plot additional objects, such as satellites or space stations
    % (details would depend on additional simulation parameters)
    
    % Customization of the plot based on orbit type
    switch orbitType
        case 1 % Circular
            title(['Circular Lunar Orbit, Inclination: ', num2str(inclination_deg), '°']);
        case 2 % Elliptical
            title(['Elliptical Lunar Orbit, Inclination: ', num2str(inclination_deg), '°']);
    end
    
    % Light and shading for better visualization
    lighting gouraud;
    light('Position', [1 1 1]);
    
    % Add a time slider for dynamic visualization
    if exist('t', 'var')
        add_slider(t, r);
    end
    
    hold off;
end

function add_slider(t, r)
    % Create a slider to visualize the orbit at different times
    fig = gcf;
    uicontrol('Style', 'slider', ...
        'Min', 1, 'Max', length(t), 'Value', 1, ...
        'Units', 'normalized', ...
        'Position', [0.1 0 0.8 0.05], ...
        'Callback', @(src, ~) update_plot(src, t, r, fig));
end

function update_plot(slider, t, r, fig)
    % Update the plot based on the slider's value
    index = round(slider.Value);
    time = t(index);
    position = r(index, :);
    figure(fig);
    title(['Time: ', num2str(time), ' seconds, Position: ', num2str(position)]);
    plot3(r(1:index,1), r(1:index,2), r(1:index,3), 'r', 'LineWidth', 2);
    hold on;
    scatter3(position(1), position(2), position(3), 'b', 'filled');
    hold off;
end
