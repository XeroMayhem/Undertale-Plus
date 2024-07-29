local cutscene = {}
cutscene.scenes = {}
cutscene.act = 1
cutscene.timer = 0
cutscene.text_count = 0

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

function cutscene:text(text, sound, portrait, pos)
    cutscene:custom_function(function ()
        if cutscene.text_count == 0 then
            Textbox:create()
            Textbox:pageParams(text, sound, portrait, pos)
            cutscene.text_count = 1
        end
        if Textbox.isActive == false and cutscene.text_count == 1 then
            cutscene.text_count = 0
            cutscene.act = cutscene.act +1
        end
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