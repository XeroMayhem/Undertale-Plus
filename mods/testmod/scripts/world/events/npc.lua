local npc = {}

function npc:create(x, y, index, sprite)

    local NPC = instance:create(x, y, 'assets/sprites/npcs/'..sprite, nil, 20, 10, 0, -5)
    NPC.index = index

    local script = 'scripts/world/npcs/' ..NPC.index
    NPC.scripts = require(script)

    function NPC:onInteract()
        NPC.scripts:onInteract()
    end

    return NPC
end
return npc

--[[
local x = 0
local y = 0
local sprite = ""
local index = ""
for i, obj in pairs(gameMap.layers["Objects"].objects) do
    if string.sub(obj.name, 1, 3) == "npc" then
        x = obj.x *2
        y = obj.y *2
        index = gameMap:getObjectProperties("Objects", obj.name).script
        sprite = gameMap:getObjectProperties("Objects", obj.name).sprite
        print(index)
    end
end

local NPC = instance:create(x, y, 'assets/sprites/npcs/'..sprite, nil, 20, 10, 0, -5)
NPC.index = index

function NPC:onInteract()
    local script = 'scripts/world/npcs/' ..NPC.index
    local event = require(script)
    event:load()
end

return NPC
]]