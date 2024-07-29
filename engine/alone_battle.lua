local fake_bt = {}
fake_bt.soul = {x = 40, y = 446, sprite = 'assets/sprites/ui/battle/spr_soul.png', script = 'engine.scripts.soul'}

fake_bt.box = {}
fake_bt.box.border = 5
fake_bt.box.width = 575
fake_bt.box.height = 140
fake_bt.box.cur_width = 0
fake_bt.box.cur_height = 140
fake_bt.song = love.audio.newSource('assets/sounds/mus_toomuch.ogg', "stream")
fake_bt.song:setLooping(true)
fake_bt.song:play()

fake_bt.ftext = "* But Noboy Came..."
fake_bt.ft_pos = 0

function fake_bt.update(dt)

    if Plus.keyPress == 'z' then
        Plus:loadState('game')
        bgMusic:play()
        fake_bt.song:stop()
        playerFree = true
        return nil
    end

    if fake_bt.box.cur_width < fake_bt.box.width then
        fake_bt.box.cur_width = fake_bt.box.cur_width +((fake_bt.box.width- fake_bt.box.cur_width) /2);
    end
    if fake_bt.box.cur_width > fake_bt.box.width then
        fake_bt.box.cur_width = fake_bt.box.cur_width -((fake_bt.box.cur_width- fake_bt.box.width) /2);
    end

    if fake_bt.box.cur_height < fake_bt.box.height then
        fake_bt.box.cur_height = fake_bt.box.cur_height +((fake_bt.box.height- fake_bt.box.cur_height) /2);
    end
    if fake_bt.box.cur_height > fake_bt.box.height then
        fake_bt.box.cur_height = fake_bt.box.cur_height -((fake_bt.box.cur_height- fake_bt.box.height) /2);
    end

end

function fake_bt.draw()

    if love.window.getFullscreen() == true then

        local width, height = love.window.getDesktopDimensions()
        local scale = math.min(width/320, height/240)
        local offset = (width -(320 *scale))/2

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, offset +1, height)
        love.graphics.rectangle("fill", width -offset -1, 0, offset +1, height)
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.scale(scale/gameScale, scale/gameScale)
        love.graphics.translate((offset/(scale/2)), 0)

    end

    local box_x = 320 -(fake_bt.box.cur_width/2)
    local box_y = 320 -(fake_bt.box.cur_height/2)
    draw_box(box_x, box_y, fake_bt.box.cur_width, fake_bt.box.cur_height, fake_bt.box.border)

    font:setFont("8bit.ttf", 6)
    font:draw("HP ", 244, 405)
    font:setFont("mars.ttf", 12)
    font:draw(player.name, 30, 403)
    font:draw("LV " ..player.love, 132, 403)
    font:draw(player.hp.. " / " ..player.hpmax, 289 +player.hpmax *1.25, 403)

    love.graphics.setColor(255, 0, 0, 1)
	love.graphics.rectangle("fill", 275, 400, player.hpmax *1.25, 21)
    
    love.graphics.setColor(255, 255, 0, 1)
	love.graphics.rectangle("fill", 275, 400, player.hp *1.25, 21)
    love.graphics.setColor(255, 255, 255, 1)
    
    local button = {}
    button[1] = 'assets/sprites/ui/battle/spr_fightbt/spr_fightbt'
    button[2] = 'assets/sprites/ui/battle/spr_actbt/spr_actbt'
    button[3] = 'assets/sprites/ui/battle/spr_itembt/spr_itembt'
    button[4] = 'assets/sprites/ui/battle/spr_sparebt/spr_sparebt'

    for i = 1, #button do

        if 1 == i then
            button[i] = love.graphics.newImage(button[i] ..'_1.png')
        else
            button[i] = love.graphics.newImage(button[i] ..'_0.png')
        end

    end

    love.graphics.draw(button[1], 32, 432)
    love.graphics.draw(button[2], 185, 432)
    love.graphics.draw(button[3], 345, 432)
    love.graphics.draw(button[4], 500, 432)

    font:setFont("main.ttf", 16)

    for i = 1, #button do
        if 1 == i then
            sprite = love.graphics.newImage(fake_bt.soul.sprite)
            love.graphics.draw(sprite, fake_bt.soul.x, fake_bt.soul.y)
        end
    end

    fake_bt:displayMsg(fake_bt.ftext)

    --font:draw(fake_bt.enemy[1].stats.hp ..'/'..fake_bt.enemy[1].stats.maxhp, 320, 0)

end

