local cutscene = {}
cutscene.scenes = {}
cutscene.act = 1
cutscene.timer = 0

function cutscene:custom_function(func)
    table.insert(cutscene.scenes, func)
end

function cutscene:play_sound(filename)
    cutscene:custom_function(function ()
        local sfx = love.audio.newSource(filename, "static")
        sfx:play()
        cutscene.act = cutscene.act +1
    end)

end

function cutscene:wait(frame_time)
    cutscene:custom_function(function ()
        cutscene.timer = cutscene.timer +1
        if cutscene.timer > frame_time then
            cutscene.act = cutscene.act +1
        end
    end)

end

function cutscene:update()
    if cutscene.act > #cutscene.scenes then
        playerFree = true
        cutsceneActive = false
    else
        cutscene.scenes[cutscene.act]()
    end
end

return cutscene