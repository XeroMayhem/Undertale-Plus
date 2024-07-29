local CrackEvent = {}

function CrackEvent:onInteract()
    local sfx = love.audio.newSource(mod_loaded ..'assets/sounds/snd_hero.wav', "static")
    sfx:play()
end

return CrackEvent