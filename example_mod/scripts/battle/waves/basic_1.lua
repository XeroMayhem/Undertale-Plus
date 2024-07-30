local Frog = {}

function Frog:create()
    bt:turn_length(10)
    Frog.timer = 0
    Frog.time = 30
    Frog.has_green = false
end

function Frog:update(dt)

    Frog.timer = Frog.timer +1
    if Frog.timer >= Frog.time then
        Frog.timer = 0
        local x = 640 + 20
        -- Get a random Y position between the top and the bottom of the arena
        local y = math.random(320 -(bt.box.cur_height/2), 320 +(bt.box.cur_height/2))
        local Bullet = enemy_scripts:spawn_bullet(Frog.monster, 'basicbullet', x, y, math.rad(180), -6)
        if math.random(10) == 1 and not Frog.has_green == true then
            Bullet.color = 'green'
            Frog.has_green = true
        end
    end
    
end

return Frog