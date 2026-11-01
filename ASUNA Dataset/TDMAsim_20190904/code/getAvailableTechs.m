% Returns the technologies available for a link between two nodes at the specified time
%
%   avTechs = getAvailableTechs ( time, node, dest )
%
%   Input:
%     - time: current time
%     - node: source node
%     - dest: destination node
%
%   Output:
%     - avTechs: available technologies
%
% %%% getAvailableTechs.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

function avTechs = getAvailableTechs ( time, node, dest )

global GLO

idTime = find( GLO.chSampleEpochs <= time, 1, 'last' );
techs = and( reshape( GLO.TechMat( idTime, node, : ), 1, GLO.nTech ) , ...
             reshape( GLO.TechMat( idTime, dest, : ), 1, GLO.nTech ) );

avTechs = find( techs~=0 );