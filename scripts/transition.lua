local transition = {}

function transition:transition(marker, map)

    sti = require 'libraries/sti'
    gameMap = sti('scripts/world/maps/' .. map ..'.lua')--sti(modPath ..'scripts/world/maps/' .. map ..'.lua') --Load Mod Map 

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
    
    walls = {}
    if gameMap.layers["Markers"] then
        gameMap.layers["Markers"].visible = false
    end

    if gameMap.layers["Collision"] then
        for i, obj in pairs(gameMap.layers["Collision"].objects) do
            local wall = world:newRectangleCollider(obj.x *gameScale, obj.y *gameScale, obj.width *gameScale, obj.height *gameScale)
            wall:setType('static')
            table.insert(walls, wall)
        end
        gameMap.layers["Collision"].visible = false
    end

    --Interaction
    if gameMap.layers["Objects"] then
        for i, obj in pairs(gameMap.layers["Objects"].objects) do
            local interactable = nil
            if rawget(obj, width) ~= nil then
                interactable = world:newRectangleCollider(obj.x *gameScale, obj.y *gameScale, obj.width *gameScale, obj.height *gameScale)
            else
                interactable = world:newRectangleCollider(obj.x *gameScale, obj.y *gameScale, 20 *gameScale, 20 *gameScale)
            end
            interactable:setType('static')
            interactable:setCollisionClass('interactable')
            interactable.id = obj.id
            if string.sub(obj.name, 1, 10) == "transition" then
                interactable:setCollisionClass('transition')
            elseif string.sub(obj.name, 1, 3) == "npc" then
                local event = require ('scripts.npc')
                local npc = event:create(obj.x *2, obj.y *2, gameMap:getObjectProperties("Objects", obj.name).script, gameMap:getObjectProperties("Objects", obj.name).sprite)
                npc:init()
            elseif string.sub(obj.name, 1, 4) == "sign" then

            else
                local script = 'scripts/world/events/' ..obj.name
                local event = require(script)
                event:init()
            end
        end   
        gameMap.layers["Objects"].visible = false
    end

    if gameMap.layers["Cutscene"] then
        for i, obj in pairs(gameMap.layers["Cutscene"].objects) do
            local interactable = nil
            if rawget(obj, width) ~= nil then
                interactable = world:newRectangleCollider(obj.x *gameScale, obj.y *gameScale, obj.width *gameScale, obj.height *gameScale)
            else
                interactable = world:newRectangleCollider(obj.x *gameScale, obj.y *gameScale, 20 *gameScale, 20 *gameScale)
            end
            interactable:setType('static')
            interactable:setCollisionClass('cutscene')
            interactable.id = obj.id
        end
        gameMap.layers["Cutscene"].visible = false
    end
    
        

end

return transition