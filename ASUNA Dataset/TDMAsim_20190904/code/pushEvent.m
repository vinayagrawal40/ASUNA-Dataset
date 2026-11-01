% Push events in order in the events queue
%
% [ insertedEvent , chosenSlot ] = pushEvent ( insEvent_time, insEvent_type, insEvent_node )
% 
% Inserts an event of type INSEVENT_TYPE in an event queue at time INSEVENT_TIME
% The event queue is assumed to be an N x 5 matrix whose columns indicate:
%      1. The event time
%      2. The event type
%      3. An index linking to the next event
%      4. A flag indicating if the row is available to insert an event
%      5. The node involved in the event, if relevant, 0 otherwise
%
% Output: 
%      - inserted_event: the event inserted in the queue (the full matrix row)
%      - chosenSlot: the index of the slot used for the queue event
%
% %%% pushEvent.m %%% %
% Authors: Elizaveta Dubrovinskaya, Paolo Casari
% Institution: IMDEA Networks
% Date: 2019/02/25


function [ insertedEvent , chosenSlot ] = pushEvent( insEvent_time, insEvent_type, insEvent_node )

global evQueue GLO

% If event would happen after the maximum simulation time, return
if insEvent_time > GLO.simulationTime
    return
end

chosenSlot = find(evQueue(:,GLO.eventIsFree) == 1, 1, 'first');
if isempty(chosenSlot)
    s = sprintf( 'No free slots in the event queue to insert event:\n\t%g' , event );
    error(s);
end

% Find earlier events
earlierEvents = find( evQueue(:, GLO.eventTime) <= insEvent_time );
[~, iSubEarlier] = max( evQueue(earlierEvents, GLO.eventTime) );
iEarlier = earlierEvents(iSubEarlier);
% If multiple events have the same time, queue after the latest
while evQueue(iEarlier, GLO.eventTime) == evQueue(evQueue(iEarlier, GLO.eventNext), GLO.eventTime)
    iEarlier = evQueue(iEarlier, GLO.eventNext);
end
% Get the index of the immediately next event
iNext = evQueue(iEarlier, GLO.eventNext);

% Insert event in queue
evQueue(chosenSlot, [GLO.eventTime GLO.eventType GLO.eventNodeInvolved]) = [insEvent_time insEvent_type insEvent_node];
% Link previous event to this event
evQueue(iEarlier, GLO.eventNext) = chosenSlot;
% Link next event to this event
evQueue(chosenSlot, GLO.eventNext) = iNext;
% Mark event slot as used
evQueue(chosenSlot, GLO.eventIsFree) = GLO.slotBusyFlag;

insertedEvent = evQueue(chosenSlot, :);
