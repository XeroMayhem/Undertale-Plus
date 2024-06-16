local function key_load()

    input:keypress('z', function()

        if playerFree == true then
    
            local px, py = player.collider:getPosition()
            local colliders = world:queryCircleArea(px, py, 20 *gameScale, {'interactable'})
    
            if #colliders > 0 then
                for i, obj in pairs(gameMap.layers["Objects"].objects) do
                    if obj.id == colliders[1].id then
                        if string.sub(obj.name, 1, 3) == "npc" then
                            local script = 'scripts/world/npcs/' ..gameMap:getObjectProperties("Objects", obj.name).script--'scripts/npc'
                            --local event = require(script)
                            --local npc = event:create(obj.x *2, obj.y *2, gameMap:getObjectProperties("Objects", obj.name).script, gameMap:getObjectProperties("Objects", obj.name).sprite)
                            local event = require(script)
                            print(script)
                            require(script):onInteract()
                        elseif string.sub(obj.name, 1, 4) == "sign" then
                            local event = require 'scripts/sign'
                            event:onInteract()
                        elseif string.sub(obj.name, 1, 10) == "transition" then
                            local script = 'scripts/transition'
                            local event = require(script)
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
    love.audio.setVolume(1)

    json = require 'libraries.json'
    --[[ load mods
    local open = io.open
    local file = open("mods/testmod/mod.json", "rb")
    if not file then return nil end
    local jsonString = file:read "*a"
    file:close()
    
    modFile = json.decode(jsonString)
    modPath = 'mods/testmod/'
]]
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
    world:addCollisionClass('wall')
    world:addCollisionClass('instance')
    world:addCollisionClass('interactable', {ignores = {'player'}})
    world:addCollisionClass('transition', {ignores = {'player'}})
    world:addCollisionClass('cutscene', {ignores = {'player'}})

    love.window.setTitle("Undertale+")
    love.window.setMode(320 *gameScale, 240*gameScale)

    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    sti = require 'libraries/sti'
    local map = 'RuinsTestMap'
    gameMap = sti('scripts/world/maps/'.. map..'.lua')--sti(modPath ..'scripts/world/maps/' .. modFile.map ..'.lua') --Load Mod Map
    
    playerFree = true

    cutsceneActive = false
    cutsceneReady = true
    TransitionIsActive = false
    TransitionAlpha = 0
    TransitionMultiplier = 1
    curTransition = nil

    music = {}
    music.ruins = love.audio.newSource('assets/music/mus_ruins.ogg', "stream")

    bgMusic = music.ruins
    bgMusic:setLooping(true)



    overworld = {}
    overworld.objects = {}
    overworld.scripts = require 'scripts.overworld_scripts'

    player = require 'scripts.player'
    player:load()

    camx = 0
    camy = 0
    camf = player

    walls = {}
    if gameMap.layers["Markers"] then
        gameMap.layers["Markers"].visible = false
    end

    if gameMap.layers["Collision"] then
        for i, obj in pairs(gameMap.layers["Collision"].objects) do
            local wall = world:newRectangleCollider(obj.x *gameScale, obj.y *gameScale, obj.width *gameScale, obj.height *gameScale)
            wall:setType('static')
            wall:setCollisionClass('wall')
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

    world:update(dt)

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

        colliders = world:queryCircleArea(px, py, 20, {'transition'})

        if #colliders > 0 then
            for i, obj in pairs(gameMap.layers["Objects"].objects) do
                if obj.id == colliders[1].id and cutsceneReady == true then
                    TransitionIsActive = true
                    curTransition = obj
                    playerFree = false
                end
            end
        end

        colliders = {}

    else
        player.anim:gotoFrame(2)

        if cutsceneActive == true then
            curCutscene:update()
        end

    end

    if camf.x > 160 *gameScale then
        camx = camf.x - (160 *gameScale)
    end

    if camf.y > 120 *gameScale then
        camy = camf.y - (120 *gameScale)
    end

    camx = math.min(camx, (gameMap.width  *gameMap.tilewidth *gameScale) -(320*gameScale))
    camy = math.min(camy, (gameMap.height  *gameMap.tileheight *gameScale) -(240*gameScale))

    if Textbox.isActive == true then
        Textbox:update()
    end

end

function love.draw()

    love.graphics.translate(-camx, -camy)

    gameMap:draw(-camx/2, nil, gameScale, gameScale)
    
    local objects = {}
    for i=1, #overworld.objects do
        objects[i] = {overworld.objects[i].depth, overworld.objects[i]}
    end
    table.sort(objects, function(a,b) return a[1] > b[1] end)

    for i, obj in ipairs(objects) do
        obj[2]:draw()
   end

   --world:draw()
   --world:setQueryDebugDrawing(true)

   love.graphics.translate(0, 0)
   
    if cutsceneActive == true then
        curCutscene:draw()
    end

    if Textbox.isActive == true then
        Textbox:draw()
    end
    
    if TransitionIsActive == true then
        TransitionAlpha = TransitionAlpha +((1/10) *TransitionMultiplier)
        if TransitionAlpha >= 1 then
            TransitionMultiplier = -1
            local script = 'scripts/transition'
            world:destroy()
            world = wf.newWorld(0, 0)
            world:addCollisionClass('player')
            world:addCollisionClass('wall')
            world:addCollisionClass('instance')
            world:addCollisionClass('interactable', {ignores = {'player'}})
            world:addCollisionClass('transition', {ignores = {'player'}})
            world:addCollisionClass('cutscene', {ignores = {'player'}})
            curCutscene = require(script)
            curCutscene:transition(gameMap:getObjectProperties("Objects", curTransition.name).marker, gameMap:getObjectProperties("Objects", curTransition.name).map)
            playerFree = true
        end
        if TransitionMultiplier == -1 and TransitionAlpha <= 0 then
            TransitionIsActive = false
            TransitionAlpha = 0
            TransitionMultiplier = 1
            curTransition = nil
            playerFree = true
        end
        love.graphics.setColor(0, 0, 0, TransitionAlpha)
        love.graphics.rectangle("fill", camx, camy, 640, 480)
        love.graphics.setColor(255, 255, 255, 1)
    end

end