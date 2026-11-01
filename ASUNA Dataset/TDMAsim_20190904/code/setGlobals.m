% Set global simulation variables
%
% %%% setGlobals.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

global GLO

% Path to the measurement datasets folder
GLO.datasetPath = '../shared_measurements';
% Path to the results folder
GLO.resultsPath = '../results';

GLO.maxQueue = 100;

% The queue matrix will be a maxQueue x 5 table
% ---Column meanings---
% 1st column: time;
GLO.eventTime = 1;
% 2nd column: event type; 
GLO.eventType = 2;
% 3rd column: index of next event;
GLO.eventNext = 3;
% 4th column: is equal to slotFreeFlag if the slot is free to accommodate an event
GLO.eventIsFree = 4;
% 5th column: node involved in the event
GLO.eventNodeInvolved = 5;

% Flags for event queue free/busy status
GLO.slotFreeFlag = 1;
GLO.slotBusyFlag = 0;

% Create the actual event queue
evQueue = [ Inf(GLO.maxQueue,1) , zeros(GLO.maxQueue, 2) , repmat(GLO.slotFreeFlag,GLO.maxQueue, 1) , zeros(GLO.maxQueue, 1) ];

% Event types and related names
GLO.evTypeNames = {
    'First';
    'StopSim';
    'Transmit';
    'CollectMetrics';
    'DistanceRefresh';
    'Debug';
};

GLO.evFirst = 1;
GLO.evStopSim = 2;
GLO.evTransmit = 3;
GLO.evCollectMetrics = 4;
GLO.evDistRefresh = 5;
GLO.evDebug = 6;

% Sound speed
GLO.cSound = 1500;

% Metric types
GLO.metricBER = 1;
GLO.metricSNR = 2;
GLO.metricRSS = 3;
GLO.metricOnOff = 4;


% Protocol parameters
GLO.tPkt = 0.5; % [s]

% Physical layer parameters (one value per technology used)
GLO.techBitRate = [4e3 16e3 32e3]; % [bit/s]

% Node distance re-computation time
GLO.distRefreshInterval = 60; % [s]

% Figure formatting data
GLO.figPos = [200 200 900 625];
GLO.axisPos = [0.105 0.115 0.85 0.85];
GLO.fontSize = 18;
GLO.legFontSize = 16;

% Plot simulation results
GLO.plotSim = 1;