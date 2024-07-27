return function()

    local enemy_encounters = mod_loaded ..'scripts/battle/encounters/' ..area
    local list = math.random(#love.filesystem.getDirectoryItems(enemy_encounters))

    require(enemy_encounters ..'/encounter_' ..list)()

end