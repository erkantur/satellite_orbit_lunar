# Lunar Orbit Simulation

## Overview

The Lunar Orbit Simulation project provides a comprehensive toolset for simulating and visualizing orbits around the Moon. It incorporates complex orbital dynamics, including gravitational forces, non-spherical gravity perturbations, and the gravitational influence of the Earth. The project also comes with an interactive GUI for easy manipulation of the simulation parameters.

## Components

- **Main GUI File (`LunarOrbitGUI.m`)**: Provides an interactive graphical user interface for setting up and running the simulation.

- **Orbit Simulation File (`runLunarOrbitSimulation.m`)**: Handles the main orbit simulation logic, interfacing with the orbital dynamics and plotting functions.

- **Orbital Dynamics File (`orbital_dynamics.m`)**: Includes the differential equations governing the motion of a satellite in lunar orbit, taking into account gravitational dynamics and perturbations.

- **Plotting Function (`plotOrbit.m`)**: Offers a rich 3D plot of the lunar orbit, including the Moon, Earth, and interactive time slider.

## Requirements

- MATLAB (R2019a or newer recommended)
- Aerospace Toolbox (for some additional features)

## Usage

1. **Open MATLAB**: Start MATLAB on your computer.

2. **Navigate to the Project Directory**: Use the MATLAB file explorer or command line to navigate to the directory containing the project files.

3. **Run the Main GUI**: Open and run the `LunarOrbitGUI.m` file. This will launch the main interface where you can set the parameters for your simulation.

4. **Configure Simulation**: Use the GUI to choose the orbit type, initial conditions, simulation time, and other parameters.

5. **Run Simulation**: Click the "Run Simulation" button on the GUI to start the simulation. The orbit plot will appear, and you can interact with it using the time slider and other controls.

## Contributing

Feel free to fork the project, create a new branch, and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

## Support

For any questions or support, please open an issue on GitHub or contact me directly.

Erkan
