% Simulate TDMA over an underwater network by using traces from actual experiments
%
% %%% TDMAsim.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

clear all;

global evQueue GLO

setGlobals();

% Fix the random number generator's seed for reproducibility
% (Comment the following line to restore randomness across runs)
mySeed = 20190131;
rng( mySeed, 'twister' );

% -----------------------------------------------------------------------------
% -------------------------- Load measurement dataset -------------------------
% -----------------------------------------------------------------------------
% *** Uncomment one of the groups below to load the corresponding dataset   ***
% -----------------------------------------------------------------------------

%%% Artificial data %%%
% desiredTopologyData = 'ArtificialSin';
% loadTopologyData( desiredTopologyData , [] );
%%%-----------------%%%

%%% Haifa Harbor %%%
% desiredTopologyData = 'HaifaHarbor';
% desiredTopologyRun = 'all'; % 1-6 or 'all'
% loadTopologyData( desiredTopologyData , desiredTopologyRun );
%%%--------------%%%

%%% Hadera security %%%
% desiredTopologyData = 'HaderaSecurity';
% loadTopologyData( desiredTopologyData );
%%-----------------%%%

%%% Garda Lake %%%
% desiredTopologyData = 'GardaLake';
% desiredTopologyRun = 'all'; % 1-4 or 'all'
% loadTopologyData( desiredTopologyData , desiredTopologyRun );
%%%------------%%%

%%% ALOMEX15 %%%
% desiredTopologyData = 'ALOMEX';
% loadTopologyData( desiredTopologyData );
%%%------------%%%

%%% Berlin Multimodal %%%
desiredTopologyData = 'BerlinMultimodal';
desiredTopologyRun = 'all'; % 1-5 or 'all'
loadTopologyData( desiredTopologyData , desiredTopologyRun );
%%%------------%%%

%%% Hadera multimodal scheduling %%%
% desiredTopologyData = 'HaderaMultimodalSched';
% desiredTopologyRun = 'all'; % 1-2 or 'all'
% loadTopologyData( desiredTopologyData , desiredTopologyRun );
%%-----------------%%%

%%% REP %%%
% desiredTopologyData = 'REP';
% desiredTopologyRun = 'all'; % 1-3 or 'all'
% loadTopologyData( desiredTopologyData , desiredTopologyRun );
%%-----------------%%%

if ~exist('desiredTopologyData','var')
    error('TDMAsim::no ''desiredTopologyData'' has been specified.');
end

% ----------------------------------------------------------------------------
% ------------------ Initialize basic simulation parameters ------------------
% ----------------------------------------------------------------------------

% Current event ID pointer
currentEvent = 1;
% Maximum simulation time (only up to last measurement epoch)
GLO.simulationTime = GLO.chSampleEpochs(end) + 1e-6;
% Time pointer
currentTime = 0;

% Schedule first and last event
evQueue(1, :) = [ 0, GLO.evFirst, 2, 0, 0 ];
evQueue(2, :) = [ GLO.simulationTime, GLO.evStopSim, 0, 0, 0 ];

% Add events like the one below to get into debug mode
% pushEvent ( 160*60, GLO.evDebug, 0 );


