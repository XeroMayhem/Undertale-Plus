local Frog = {}

function Frog:create()
    bt:turn_length(10)
    Frog.timer = 0
    Frog.time = 30
end

function Frog:update(dt)

    Frog.timer = Frog.timer +1
    if Frog.timer >= Frog.time  then
        Frog.timer = 0
        local x = 640 + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = math.random(320 -(bt.box.cur_height/2), 320 +(bt.box.cur_height/2))
        local bullet = require (mod_loaded .."scripts/battle/bullets/".. 'basicbullet')(x, y, math.rad(180), 8)
        table.insert(Frog.monster.bullets, bullet)
        
    end
    
end

return Frog