function LunarOrbitGUI
    % Create figure
    f = figure('Visible','off','Position',[100,100,800,600],'Name','Lunar Orbit Simulator','NumberTitle','off','MenuBar','none');

    % Altitude input
    uicontrol('Style', 'text', 'Position', [20, 540, 100, 20], 'String', 'Altitude (km):');
    altitudeEdit = uicontrol('Style', 'edit', 'Position', [120, 540, 100, 20]);

    % Inclination input
    uicontrol('Style', 'text', 'Position', [20, 510, 100, 20], 'String', 'Inclination (deg):');
    inclinationEdit = uicontrol('Style', 'edit', 'Position', [120, 510, 100, 20]);

    % Eccentricity input
    uicontrol('Style', 'text', 'Position', [20, 480, 100, 20], 'String', 'Eccentricity:');
    eccentricityEdit = uicontrol('Style', 'edit', 'Position', [120, 480, 100, 20]);

    % Orbit type dropdown
    uicontrol('Style', 'text', 'Position', [20, 450, 100, 20], 'String', 'Orbit Type:');
    orbitTypeMenu = uicontrol('Style', 'popupmenu', 'Position', [120, 450, 100, 20], 'String', {'Circular','Elliptical'});

    % 3D Visualization Checkbox
    is3DCheckbox = uicontrol('Style', 'checkbox', 'Position', [20, 420, 200, 20], 'String', 'Enable 3D Visualization');

    % Start simulation button
    startButton = uicontrol('Style', 'pushbutton', 'String', 'Start Simulation', 'Position', [20, 390, 200, 30], 'Callback', @startSimulation);

    % Information panel
    infoPanel = uipanel('Title', 'Simulation Info', 'Position', [0.05, 0.1, 0.25, 0.3]);
    infoText = uicontrol('Style', 'text', 'Position', [20, 20, 180, 100], 'Parent', infoPanel, 'String', 'Simulation not started.');

    % Axes for plot
    ax = axes('Parent', f, 'Position', [0.4, 0.1, 0.55, 0.8]);

    % Move the GUI to the center of the screen
    movegui(f,'center');

    % Make the GUI visible
    f.Visible = 'on';

    % Callback function for start simulation button
    function startSimulation(~, ~)
        % Get inputs from GUI
        altitude_km = str2double(altitudeEdit.String);
        inclination_deg = str2double(inclinationEdit.String);
        eccentricity = str2double(eccentricityEdit.String);
        orbitType = orbitTypeMenu.Value;
        enable3D = is3DCheckbox.Value;

        % Run the simulation (this function would be defined elsewhere and tailored to the specific needs of the simulation)
        [t, y] = runLunarOrbitSimulation(altitude_km * 1e3, inclination_deg, eccentricity, orbitType);

        % Update information panel
        infoString = sprintf('Altitude: %.2f km\nInclination: %.2f deg\nEccentricity: %.2f\nOrbit Type: %s', altitude_km, inclination_deg, eccentricity, orbitTypeMenu.String{orbitType});
        infoText.String = infoString;

        % Plot the results
        if enable3D
            % 3D Plotting code here (to be implemented)
        else
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
end
