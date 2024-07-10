local rooms = {}

function rooms:getName(room)
    if room == "Ruins01" then
        return "Ruins - Mid point"
    elseif room == "Ruins03" then
        return "Ruins - Caverns Entrance"
    end
end

return rooms