function fake_bt:displayMsg(msg)
    if Plus.keyPress == 'x' then
        fake_bt.ft_pos = #msg
    end

    if fake_bt.ismain == false and Plus.keyPress == 'z' then
        if fake_bt.ft_pos >= #msg then
            if fake_bt.main.act.active == true and fake_bt.main.act.selecting_act == true then
                fake_bt.main.act.page = fake_bt.main.act.page +1
            end
            fake_bt.ft_pos = 0
        end
    end
    writer:create(msg, 52, 270, 535, fake_bt.ft_pos)
    fake_bt.ft_pos = fake_bt.ft_pos +0.5
    if fake_bt.ft_pos > #msg then
        fake_bt.ft_pos = #msg
    end
end

function fake_bt:set_box(width, height)
    width = defaultValue(width, fake_bt.box.width)
    height = defaultValue(height, fake_bt.box.height)
    fake_bt.box.width = width
    fake_bt.box.height = height
end

function fake_bt:start_waves()
    fake_bt.enemy_turn = true
    fake_bt.main_sel = -1

    fake_bt.main.fight.active = false
    fake_bt.main.fight.sel = 0
    fake_bt.main.fight.quick_event = false
    fake_bt.main.fight.bars = {}
    fake_bt.main.fight.hit_bars = {}
    fake_bt.main.fight.slash = false
    fake_bt.main.fight.damage = 0
    fake_bt.main.fight.damagetimer = 0
    fake_bt.main.fight.draw_slash = false

    fake_bt.slash_anim.frame = 0
    fake_bt.slash_anim.spritefile = 'assets/sprites/ui/battle/spr_strike/spr_strike'
    fake_bt.slash_anim.sprite = love.graphics.newImage(fake_bt.slash_anim.spritefile ..'_' ..fake_bt.slash_anim.frame ..'.png')

    fake_bt.main.act.active = false
    fake_bt.main.act.sel = 1
    fake_bt.main.act.selecting_act = false
    fake_bt.main.act.act_sel = 1
    fake_bt.main.act.acting = false
    fake_bt.main.act.page = 1

    fake_bt.main.item.active = false
    fake_bt.main.item.sel = 1
    fake_bt.main.item.using = false
    fake_bt.main.item.text = ""

    fake_bt.main.mercy.active = false
    fake_bt.main.mercy.sel = 1

    fake_bt:set_box(140, 140)
    fake_bt.soul.x = 311
    fake_bt.soul.y = 311        
    for e = 1, #fake_bt.enemy do
        fake_bt.enemy[e]:attacks()
        fake_bt.enemy[e].wave:create()
    end

end

function fake_bt:checkVictory()

    if #fake_bt.enemy == 0 then
        fake_bt.victory = true
        fake_bt.main_sel = -1

        fake_bt.main.fight.active = false
        fake_bt.main.fight.sel = 0
        fake_bt.main.fight.quick_event = false
        fake_bt.main.fight.bars = {}
        fake_bt.main.fight.hit_bars = {}
        fake_bt.main.fight.slash = false
        fake_bt.main.fight.damage = 0
        fake_bt.main.fight.damagetimer = 0
        fake_bt.main.fight.draw_slash = false
    
        fake_bt.slash_anim.frame = 0
        fake_bt.slash_anim.spritefile = 'assets/sprites/ui/battle/spr_strike/spr_strike'
        fake_bt.slash_anim.sprite = love.graphics.newImage(fake_bt.slash_anim.spritefile ..'_' ..fake_bt.slash_anim.frame ..'.png')

        fake_bt.main.act.active = false
        fake_bt.main.act.sel = 1
        fake_bt.main.act.selecting_act = false
        fake_bt.main.act.act_sel = 1
        fake_bt.main.act.acting = false
        fake_bt.main.act.page = 1

        fake_bt.main.item.active = false
        fake_bt.main.item.sel = 1
        fake_bt.main.item.using = false
        fake_bt.main.item.text = ""

        fake_bt.main.mercy.active = false
        fake_bt.main.mercy.sel = 1

        fake_bt:set_box(575, 140)
        fake_bt.ft_pos = 1

        local exp = 0
        local gold = 0
        for e, enemy in ipairs(fake_bt.spared_enemy) do
            gold = gold +enemy.stats.gold
        end
        
        for e, enemy in ipairs(fake_bt.dead_enemy) do
            gold = gold +enemy.stats.gold
            exp = exp +enemy.stats.xp
            area_killed[area] = area_killed[area] +1
        end

        player.gold = player.gold +gold
        player.exp = player.exp +exp
        fake_bt.ftext = '* YOU WON!^* You earned '.. exp ..' EXP and '.. gold ..' gold.'
        return true
    else
        return false
    end

end

function fake_bt:turn_length(time)
    if fake_bt.turn_time < time then
        fake_bt.turn_time = time
    end
end

fake_bt.excluded_vars = {'enemy', 'spared_enemy', 'dead_enemy', 'main', 'main_sel', 'ismain', 'ftext'}
return fake_bt