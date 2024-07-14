return function (x, y, dir, speed)
    
    local Bullet = enemy_scripts:create_bullet(x, y, "basicbullet.png")
    Bullet.dir = dir
    Bullet.speed = speed
    function Bullet:update(dt)
        Bullet.x = Bullet.x + (math.cos(Bullet.dir) * speed)
        Bullet.y = Bullet.y + (math.sin(Bullet.dir) * speed)
    end
    return Bullet

end