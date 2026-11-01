% Various commands to plot a simulation's output
%
% %%% plotOutput.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

global GLO

timeSecLab = 'Time [s]';
timeMinLab = 'Time [min]';
PDRLab = 'Packet delivery ratio';
txPktLab = 'Number of transmitted packets';
thruKbpsLab = 'Throughput [kbit/s]';
multiTechLegend = { 'LF'; 'MF'; 'HF' };

if ~exist('desiredTopologyData','var')
    error('plotOutput::desiredTopologyData variable not found, have you run TDMAsim.m first?');
end

switch desiredTopologyData
    
    case 'ArtificialSin'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, {'Tech 1'; 'Tech 2'}, [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'line', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, {'Tech 1'; 'Tech 2'}, [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, {'Tech 1'; 'Tech 2'}, [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);

    case 'HaifaHarbor'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, [], [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'line', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, [], [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, [], [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);
        
    case 'HaderaSecurity'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, [], [], [0 8], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'line', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, [], [], [0 8], [15 20] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, [], [], [0 8], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);
        
    case 'GardaLake'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, [], [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'line', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, [], [], [0 ceil(max(tPerfSample/60)/10)*10], [20 40] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, [], [], [0 ceil(max(tPerfSample/60)/10)*10], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);
        
    case 'ALOMEX'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, [], [], [0 15], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'line', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, [], [], [0 15], [20 25] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, [], [], [0 15], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);

    case 'HaderaMultimodalSched'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, multiTechLegend, 'SouthWest', [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'area', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, multiTechLegend, [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, multiTechLegend, [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);
        
    case 'BerlinMultimodal'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, multiTechLegend, 'SouthWest', [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'area', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, multiTechLegend, [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, multiTechLegend, [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);
        
    case 'REP'
        plotFormatted( 1, 'line', tPerfSample/60, total_correctPkt_vec_tech./total_txPkt_vec_tech, ...
            timeMinLab, PDRLab, [], [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_1.png']);
        plotFormatted( 2, 'line', tPerfSample/60, total_txPkt_vec_tech, ...
            timeMinLab, txPktLab, [], [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_2.png']);
        plotFormatted( 3, 'line', tPerfSample/60, total_correctRxBits_vec_tech/GLO.perfSamplePeriod/1e3, ...
            timeMinLab, thruKbpsLab, [], [], [], [] );
        saveas(gcf, [GLO.resultsPath '/figure_3.png']);

    otherwise
        error('plotOutput::desiredTopologyData value unknown.');
        
end