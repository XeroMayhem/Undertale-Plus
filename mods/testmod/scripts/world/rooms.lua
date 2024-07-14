local rooms = {}

function rooms:getName(room)
    if room == "Ruins01" then
        return "Ruins - Mid point"
    elseif room == "Ruins03" then
        return "Ruins - Caverns Entrance"
    end
end

function rooms:get_area(room)
    if room == "Ruins01" or room == "Ruins02" or room == "Ruins03" or room == "RuinsTestMap" then
        return "Ruins"
    end
end

return rooms