local SqueakEvent, super = setmetatable(Event, {__index = "squeak"})

--[[

function SqueakEvent:init()

end

-- Update gets called every frame
function SqueakEvent:update()

end

function SqueakEvent:draw()

end

]]

-- When we interact with the pinwheel, make it spin faster!
function SqueakEvent:onInteract()
    local sfx = love.audio.newSource('assets/sounds/snd_hero.wav', "static")
    sfx:play()
    print("Squeaked")
end

return SqueakEvent