local input = require 'engine/scripts/input'
local font = require 'engine/scripts/font'

local loader = {}
gameScale = 2
loader.options = {{name = "Play", active = false}, {name = "Open Mods Folder", active = false}, {name = "Option", active = false}, {name = "Credits", active = false}}
loader.optionSel = 1
love.window.setTitle("Undertale+")
love.window.setMode(320 *2, 240 *2)
love.graphics.setDefaultFilter("nearest", "nearest")

input:keypress('z', function()

    Plus:loadState('game')

end)

input:keypress('down', function()

    loader.optionSel = loader.optionSel +1
    loader.optionSel = math.min(loader.optionSel, #loader.options)

end)

input:keypress('up', function()

    loader.optionSel = loader.optionSel -1
    loader.optionSel = math.max(loader.optionSel, 1)

end)

function love.update(dt)

end

function love.draw()
    
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

end