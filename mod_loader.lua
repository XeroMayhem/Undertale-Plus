function load()

    love.window.setTitle("Undertale+")
    love.window.setMode(320 *2, 240 *2)

    local input = require 'engine/scripts/input'
    input:keypress('z', function()

        require 'game'
    
    end)

end

load()

function love.update(dt)

end

function love.draw()

end