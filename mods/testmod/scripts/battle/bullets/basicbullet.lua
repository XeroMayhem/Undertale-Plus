return function (x, y, dir, speed)
    
    local Bullet = enemy_scripts:bullet_init(x, y, "basicbullet.png")
    Bullet.dir = dir
    Bullet.speed = speed
    Bullet.destroyed = false
    function Bullet:update(dt)
        moveObject(Bullet, Bullet.speed, Bullet.dir)
        if Bullet.speed < 0 and Bullet.x < 0 then
            Bullet:destroy()
        end
    end
    return Bullet

end