% Load topology matrix and node location matrix from file
%
%   loadTopologyData( topologyName, topologyInstance )
%
%   Inputs:
%     - experimentName: unique string defining the desired experiment
%     - experimentRun: for experiments with multiple runs, index of the
%                      desired run, or 'all' for a concatenation of all 
%                      runs over time
% 
% %%% loadTopologyData.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

function loadTopologyData( experimentName, experimentRun )

global GLO

if nargin < 2
    experimentRun = 0;
end

switch experimentName
    
    case 'ArtificialSin'
        load( [GLO.datasetPath '/ArtificialSin/artificialSNRdata_5_15_sin.mat'] );
        GLO.LocMat = LocMat;
        GLO.TopMat = TopMat;
        GLO.TechMat = TechMat;
        GLO.AdjMat = AdjMat;
        GLO.threshold = 10;
        GLO.chSamplePeriod = 1; % This artificial dataset has 1 measurement every 1 s
        GLO.metricType = GLO.metricSNR;
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 240; % [s]

    case 'HaifaHarbor'
        load( [GLO.datasetPath '/Haifa_Harbor/HaifaHarborExp-05-09.mat'] );
        switch experimentRun
            case {1,2,3,4,5,6}
                eval( ['GLO.LocMat = LocMat' num2str(experimentRun)] );
                eval( ['GLO.TopMat = TopMat' num2str(experimentRun)] );
                eval( ['GLO.TechMat = TechMat' num2str(experimentRun)] );
                eval( ['GLO.AdjMat = AdjMat' num2str(experimentRun)] );
            case 'all'
                GLO.LocMat = FullLocMat;
                GLO.TopMat = FullTopMat;
                GLO.TechMat = FullTechMat;
                GLO.AdjMat = FullAdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1-6 or ''all''.']);
        end
        GLO.metricType = GLO.metricBER;
        GLO.threshold = 2e-2;
        GLO.chSamplePeriod = 5; % This dataset has 1 measurement every 5 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 120; % [s]

    case 'HaderaSecurity'
        load( [GLO.datasetPath '/Hadera_Security/HaderaSecurity-05-17.mat'] );
        switch experimentRun
            case {0,1}
                GLO.LocMat = LocMat;
                GLO.TopMat = TopMat;
                GLO.TechMat = TechMat;
                GLO.AdjMat = AdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1 or leave empty.']);
        end
        GLO.metricType = GLO.metricSNR;
        GLO.threshold = 20;
        GLO.chSamplePeriod = 60; % This dataset has 1 measurement every 60 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 20; % [s]

    case 'GardaLake'
        load( [GLO.datasetPath '/Garda_Lake/GardaLake-12-15.mat'] );
        switch experimentRun
            case {1,2,3,4}
                eval( ['GLO.LocMat = LocMat' num2str(experimentRun)] );
                eval( ['GLO.TopMat = TopMat' num2str(experimentRun)] );
                eval( ['GLO.TechMat = TechMat' num2str(experimentRun)] );
                eval( ['GLO.AdjMat = AdjMat' num2str(experimentRun)] );
            case 'all'
                GLO.LocMat = FullLocMat;
                GLO.TopMat = FullTopMat;
                GLO.TechMat = FullTechMat;
                GLO.AdjMat = FullAdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1-4 or ''all''.']);
        end
        GLO.metricType = GLO.metricRSS;
        GLO.threshold = -59;
        GLO.chSamplePeriod = 1; % This dataset has 1 measurement every 1 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 30; % [s]
        
    case 'ALOMEX'
        load( [GLO.datasetPath '/ALOMEX/ALOMEX15.mat'] );
        switch experimentRun
            case {0,1}
                GLO.LocMat = LocMat;
                GLO.TopMat = TopMat;
                GLO.TechMat = TechMat;
                GLO.AdjMat = AdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1 or leave empty.']);
        end
        GLO.metricType = GLO.metricRSS;
        GLO.threshold = -58;
        GLO.chSamplePeriod = 1; % This dataset has 1 measurement every 1 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 20; % [s]

    case 'HaderaMultimodalSched'
        load( [GLO.datasetPath '/Hadera_MultimodalSched/HaderaMultimodalSched-05-17.mat'] );
        switch experimentRun
            case {1,2,3,4}
                eval( ['GLO.LocMat = LocMat' num2str(experimentRun)] );
                eval( ['GLO.TopMat = TopMat' num2str(experimentRun)] );
                eval( ['GLO.TechMat = TechMat' num2str(experimentRun)] );
                eval( ['GLO.AdjMat = AdjMat' num2str(experimentRun)] );
            case 'all'
                GLO.LocMat = FullLocMat;
                GLO.TopMat = FullTopMat;
                GLO.TechMat = FullTechMat;
                GLO.AdjMat = FullAdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1-4 or ''all''.']);
        end
        GLO.metricType = GLO.metricRSS;
        GLO.threshold = -63;
        GLO.chSamplePeriod = 1; % This dataset has 1 measurement every 1 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 40; % [s]

    case 'REP'
        load( [GLO.datasetPath '/REP/REP-07-16.mat'] );
        switch experimentRun
            case {1,2,3,4}
                eval( ['GLO.LocMat = LocMat' num2str(experimentRun)] );
                eval( ['GLO.TopMat = TopMat' num2str(experimentRun)] );
                eval( ['GLO.TechMat = TechMat' num2str(experimentRun)] );
                eval( ['GLO.AdjMat = AdjMat' num2str(experimentRun)] );
            case 'all'
                GLO.LocMat = FullLocMat;
                GLO.TopMat = FullTopMat;
                GLO.TechMat = FullTechMat;
                GLO.AdjMat = FullAdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1-3 or ''all''.']);
        end
        GLO.metricType = GLO.metricOnOff;
        GLO.threshold = 0.5;
        GLO.chSamplePeriod = 1; % This dataset has 1 measurement every 1 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 30; % [s]

    case 'BerlinMultimodal'
        load( [GLO.datasetPath '/Berlin_Multimodal/BerlinMultimodal-06-16.mat'] );
        switch experimentRun
            case {1,2,3,4,5}
                eval( ['GLO.LocMat = LocMat' num2str(experimentRun)] );
                eval( ['GLO.TopMat = TopMat' num2str(experimentRun)] );
                eval( ['GLO.TechMat = TechMat' num2str(experimentRun)] );
                eval( ['GLO.AdjMat = AdjMat' num2str(experimentRun)] );
            case 'all'
                GLO.LocMat = FullLocMat;
                GLO.TopMat = FullTopMat;
                GLO.TechMat = FullTechMat;
                GLO.AdjMat = FullAdjMat;
            otherwise
                error(['loadTopologyData::Case ''' experimentName '''::Requested run ''' num2str(experimentRun) ''' not recognized. Try 1-5 or ''all''.']);
        end
        GLO.metricType = GLO.metricOnOff;
        GLO.threshold = 0.5;
        GLO.chSamplePeriod = 1; % This dataset has 1 measurement every 1 s
        % Tells the simulator how often to compute metrics, in order to adapt to data granularity
        GLO.perfSamplePeriod = 30; % [s]

    otherwise
        error(['loadTopologyData::Case ''' experimentName ''' unknown']);
        
end

GLO.nTech = size( GLO.TopMat, 4 );
GLO.chSampleEpochs = (0 : size(GLO.TopMat, 1)-1) * GLO.chSamplePeriod;
GLO.nNodes = size( GLO.TopMat, 2 );

