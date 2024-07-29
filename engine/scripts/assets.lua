
local assets = {}

--Sound
function assets.setVolume(volume)
    love.audio.setVolume(volume)
end

function assets.play_sfx(filename, loop)
    local sfx = love.audio.newSource(mod_loaded .. 'assets/sounds/'..filename, "static")
    sfx:setLooping(defaultValue(loop, false))
    sfx:play()
    return sfx

end

function assets.play_song(filename, loop)
    local song = love.audio.newSource(mod_loaded .. 'assets/music/'..filename, "stream")
    song:setLooping(defaultValue(loop, true))
    song:play()
    return song

end


return assets