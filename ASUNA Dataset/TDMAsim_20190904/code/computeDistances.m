% Compute distances among the nodes at a given time instant given a location matrix and the propagation speed
%
%   [nDist, prTime] = computeDistances( cProp , t )
%
%   Input:
%     - cProp: propagation speed in m/s
%     - t: current time
%
%   Output:
%     - nDist: matrix whose element (i,j) is the distance between nodes i and j
%     - prTime: matrix whose element (i,j) is the propagation time between nodes i and j
%
% %%% computeDistances.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25


function [nDist, prTime] = computeDistances( cProp , t )

global GLO

% Compute distances and propagation times between each pair of nodes
nDist = zeros(GLO.nNodes, GLO.nNodes);

if size( GLO.LocMat, 3 ) == 2
    currentNodeLocations = reshape( GLO.LocMat( sum(GLO.chSampleEpochs <= t),:,:), GLO.nNodes, 2 );
elseif size( GLO.LocMat, 3 ) == 3
    currentNodeLocations = reshape( GLO.LocMat( sum(GLO.chSampleEpochs <= t),:,:), GLO.nNodes, 3 );
else
    error('computeDistances.m::size( GLO.LocMat, 3 ) is neither 2 nor 3. Aborting.');
end

for iNode = 1 : GLO.nNodes
    for jNode = iNode+1 : GLO.nNodes
        nDist( iNode, jNode ) = norm( currentNodeLocations(iNode,:) - currentNodeLocations(jNode,:) );
    end
end

% Make matrices symmetric
nDist = nDist + (triu(nDist,1))';
prTime = nDist / cProp;
