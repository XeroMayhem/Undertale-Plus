local SqueakEvent, super = setmetatable(Event, {__index = "squeak"})

function SqueakEvent:onInteract()
    local sfx = love.audio.newSource('assets/sounds/snd_hero.wav', "static")
    sfx:play()
    print("Squeaked")
end

return SqueakEvent