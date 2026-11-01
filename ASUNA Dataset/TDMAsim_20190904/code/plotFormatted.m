% Makes a nicely formatted plot
%
%   plotformatted( figID, type, time, values, xLab, yLab, legLab, legPos, xLimit, yLimit )
%
%   Input:
%     - figID: some figure ID (a positive integer number)
%     - type: 'line' or 'area'
%     - time: vector of time epochs corresponding to plotted values
%     - values: values to be plotted
%     - xLab, yLab: strings with the x-axis and y-axis labels
%     - legLab: cell with legend entries
%     - legPos: legend location (if left empty, it defaults to 'Best')
%     - xLimit, yLimit: 1x2 vectors with minimum and maximum values for the x-axis and y-axis
%
% %%% plotFormatted.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

function plotFormatted( figID, type, time, values, xLab, yLab, legLab, legPos, xLimit, yLimit )

global GLO

if isempty(legPos)
    legPos = 'Best';
end

figure(figID); clf; hold on;
switch type
    case 'area'
        area( time, values );
    case 'line'
        plot( time, values, 'LineWidth', 3 );
    otherwise
        error('plotPerTechPDR::unknown plot type, try ''line'' or ''area''.');
end
if ~isempty(xLimit)
    xlim( xLimit );
end
if ~isempty(yLimit)
    ylim( yLimit );
end
xlabel( xLab );
ylabel( yLab );
if ~isempty(legLab)
    lh = legend( legLab );
    set( lh, 'Location', legPos, 'FontSize', GLO.legFontSize, 'Orientation', 'Horizontal', 'EdgeColor', 'White' );
end

set( gcf, 'Position', GLO.figPos+[ceil(rand*200) ceil(rand*200) 0 0] );
set( gca, 'Position', GLO.axisPos );
set( gca, 'FontSize', GLO.fontSize );
set( get( gca, 'XLabel' ), 'FontSize', GLO.fontSize );
set( get( gca, 'YLabel' ), 'FontSize', GLO.fontSize );





