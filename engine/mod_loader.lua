local input = require 'engine/scripts/input'
local font = require 'engine/scripts/font'

local loader = {}
gameScale = 2
loader.options = {{name = "Load a mod", active = false}, {name = "Open Mods Folder", active = false},
    {name = "Options", active = false}, {name = "Credits", active = false},
    {name = "Open wiki", active = false}, {name = "Quit", active = false}}
loader.optionSel = 1

loader.selectMod = false
loader.modSel = 1
loader.mods = love.filesystem.getDirectoryItems("mods")

input:keypress('z', function()

    if Plus.LoadedState == 'mod_hub' then

        if loader.optionSel == 1 then
            if loader.selectMod == false then
                loader.selectMod = true
                Plus.loaded_mod = loader.mods[loader.modSel]
            else
                if loader.selectMod == true then
                    mod_loaded = 'mods/'.. Plus.loaded_mod..'/'
                    mod_data = love.filesystem.load(mod_loaded ..'data.lua')()
                    Plus:loadState('game')
                end
            end
        elseif loader.optionSel == 2 then
            love.system.openURL("file://" ..love.filesystem.getSaveDirectory()..'/mods')
        elseif loader.optionSel == 5 then
            love.system.openURL("https://undertale.com/")
        end

    end

end)

input:keypress('down', function()

    if not loader.selectMod then
        loader.optionSel = loader.optionSel +1
        loader.optionSel = math.min(loader.optionSel, #loader.options)
    elseif loader.selectMod then
        loader.modSel = loader.modSel +1
        loader.modSel = math.min(loader.modSel, #loader.mods)
        Plus.loaded_mod = loader.mods[loader.modSel]
    end

end)

input:keypress('up', function()

    if not loader.selectMod then
        loader.optionSel = loader.optionSel -1
        loader.optionSel = math.max(loader.optionSel, 1)
        Plus.loaded_mod = loader.mods[loader.optionSel]
    elseif loader.selectMod then
        loader.modSel = loader.modSel -1
        loader.modSel = math.max(loader.modSel, 1)
        Plus.loaded_mod = loader.mods[loader.modSel]
    end

end)

function love.update(dt)

end

function love.draw()
    
    if loader.selectMod == false then

        local border = 3 *gameScale

        local x = -border
        local y = -border
        local width = 640 +(border *2)
        local height = 160
        love.graphics.rectangle("fill", x, y, width, height)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", x +(border), y +(border), (width -(border *2)), (height -(border *2)))
        love.graphics.setColor(255, 255, 255)

        font:setFont("main.ttf", 16)
        sprite = love.graphics.newImage('assets/sprites/launcher/title.png')
        love.graphics.draw(sprite, 16, 40, nil, 0.75, 0.75)

        font:draw({{255, 255, 255, 0.5}, "v0.1"}, 0, 480 -32)

        for i = 1, #loader.options do
            local x = 100
            local y = 120
            local gap = 16
            if i == loader.optionSel then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, (x -12) *gameScale, (y +(gap *(i -1))) *gameScale, nil, 1, 1)
            end
            font:draw(loader.options[i].name, x *gameScale, ((y -4) +((i -1) *gap))*gameScale)
        end

    elseif loader.selectMod == true then
        for i = 1, #loader.mods do
            local x = 40
            local y = 40
            local gap = 16
            if i == loader.modSel then
                sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
                love.graphics.draw(sprite, (x -12) *gameScale, (y +(gap *(i -1))) *gameScale, nil, 1, 1)
            end
            font:draw(loader.mods[i], x *gameScale, ((y -4) +((i -1) *gap))*gameScale)
        end
        sprite = love.graphics.newImage('assets/sprites/player/soul_menu.png')
        love.graphics.draw(sprite, 260, 240 +120, nil, 1, 1)
        font:draw({{255, 255, 0, 1}, "Start"}, 280, 232 +120)
    end
    
end