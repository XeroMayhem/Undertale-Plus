local SqueakEvent = {}

function SqueakEvent:onInteract()
    local sfx = love.audio.newSource(mod_loaded ..'assets/sounds/squeak.wav', "static")
    sfx:play()
end

return SqueakEvent