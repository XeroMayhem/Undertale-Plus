local SqueakEvent, super = setmetatable(Event, {__index = "squeak"})

function SqueakEvent:onInteract()
    local sfx = love.audio.newSource(mod_loaded ..'assets/sounds/snd_hero.wav', "static")
    sfx:play()
end

return SqueakEvent