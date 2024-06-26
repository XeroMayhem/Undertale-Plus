local SqueakEvent, super = setmetatable(Event, {__index = "squeak"})

function SqueakEvent:init()
    local sfx = love.audio.newSource(mod_loaded ..'assets/sounds/snd_hero.wav', "static")
    sfx:play()
    cutsceneActive = false
end

-- Update gets called every frame
function SqueakEvent:update()

end

function SqueakEvent:draw()

end


return SqueakEvent