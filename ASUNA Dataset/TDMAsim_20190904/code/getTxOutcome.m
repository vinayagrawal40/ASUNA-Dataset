% Return positive/negative outcome of a transmission
%
%   isCorrect = getTxOutcome( t, iTx, iRx, iTech )
%
%   Inputs:
%     - t: current time
%     - iTx: transmitter node
%     - iRx: receiver node
%     - iTech: index of the technology used
%
%   Output:
%     - isCorrect: boolean value
%
% %%% getTxOutcome.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

function isCorrect = getTxOutcome( t, iTx, iRx, iTech )

global GLO

% Sample-and-hold most recent channel quality measurement; check if >= or <= than threshold depending on metric type
switch GLO.metricType
    case {GLO.metricSNR, GLO.metricRSS, GLO.metricOnOff}
        isCorrect = interp1( GLO.chSampleEpochs, GLO.TopMat(:,iTx,iRx,iTech), t, 'previous' ) >= GLO.threshold;
    case GLO.metricBER
        isCorrect = interp1( GLO.chSampleEpochs, GLO.TopMat(:,iTx,iRx,iTech), t, 'previous' ) <= GLO.threshold;
    otherwise
        error(['getTxOutcome::Metric type ' num2str(GLO.metricType) ' not recognized.']);
end