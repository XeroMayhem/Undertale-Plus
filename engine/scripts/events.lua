local Event = {}

function Event:init()
    print("Event Created")
end

Event.super = Event

return Event