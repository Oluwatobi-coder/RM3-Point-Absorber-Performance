%% Performance Assessment of the RM3 Point Absorber across Variable Sea States
% Purpose: This script post-processes the results from the WEC-Sim simulation 
%          to generate a Performance Matrix. It imports the mean power datasets 
%          and creates a heatmap illustrating the relationship 
%          between wave parameters (Hs and Tp) and energy capture efficiency. 
%          The resulting visualization is used to identify the peak operational 
%          performance of the RM3 device.
% Author:  Bello Oluwatobi
% Date:    August 4, 2025

% loading the data from the simulation
load('RM3_PowerMatrix_Data.mat');

% converting power from Watts to kiloWatts (kW) and rounding to 1 decimal
PowerMatrix_kW = round(PowerMatrix / 1000, 1);

% generating the Heatmap
figure('Position', [100, 100, 700, 500]); % Set figure size
h = heatmap(Tp_vec, Hs_vec, PowerMatrix_kW);

% formatting the Heatmap figure
h.Title = 'Hydrodynamic Performance Matrix: RM3 Point Absorber (kW)';
h.XLabel = 'Peak Wave Period, T_p (s)';
h.YLabel = 'Significant Wave Height, H_s (m)';
h.Colormap = jet;
h.CellLabelFormat = '%.1f';