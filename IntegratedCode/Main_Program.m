% MAIN PROGRAM
% This program interfaces all modules 
% By: Orjwan Zaafarani, Noura Aldakhil, Dana AlAhdal, Afnan Safhi

% clear all;
% close all;
% clc;

%% MAP MODELING

% Binarize the map into a matrix with a level of gray threshold
BinaryMap = getBinaryMap('testBlueprint2.jpg',0.05);
save('BinaryMap.mat','BinaryMap');
load BinaryMap;

% Create a 2 layer martix, one with the Binary Map, the second with the user (2) and destination (3) coordinates
global TwoLayerMap
[m,n] = size(BinaryMap);
TwoLayerMap = zeros(m,n,2);
TwoLayerMap(:,:,1) = BinaryMap;

%% USER'S LOCATION

% Location Parameters (temporary)
userLocation = [730,310]; 
userLocation1 = [530,450]; % user location (coordinates)
userIndex = 2; % tag the user with this number

% Place user location on the map
loc_ind = {userLocation(1), userLocation(2), 2};
TwoLayerMap(loc_ind{:}) = userIndex; %in layer 2 put the number two (third dimension) to tag the user location

%%  DESTINATION

% Retrieve audio file from user
system(rpi, 'arecord --format=S16_LE --rate=16000 --duration=5 --file-type=wav restroomRequest.wav');
getFile(rpi,'/home/pi/restroomRequest.wav');

% Envoke speech recognition and matches keywords
Text = speechRecognition('restroomRequest.wav');
disp("The transcribed text: " + Text);
destinationKeyword = keywordCheck(Text);
disp("The requested destination: " + destinationKeyword);

% Correspond the destination to a POI
s = load ('testBlueprint2_POIs');
Destination = s.(destinationKeyword);
%destinationMidpoint = [Destination(5),Destination(6)];

% Place Location of Destination POI on Two Layered Map
destinationIndex = 3; 
destinationLocation = {ceil(Destination(5)),ceil(Destination(6)),2};
TwoLayerMap(destinationLocation{:}) = destinationIndex; 

%% A* Algorithm

% Define Number of Nodes
xmax = size(TwoLayerMap,1);
ymax = size(TwoLayerMap,2);

% Start and Goal
Start = userLocation1;
Goal = [ceil(Destination(5)),ceil(Destination(6))];

% Nodes
MAP = TwoLayerMap(:,:,1);
temp = double(~MAP);
GoalRegister = int8(zeros(size(MAP)));
GoalRegister(Goal(1),Goal(2)) = 1;
ConnectingDistance = 10;

% Running PathFinder
OptimalPath = AStar(Start(1), Start(2), temp, GoalRegister, ConnectingDistance);

if size(OptimalPath,2) > 1
    figure(10)
    imagesc((MAP))
    colormap(flipud(gray));

    hold on
    plot(OptimalPath(1,2),OptimalPath(1,1),'o','color','k')
    plot(OptimalPath(end,2),OptimalPath(end,1),'o','color','b')
    plot(OptimalPath(:,2),OptimalPath(:,1),'r')
    legend('Goal','Start','Path')
else 
    pause(1);
    h = msgbox('Sorry, No path exists to the Target!','warn');
    uiwait(h,5);
end
 
%% INSTRUCTIONS RESPONSE
%  TTS
%  putFile(rpi, 'debian-logo.png', '/home/pi/debian-logo.png.copy');
%  system(rpi, 'aplay --format=S16_LE --rate=16000 Test1.wav');
