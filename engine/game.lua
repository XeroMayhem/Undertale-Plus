local function key_load()

    input:keypress('z', function()

        if playerFree == true then
    
            local colliders = player:checkDirect({'interactable'})
    
            if #colliders > 0 then
                for i, obj in pairs(gameMap.layers["Objects"].objects) do
                    if obj.id == colliders[1].id then
                        if string.sub(obj.name, 1, 3) == "npc" then
                            local script = mod_loaded ..'scripts/world/npcs/' ..gameMap:getObjectProperties("Objects", obj.name).script--mod_loaded ..'scripts/npc'
                            local event = require(script)
                            require(script):onInteract()
                        elseif string.sub(obj.name, 1, 4) == "sign" then
                            local event = require 'engine/scripts/sign'
                            event:onInteract()
                        elseif string.sub(obj.name, 1, 10) == "transition" then
                            local script = 'engine/scripts/transition'
                            local event = require(script)
                        elseif string.sub(obj.name, 1, 10) == "save" then
                            SaveMenu:create()
                        else
                            local script = mod_loaded ..'scripts/world/events/' ..obj.name
                            local event = require(script)
                            event:onInteract()
                        end
                    end
                end
            end
    
            colliders = {}
    
        end
    
    end)

    input:keypress('c', function()

        if playerFree == true then
            overworld_menu:create()
        elseif overworld_menu.isMain then
            overworld_menu:destroy()
        end

    end)

    input:keypress('space', random_encounter)

end

