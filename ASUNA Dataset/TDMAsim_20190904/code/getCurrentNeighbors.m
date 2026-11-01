% Returns the vector of the neighbors of a node at the specified time, regardless ofthe communication technology
%
%   neighs = getCurrentNeighbors( time, node )
%
%   Input:
%     - time: current time
%     - node: node for which the neighbor list is sought
%
%   Output:
%     - neigh: vector of neighbors
%
% %%% getCurrentNeighbors.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

function neighs = getCurrentNeighbors( time, node )

global GLO

idTime = find( GLO.chSampleEpochs <= time, 1, 'last' );
neighs = reshape( GLO.AdjMat( idTime,node,: ), 1, GLO.nNodes );