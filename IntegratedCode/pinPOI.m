% Pinning POIs
% Usage: s.destination = [point1_x, point1_y, point2_x, point2_y, average point_x, average point_y]

close all;
clear all;
clc;

% Selects the building blueprint and copies it with POIs
Building_Blueprint = uigetfile('*.jpg'); 
Token = strtok(Building_Blueprint,'.'); 
Building_POI = sprintf('%s_POIs.jpg',Token); 
imshow(Building_Blueprint);

% variable to loop through while loop
input = 'SomeValue'; 
i = 0;

while(isempty(input) == 0)
    i=i+1;
    
    % Shows a window to enter input POI
    Prompt = {'Enter POI name. Then, press OK to pin another POI or CANCEL to finish'};
    Window_Title = 'Buildings POI Pinning';
    Dimension = [1 70]; 
    input = inputdlg(Prompt,Window_Title,Dimension); 
    
    % Creates struct and saves it on Building_POI image/mat
    if isempty(input) % user didnt input
        save(sprintf('%s_POIs.mat',Token),'-struct','s'); % 
        saveas(gcf,Building_POI); % 
        return;
    end
    
    % Insert POIs to struct
    POI(i) = input; % insert POIs with every i 
    [point1, point2, midpoint] = setCoordinates(); % ginput twice of door
    s.(POI{i}) = [point1, point2, midpoint]; % access struct s.restromm, s.lounge = values of midpoint of door 6
    
    % Plots the POI on the building blueprint
    hold on; 
    plot(midpoint(1), midpoint(2),'.r', 'MarkerSize', 10);  
    c = cellstr(input); 
    text(midpoint(1)+8, midpoint(2)+8, c);
end