local whimsun = enemy_scripts:create("Whimsun", 'spr_whimsun', (640/3) *2)
whimsun.stats = enemy_scripts:stats(10, 4, 0, 2, 2)
whimsun.y = 40
whimsun.ystart = whimsun.y
whimsun.yend = 60
whimsun.spare = true
whimsun.fly_speed = 0.5
whimsun.waves = {'whim'}


function whimsun:update(dt)
    
    if whimsun.been_spared == false then
        whimsun.y = whimsun.y +(whimsun.fly_speed)
        if whimsun.fly_speed > 0 and whimsun.y >= whimsun.yend then
            whimsun.fly_speed = whimsun.fly_speed *-1
        end

        if whimsun.fly_speed < 0 and whimsun.y <= whimsun.ystart then
            whimsun.fly_speed = whimsun.fly_speed *-1
        end
    end

end

function whimsun:act(name)
    
    if name == 'Check' then
        enemy_scripts:act_text(whimsun, "* It won't open up to you...")
    end

end

return whimsun