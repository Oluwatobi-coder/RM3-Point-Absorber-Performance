%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'RM3.slx';      % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='off';                    % Turn SimMechanics Explorer (on/off) to prevent browser crashes
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 100;                    % Wave Ramp Time [s]
simu.endTime=400;                       % Simulation End Time [s]
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step
simu.dt = 0.1;                          % Simulation time-step [s]

%% Wave Information 
waves = waveClass('irregular');              % set to irregular category
waves.spectrumType = 'PM';             	     % defining Pierson-Moskowitz spectrum
waves.height = current_Hs;                   % Wave Height [m]
waves.period = current_Tp;                   % Wave Period [s]
waves.phaseSeed = 1;                         % Wave Phase Seed


%% Body Data
% Float
body(1) = bodyClass('hydroData/rm3.h5');     % Create the body(1) Variable, Set Location of Hydrodynamic Data File 
body(1).geometryFile = 'geometry/float.stl'; % Location of Geomtry File   
body(1).mass = 'equilibrium'; 		     % Body Mass. The 'equilibrium' Option Sets it to the Displaced Water Weight                
body(1).inertia = [20907301 21306090.66 37085481.11]; %Moment of Inertia [kg*m^2]
    
% Spar/Plate
body(2) = bodyClass('hydroData/rm3.h5');			% Create the body(2) Variable, Set Location of Hydrodynamic Data File 
body(2).geometryFile = 'geometry/plate.stl';			% Location of Geomtry File 
body(2).mass = 'equilibrium'; 		     			% Body Mass. The 'equilibrium' Option Sets it to the Displaced Water Weight                   
body(2).inertia = [94419614.57 94407091.24 28542224.82];	%Moment of Inertia [kg*m^2]  

%% PTO and Constraint Parameters
% Floating (3DOF) Joint
constraint(1) = constraintClass('Constraint1');	     % Initialize Constraint Class for Constraint1 
constraint(1).location = [0 0 0];                    % Constraint Location [m]                    

% Translational PTO
pto(1) = ptoClass('PTO1');			     % Initialize PTO Class for PTO1                      
pto(1).stiffness = 0;                                % PTO Stiffness [N/m]                                   
pto(1).damping = 1200000;                            % PTO Damping [N/(m/s)]                             
pto(1).location = [0 0 0];                           % PTO Location [m]