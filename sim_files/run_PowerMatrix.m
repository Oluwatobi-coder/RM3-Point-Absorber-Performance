%% Performance Assessment of the RM3 Point Absorber across Variable Sea States
% Purpose: This script carries out a simulation using WEC-Sim for the Reference Model 3 
%          (RM3) Point Absorber. It iterates through 12 unique irregular sea states 
%          modeled on the Pierson-Moskowitz spectrum (Hs: 1.5 - 3.5m, Tp: 6 - 12s). 
%          The script handles initialization, executes the time-domain Cummins 
%          equation solver, and extracts steady-state mean mechanical power by 
%          eliminating the initial 200s of instability.
% Author:  Bello Oluwatobi
% Date:    August 3, 2025

% defining the sea states
Hs_vec = [1.5, 2.5, 3.5]; % significant wave heights in meters
Tp_vec = [6, 8, 10, 12];  % peak periods in seconds

% initializing the empty power matrix
PowerMatrix = zeros(length(Hs_vec), length(Tp_vec));

% running the simulation loop
for hs_idx = 1:length(Hs_vec)
    for tp_idx = 1:length(Tp_vec)
        
        % Assign current loop values
        current_Hs = Hs_vec(hs_idx);
        current_Tp = Tp_vec(tp_idx);
        
        fprintf('\n=======================================================\n');
        fprintf('Running Simulation: Hs = %.1f m, Tp = %.1f s...\n', current_Hs, current_Tp);
        fprintf('=======================================================\n');
        
        % running WEC-Sim 
        wecSim; 
        
        % extracting and processing the data
        time = output.ptos.time;
        inst_power = output.ptos.powerInternalMechanics(:,3); 
        
        % extracting the steady-state region (last 50% of the simulation)
        steady_start = round(length(time) * 0.5); 
        mean_power = mean(abs(inst_power(steady_start:end))); 
        
        % storing the result using the unique indices
        PowerMatrix(hs_idx, tp_idx) = mean_power;
        
        % clearing the output object after simulation
        clear output; 
    end
end

% saving the final matrix
save('RM3_PowerMatrix_Data.mat', 'PowerMatrix', 'Hs_vec', 'Tp_vec');
disp('Power Matrix Generation Complete...');