local SqueakEvent, super = setmetatable(Event, {__index = "squeak"})

function SqueakEvent:onInteract()
    local sfx = love.audio.newSource(mod_loaded ..'assets/sounds/squeak.wav', "static")
    sfx:play()
    print("Squeaked")
end

return SqueakEvent