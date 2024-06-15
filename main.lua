local function key_load()

    input:keypress('z', function()

        if playerFree == true then
    
            local px, py = player.collider:getPosition()
            local colliders = world:queryCircleArea(px, py, 20 *gameScale, {'interactable'})
    
            if #colliders > 0 then
                for i, obj in pairs(gameMap.layers["Objects"].objects) do
                    if obj.id == colliders[1].id then
                        if string.sub(obj.name, 1, 3) == "npc" then
                            local script = 'scripts/world/events/npc'
                            local event = require(script)
                            local npc = event:create(obj.x *2, obj.y *2, gameMap:getObjectProperties("Objects", obj.name).script, gameMap:getObjectProperties("Objects", obj.name).sprite)
                            npc:onInteract()

                        else
                            local script = 'scripts/world/events/' ..obj.name
                            local event = require(script)
                            event:onInteract()
                        end
                    end
                end
            end
    
            colliders = {}
    
        end
    
    end)

end

function love.load()

    gameScale = 2

    Event = require 'scripts.events'

    map_sprite = require 'scripts.map_sprite'
    instance = require 'scripts.object'

    input = require 'scripts/input'
    key_load()
    font = require 'scripts/font'
    
    Textbox = require 'scripts/dialogue'
    Textbox:init()

    wf = require 'libraries/windfield'
    world = wf.newWorld(0, 0)
    world:addCollisionClass('player')
    world:addCollisionClass('interactable', {ignores = {'player'}})
    world:addCollisionClass('cutscene', {ignores = {'player'}})

    love.window.setTitle("Undertale+")
    love.window.setMode(320 *gameScale, 240*gameScale)

    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    sti = require 'libraries/sti'
    gameMap = sti('scripts/world/maps/RuinsTestMap.lua')
    
    playerFree = true

    cutsceneActive = false
    cutsceneReady = true

    music = {}
    music.ruins = love.audio.newSource('assets/music/ruins.mp3', "stream")

    bgMusic = music.ruins
    bgMusic:setLooping(true)

    overworld = {}
    overworld.objects = {}
    overworld.scripts = require 'scripts.overworld_scripts'

    player = require 'scripts.player'
    player:load()

    walls = {}
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
            if string.sub(obj.name, 1, 3) == "npc" then
                local event = require ('scripts.world.events.npc')
                local npc = event:create(obj.x *2, obj.y *2, gameMap:getObjectProperties("Objects", obj.name).script, gameMap:getObjectProperties("Objects", obj.name).sprite)
                npc:init()
            else
                local event = require ('scripts.world.events.' ..obj.name)
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

    bgMusic:play()

end

function love.update(dt)

    if playerFree == true then

        player:update(dt)

        local px, py = player.collider:getPosition()
        local colliders = world:queryCircleArea(px, py, 20, {'cutscene'})

        if #colliders > 0 then
            for i, obj in pairs(gameMap.layers["Cutscene"].objects) do
                if obj.id == colliders[1].id and cutsceneReady == true then
                    
                    cutsceneReady = false
                    local script = 'scripts/world/cutscenes/' ..obj.name
                    curCutscene = require(script)
                    curCutscene:init()
                end
            end
        else
            cutsceneReady = true
        end

        colliders = {}
    else
        player.anim:gotoFrame(2)

        if cutsceneActive == true then
            curCutscene:update()
        end

    end

    world:update(dt)
    if Textbox.isActive == true then
        Textbox:update()
    end

end

function love.draw()
    gameMap:draw(nil, nil, gameScale, gameScale)
    
    local objects = {}
    for i=1, #overworld.objects do
        objects[i] = {overworld.objects[i].depth, overworld.objects[i]}
    end
    table.sort(objects, function(a,b) return a[1] > b[1] end)

    for i, obj in ipairs(objects) do
        obj[2]:draw()
   end
   --world:draw(1)

    if cutsceneActive == true then
        curCutscene:draw()
    end

    if Textbox.isActive == true then
        Textbox:draw()
    end

end