% ------------------------------------------------------------
% ------------------ Actual Simulation Loop ------------------
% ------------------------------------------------------------
tic;
while true
    
    switch evQueue(currentEvent, GLO.eventType)
        
        case GLO.evStopSim
            elapTime = toc;
            fprintf( 'Simulation completed in %.2f seconds. Total simulated time: %g seconds.\n', elapTime, GLO.simulationTime );
            % Compute metrics per technology
            total_txPkt_vec_tech = squeeze( sum( sum( txPkt_mat, 3), 2) );
            total_correctPkt_vec_tech = squeeze( sum( sum( correctPkt_mat, 3), 2) );
            total_correctRxBits_vec_tech = squeeze( sum( sum( correctRxBits_mat, 3), 2) );
            % Trim extra trailing values to avoid errors
            total_txPkt_vec_tech = total_txPkt_vec_tech( 1:length(tPerfSample), : );
            total_correctPkt_vec_tech = total_correctPkt_vec_tech( 1:length(tPerfSample), : );
            total_correctRxBits_vec_tech = total_correctRxBits_vec_tech( 1:length(tPerfSample), : );
            % Compute global metrics
            total_txPkt_vec = sum( total_txPkt_vec_tech, 2 );
            total_correctPkt_vec = sum( total_correctPkt_vec_tech, 2 );
            total_correctRxBits_vec = sum( total_correctRxBits_vec_tech, 2 );
            if GLO.plotSim
                plotOutput();
            end
            return;
            
            
        case GLO.evFirst
            fprintf( '--------------- SIMULATION STARTED ---------------\n' );
            % Compute distances and propagation times
            [nodeDist, propTime] = computeDistances( GLO.cSound, currentTime );
            % Reschedule computation every GLO.distRefreshInterval seconds
            pushEvent( currentTime + GLO.distRefreshInterval, GLO.evDistRefresh, 0 );
            % Compute TDMA slot and frame time
            GLO.tSlot = GLO.tPkt + max(max( propTime ));
            GLO.tFrame = GLO.tSlot * GLO.nNodes;
            % Insert first transmission for each node
            for iNode = 1 : GLO.nNodes
                pushEvent( currentTime+iNode*GLO.tSlot, GLO.evTransmit, iNode );
            end
            
            % Initialize performance counters
            % Performance sampling epochs
            tPerfSample = GLO.perfSamplePeriod : GLO.perfSamplePeriod : GLO.simulationTime; % [seconds]
            % Packets transmitted per link per technology
            txPkt_mat = zeros( length(tPerfSample)+1, GLO.nNodes, GLO.nNodes, GLO.nTech );
            % Packets correctly received per link per technology
            correctPkt_mat = zeros( length(tPerfSample)+1, GLO.nNodes, GLO.nNodes, GLO.nTech );
            % Total number of correctly received bits
            correctRxBits_mat = zeros( length(tPerfSample)+1, GLO.nNodes, GLO.nNodes, GLO.nTech );

            % Schedule first metric collection
            currentPerfSlot = 1;
            pushEvent( GLO.perfSamplePeriod, GLO.evCollectMetrics, 0 );

            
        case GLO.evTransmit
            currentNode = evQueue(currentEvent, GLO.eventNodeInvolved);
            % Set used technology and destination at random
            currentNeighbors = find( getCurrentNeighbors( currentTime, currentNode ) == 1 );
            destNode = currentNeighbors( ceil( rand*length(currentNeighbors) ) );
            availableTechs = getAvailableTechs( currentTime, currentNode , destNode );
            techUsed = availableTechs( ceil( rand*length(availableTechs) ) );
            % Record transmission
            txPkt_mat( currentPerfSlot, currentNode, destNode, techUsed ) = ...
                txPkt_mat( currentPerfSlot, currentNode, destNode, techUsed ) + 1;
            % Check and record correct reception
            isCorrect = getTxOutcome( currentTime, currentNode, destNode, techUsed );
            if isCorrect
                correctPkt_mat( currentPerfSlot, currentNode, destNode, techUsed ) = ...
                    correctPkt_mat( currentPerfSlot, currentNode, destNode, techUsed ) + 1;
                correctRxBits_mat( currentPerfSlot, currentNode, destNode, techUsed ) = ...
                    correctRxBits_mat( currentPerfSlot, currentNode, destNode, techUsed ) + GLO.techBitRate(techUsed)*GLO.tPkt;
            end
            % Schedule next transmission
            pushEvent( currentTime+GLO.tFrame, GLO.evTransmit, currentNode );
            
            
        case GLO.evCollectMetrics
            currentPerfSlot = currentPerfSlot + 1;
            pushEvent( currentTime+GLO.perfSamplePeriod, GLO.evCollectMetrics, 0 );
            
            
        case GLO.evDistRefresh
            % Recompute distances and propagation times
            [nodeDist, propTime] = computeDistances( GLO.cSound, currentTime );
            % Reschedule computation every GLO.distRefreshInterval seconds
            pushEvent( currentTime + GLO.distRefreshInterval, GLO.evDistRefresh, 0 );
            % Update TDMA slot and frame time
            GLO.tSlot = GLO.tPkt + max(max( propTime ));
            GLO.tFrame = GLO.tSlot * GLO.nNodes;
            
            
        case GLO.evDebug
            keyboard;
            
            
        otherwise
            error( ['Event type #' num2str( evQueue(currentEvent, GLO.eventType) ) ' not recognized.'] );
            
            
    end
    
    % Free current event slot
    evQueue(currentEvent, GLO.eventIsFree) = GLO.slotFreeFlag;
    % Advance event queue and simulation time
    currentEvent = evQueue(currentEvent, GLO.eventNext);
    currentTime = evQueue(currentEvent, 1);
    
end

