% Prints a queue of events to screen
%
% printEvQueue( evQueue )
% 
% Assumes that the event queue is a N x 5 matrix whose columns indicate:
%      1. The event time
%      2. The event type
%      3. An index linking to the next event
%      4. A flag indicating if the row is available to insert an event
%      5. The node involved in the event, if relevant, 0 otherwise
%
% %%% printEvQueue.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25

function printEvQueue()

global evQueue GLO 

% Index now lest unused queue slots are not contiguous
index = (1 : size(evQueue,1))';
iKeep = ~isinf(evQueue(:,1));

% Trim unused slots
localEvQueue = evQueue( iKeep, : );
index = index(iKeep);

% Form arrays to print as a Table object
time = localEvQueue(:,1);
type = cell( size(localEvQueue(:,2)) );
for iEv = 1 : length(GLO.evTypeNames)
    if ~any( localEvQueue(:,2)==iEv )
        continue
    end
    type( localEvQueue(:,2)==iEv ) = GLO.evTypeNames(iEv);
end
nextEvent = localEvQueue(:,3);
isFree = localEvQueue(:,4);
nodeInvolved = localEvQueue(:,5);

% Print queue as is
% Event_queue_as_is = table( index, time, type, nextEvent, isFree, nodeInvolved )

% Make a second printout by sorting by increasing event time
[~,isort] = sort( time, 'ascend' );
index = index(isort);
time = time(isort);
type = type(isort);
nextEvent = nextEvent(isort);
isFree = isFree(isort);
nodeInvolved = nodeInvolved(isort);
Event_queue_sorted = table( index, time, type, nextEvent, isFree, nodeInvolved )