function start_battle()
    local enemy_list = love.filesystem.getDirectoryItems('mods/'.. Plus.loaded_mod..'/scripts/battle/enemies')
    for i = 1, #enemy_list do
        local name = 'mods/'.. Plus.loaded_mod..'/scripts/battle/enemies/' ..enemy_list[i]
        name = name:sub(1, #name -4)
        package.loaded[name] = nil
    end
    Plus:reloadState('battle')
end

function start_encounter(x, y, soul)
    x = defaultValue(x, player.soul_cursour.x)
    y = defaultValue(y, player.soul_cursour.y)
    soul = defaultValue(soul, 'assets/sprites/ui/battle/spr_soul.png')
    
    curEncounter = require('engine.scripts.encounter')(x, y, soul)
    isEncounter = true
    playerFree = false
end

function random_encounter()
    start_encounter()
end

function load_map()
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
        local objLength = #overworld.objects +1
        for i, obj in pairs(gameMap.layers["Objects"].objects) do
            local interactable = nil
            if obj["width"] > 0 then
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
                local event = require ('engine.scripts.npc')
                local npc = nil
                if obj["width"] > 0 then
                    npc = event:create(obj.x *2, obj.y *2, gameMap:getObjectProperties("Objects", obj.name).script, gameMap:getObjectProperties("Objects", obj.name).sprite, obj.width, obj.height)
                else
                    npc = event:create(obj.x *2, obj.y *2, gameMap:getObjectProperties("Objects", obj.name).script, gameMap:getObjectProperties("Objects", obj.name).sprite)
                end
                npc.name = obj.name
                npc.id = i +objLength
                npc:init()
                function npc:destroy()
                    table.remove(overworld.objects, npc.id)
                    interactable:destroy()
                    npc.collider:destroy()
                end
            elseif string.sub(obj.name, 1, 4) == "sign" then

            elseif string.sub(obj.name, 1, 10) == "save" then
                local event = require ('engine.scripts.save')
                local save = event:create(obj.x *2, obj.y *2)
                save.name = "save"
                save:init() 
            else
                local event = require (mod_loaded ..'scripts.world.events.' ..obj.name)
                event:init()
            end
        end
        gameMap.layers["Objects"].visible = false
    end

    if gameMap.layers["Cutscene"] then
        for i, obj in pairs(gameMap.layers["Cutscene"].objects) do
            local interactable = nil
            if obj["width"] > 0 then
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

function reset_world()
    world:destroy()
    world = wf.newWorld(0, 0)
    world:addCollisionClass('player')
    world:addCollisionClass('wall')
    world:addCollisionClass('instance')
    world:addCollisionClass('interactable', {ignores = {'player'}})
    world:addCollisionClass('transition', {ignores = {'player'}})
    world:addCollisionClass('cutscene', {ignores = {'player'}})
    world:addCollisionClass('ghost', {ignores = {'player'}})
end

function set_area(new_area)

    area = new_area
    area_data = json.decode(love.filesystem.read(mod_loaded ..'scripts/world/areas/' ..area ..'.json'))
    bgMusic:stop()
    bgMusic = love.audio.newSource(mod_loaded ..'assets/music/' ..area_data.music, "stream")
    bgMusic:setLooping(true)
    bgMusic:play()

end

local game = {}
game.loaded = false

function game.update(dt)

    game_time = game_time +1
    
    if game.loaded == false then 

        game.loaded = true
    
        love.audio.setVolume(1)
    
        json = require 'engine.libraries.json'
        
        --load mods
    
        flag = {}
        for i = 1, mod_data.flag_count do
            table.insert(flag, 0)
        end

        cell = require(mod_loaded ..'scripts/data/cell/cell')
        cell:init()
    
        Event = require 'engine.scripts.events'
        
        map_sprite = require 'engine.scripts.map_sprite'
        instance = require 'engine.scripts.object'
    
        input = require 'engine/scripts/input'
        key_load()
        font = require 'engine/scripts/font'

        SaveMenu = require 'engine/scripts/save_menu'
        SaveMenu:init()
        
        Textbox = require 'engine/scripts/dialogue'
        Textbox:init()
 
        curEncounter = require('engine.scripts.encounter')(0, 0)
        isEncounter = false
        
        TransitionIsActive = false
        TransitionAlpha = 0
        TransitionMultiplier = 1
        curTransition = nil
        
        can_encounter = true
        
        overworld_menu = require 'engine/scripts/overworld_menu'
        overworld_menu:init()
        overworld_menu.has_cell = true --mod_data.has_cell
    
        wf = require 'engine/libraries/windfield'
        world = wf.newWorld(0, 0)
        world:addCollisionClass('player')
        world:addCollisionClass('wall')
        world:addCollisionClass('instance')
        world:addCollisionClass('interactable', {ignores = {'player'}})
        world:addCollisionClass('transition', {ignores = {'player'}})
        world:addCollisionClass('cutscene', {ignores = {'player'}})
        world:addCollisionClass('ghost', {ignores = {'player'}})
    
        love.graphics.setDefaultFilter("nearest", "nearest")
    
        sti = require 'engine/libraries/sti'
        room = mod_data.map
        gameMap = sti(mod_loaded ..'scripts/world/maps/' .. room ..'.lua')
        
        playerFree = true
    
        cutsceneActive = false
        cutsceneReady = true
        cutscene = require 'engine.scripts.cutscene'

        area = mod_data.area
        area_data = json.decode(love.filesystem.read(mod_loaded ..'scripts/world/areas/' ..area ..'.json'))
    
        bgMusic = love.audio.newSource(mod_loaded ..'assets/music/' ..area_data.music, "stream")
        bgMusic:setLooping(true)
        bgMusic:play()
    
        inventory = require 'engine.scripts.inventory'
        inventory:create()
    
        overworld = {}
        overworld.objects = {}
        overworld.scripts = require 'engine.scripts.overworld_scripts'
    
        player = require 'engine.scripts.player'
        player:load()
    
        camx = 0
        camy = 0
        camf = player
    
        load_map()
    
        --load save 
        determination = require 'engine.scripts.determination'
        determination:load()
    
    end

    if playerFree == true then

        player:update(dt)

        local colliders = player:checkLiteral({'cutscene'})

        if #colliders > 0 then
            for i, obj in pairs(gameMap.layers["Cutscene"].objects) do
                if obj.id == colliders[1].id and cutsceneReady == true then
                    
                    cutsceneReady = false
                    
                    cutsceneActive = true
                    playerFree = false
                    local script = mod_loaded ..'scripts/world/cutscenes/' ..obj.name
                    package.loaded['engine.scripts.cutscene'] = nil
                    cutscene = require 'engine.scripts.cutscene'
                    require(script)(cutscene)
                    curCutscene = function()
                        cutscene:update()
                    end
                end
            end
        else
            cutsceneReady = true
        end

        colliders = world:queryRectangleArea(player.x -player.width/2, player.y -player.height/2, player.width, player.height, {'transition'})

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
        player.frame = 2
    end

    if camf.x > 160 *gameScale then
        camx = camf.x - (160 *gameScale)
    end

    if camf.y > 120 *gameScale then
        camy = camf.y - (120 *gameScale)
    end

    camx = math.min(camx, (gameMap.width  *gameMap.tilewidth *gameScale) -(320*gameScale))
    camy = math.min(camy, (gameMap.height  *gameMap.tileheight *gameScale) -(240*gameScale))

    world:update(dt)

    wrong_area = true
    for r, area_room in ipairs(area_data["rooms"]) do
        if area_room == room then
            wrong_area = false
        end
    end
    
    if wrong_area == true then
        local area_list = love.filesystem.getDirectoryItems(mod_loaded ..'scripts/world/areas/')
        for a, area in ipairs(area_list) do
            local data = json.decode(love.filesystem.read(mod_loaded ..'scripts/world/areas/' ..area))
            for r, area_room in ipairs(data["rooms"]) do
                if area_room == room then
                    set_area(area:sub(1, #area -5))
                    break
                end
            end
        end
    end

    if Textbox.isActive == true then
        Textbox:update()
    end

    if cutsceneActive == true then
        curCutscene()
    end

end

function game.draw()

    if love.window.getFullscreen() == true then

        local width, height = love.window.getDesktopDimensions()
        local scale = math.min(width/320, height/240)
        local offset = (width -(320 *scale))/2

        gameMap:draw((offset/scale) -camx/2, -camy/2, scale, scale)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, offset +1, height)
        love.graphics.rectangle("fill", width -offset -1, 0, offset +1, height)
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.scale(scale/gameScale, scale/gameScale)
        love.graphics.translate((offset/(scale/2)) -camx, -camy)

    else
        love.graphics.translate(-camx, -camy)
        gameMap:draw(-camx/2, -camy/2, gameScale, gameScale)
    end
    
    local objects = {}
    for i=1, #overworld.objects do
        objects[i] = {overworld.objects[i].depth, overworld.objects[i]}
    end
    table.sort(objects, function(a,b) return a[1] > b[1] end)

    for i, obj in ipairs(objects) do
        obj[2]:draw()
    end

    --[[
    world:draw()
    world:setQueryDebugDrawing(true)
    --]]

    love.graphics.translate(0, 0)

    if overworld_menu.active == true then
        overworld_menu:draw()
    end

    if SaveMenu.isActive == true then
        SaveMenu:draw()
    end

    if isEncounter == true then
        curEncounter:update()
    end

    if Textbox.isActive == true then
        Textbox:draw()
    end
    
    if TransitionIsActive == true then
        TransitionAlpha = TransitionAlpha +((1/10) *TransitionMultiplier)
        if TransitionAlpha >= 1 then
            TransitionMultiplier = -1
            local script = 'engine/scripts/transition'
            reset_world()
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

    if love.window.getFullscreen() == true then

        local width, height = love.window.getDesktopDimensions()
        local scale = math.min(width/320, height/240)
        local offset = (width -(320 *scale))/2
        love.graphics.translate(camx -offset, 0)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, offset +1, height)
        love.graphics.rectangle("fill", (offset -1) +(320 *scale)/(scale/2), 0, offset +1, height)
        love.graphics.setColor(1, 1, 1, 1)

    end

end

game.excluded_vars = {"loaded"}
return game