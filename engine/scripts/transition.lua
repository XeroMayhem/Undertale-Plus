local transition = {}

function transition:transition(marker, map)

    sti = require 'engine/libraries/sti'
    room = map
    gameMap = sti(mod_loaded ..'scripts/world/maps/' .. room ..'.lua')--sti(modPath ..mod_loaded ..'scripts/world/maps/' .. room ..'.lua') --Load Mod Map 

    if gameMap.layers["Markers"] then
        for i, obj in pairs(gameMap.layers["Markers"].objects) do
            if obj.name == marker then
                player.x = (obj.x -29/4) *gameScale
                player.y = obj.y *gameScale
            end
        end
    end
    player.collider = world:newRectangleCollider(player.x, player.y, 19 *gameScale, 29/2 *gameScale)
    player.collider:setFixedRotation(true)
    player.collider:setCollisionClass('player')

    overworld = {}
    overworld.objects = {}
    table.insert(overworld.objects, player)
    
    load_map()

    bgMusic:play()

end

return transition