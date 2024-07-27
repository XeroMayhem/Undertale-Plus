local input = require 'engine/scripts/input'
local font = require 'engine/scripts/font'
local writer = require 'engine.scripts.text_writer'
enemy_scripts = require 'engine.scripts.enemy'

bt = {}
bt.soul = {x = 40, y = 446, sprite = 'assets/sprites/ui/battle/spr_soul.png', script = 'engine.scripts.soul'}
bt.enemy = {}
bt.spared_enemy = {}
bt.dead_enemy = {}

bt.box = {}
bt.box.border = 5
bt.box.width = 575
bt.box.height = 140
bt.box.cur_width = 0
bt.box.cur_height = 140
bt.song = love.audio.newSource('assets/sounds/enemy_approaching.ogg', "stream")
bt.song:setLooping(true)
bt.song:play()

bt.ftext = ""
bt.ft_pos = 0


bt.main_sel = 1
bt.main = {
    fight = {
        active = false,
        sel = 1
    },
    act = {
        active = false,
        sel = 1,
        selecting_act = false,
        act_sel = 1,
        acting = false,
        page = 1
    },
    item = {
        active = false,
        sel = 1,
        using = false,
        text = ""
    },
    mercy = {
        active = false,
        sel = 1,
        options = {"* Spare", "* Flee"}
    }
}

bt.ismain = true
bt.victory = false
bt.enemy_turn = false
bt.turn = 1
bt.turn_timer = 0
bt.turn_time = 3
bt.player_dead = false

require('engine.scripts.encounters')()

function bt.update(dt)

    if bt.main.fight.active == false and bt.main.act.active == false
    and bt.main.item.active == false and bt.main.mercy.active == false 
    and bt.enemy_turn == false then
        bt.ismain = true
    else
        bt.ismain = false
    end
    
    if bt.ismain == true then

        if Plus.keyPress == 'right' then
            bt.main_sel = bt.main_sel +1
        end

        if Plus.keyPress == 'left' then
            bt.main_sel = bt.main_sel -1
        end

        if Plus.keyPress == 'z' then
            if bt.victory == true then
                bt = {}
                Plus:loadState('game')
                playerFree = true
                return
            else
                if bt.main_sel == 1 then
                    bt.main.fight.active = true
                elseif bt.main_sel == 2 then
                    bt.main.act.active = true
                elseif bt.main_sel == 3 then
                    bt.main.item.active = true
                elseif bt.main_sel == 4 then
                    bt.main.mercy.active = true
                end
                bt.ismain = false
                bt.ft_pos = 0
            end
        end

        bt.main_sel = math.max(bt.main_sel, 1)
        bt.main_sel = math.min(bt.main_sel, 4)

        if bt.main_sel == 1 then
            bt.soul.x = 40
        elseif bt.main_sel == 2 then
            bt.soul.x = 194
        elseif bt.main_sel == 3 then
            bt.soul.x = 353
        elseif bt.main_sel == 4 then
            bt.soul.x = 508
        end

    elseif bt.main.fight.active == true then
        
        if Plus.keyPress == 'x' then
            bt.main.fight.active = false
        end

        if Plus.keyPress == 'z' then
            
        end

        if Plus.keyPress == 'down' then
            bt.main.fight.sel = bt.main.fight.sel +1
        end

        if Plus.keyPress == 'up' then
            bt.main.fight.sel = bt.main.fight.sel -1
        end

        
        bt.main.fight.sel = math.max(bt.main.fight.sel, 1)
        bt.main.fight.sel = math.min(bt.main.fight.sel, #bt.enemy)

    elseif bt.main.act.active == true then

        if bt.main.act.selecting_act == false then
        
            if Plus.keyPress == 'x' then
                bt.main.act.active = false
            end

            if Plus.keyPress == 'z' then
                bt.main.act.selecting_act = true
            end

            if Plus.keyPress == 'down' then
                bt.main.act.sel = bt.main.act.sel +1
            end

            if Plus.keyPress == 'up' then
                bt.main.act.sel = bt.main.act.sel -1
            end
            
            bt.main.act.sel = math.max(bt.main.act.sel, 1)
            bt.main.act.sel = math.min(bt.main.act.sel, #bt.enemy)
        elseif bt.main.act.acting == false then

            if Plus.keyPress == 'x' then
                bt.main.act.selecting_act = false
            end

            if Plus.keyPress == 'z' then
                bt.main.act.acting = true
            end

            if Plus.keyPress == 'up' then
                if 0 < bt.main.act.act_sel -2 then
                    bt.main.act.act_sel = bt.main.act.act_sel -2
                end
            end

            if Plus.keyPress == 'down' then
                if #bt.enemy[bt.main.act.sel].acts >= bt.main.act.act_sel +2 then
                    bt.main.act.act_sel = bt.main.act.act_sel +2
                end
            end

            if Plus.keyPress == 'left' then
                if bt.main.act.act_sel == 1 then
                    bt.main.act.act_sel = 2
                elseif bt.main.act.act_sel == 2 then
                    bt.main.act.act_sel = 1
                elseif bt.main.act.act_sel == 3 then
                    bt.main.act.act_sel = 4
                elseif bt.main.act.act_sel == 4 then
                    bt.main.act.act_sel = 3
                elseif bt.main.act.act_sel == 5 then
                    bt.main.act.act_sel = 6
                elseif bt.main.act.act_sel == 6 then
                    bt.main.act.act_sel = 5
                end
            end

            if Plus.keyPress == 'right' then
                if bt.main.act.act_sel == 1 then
                    bt.main.act.act_sel = 2
                elseif bt.main.act.act_sel == 2 then
                    bt.main.act.act_sel = 1
                elseif bt.main.act.act_sel == 3 then
                    bt.main.act.act_sel = 4
                elseif bt.main.act.act_sel == 4 then
                    bt.main.act.act_sel = 3
                elseif bt.main.act.act_sel == 5 then
                    bt.main.act.act_sel = 6
                elseif bt.main.act.act_sel == 6 then
                    bt.main.act.act_sel = 5
                end
            end

            
            bt.main.act.act_sel = math.max(bt.main.act.act_sel, 1)
            bt.main.act.act_sel = math.min(bt.main.act.act_sel, #bt.enemy[bt.main.act.sel].acts)
        end

    elseif bt.main.item.active == true then
        
        if bt.main.item.using == false then

            if Plus.keyPress == 'x' then
                bt.main.item.active = false
            end

            if Plus.keyPress == 'z' then
                bt.main.item.using = true
                bt.main.item.text = inventory:useItem(bt.main.item.sel)
            end

            if Plus.keyPress == 'up' then
                if bt.main.item.sel == 1 then
                    bt.main.item.sel = 3
                elseif bt.main.item.sel == 2 then
                    if #inventory.items > 3 then
                        bt.main.item.sel = 4
                    end
                elseif bt.main.item.sel == 3 then
                    bt.main.item.sel = 1
                elseif bt.main.item.sel == 4 then
                    bt.main.item.sel = 2
                elseif #inventory.items > 6 then
                    if bt.main.item.sel == 5 then
                        bt.main.item.sel = 7
                    elseif bt.main.item.sel == 6 then
                        if #inventory.items > 7 then
                            bt.main.item.sel = 8
                        end
                    elseif bt.main.item.sel == 7 then
                        bt.main.item.sel = 5
                    elseif bt.main.item.sel == 8 then
                        bt.main.item.sel = 6
                    end
                end
            end

            if Plus.keyPress == 'down' then
                if bt.main.item.sel == 1 then
                    bt.main.item.sel = 3
                elseif bt.main.item.sel == 2 then
                    if #inventory.items > 3 then
                        bt.main.item.sel = 4
                    end
                elseif bt.main.item.sel == 3 then
                    bt.main.item.sel = 1
                elseif bt.main.item.sel == 4 then
                    bt.main.item.sel = 2
                elseif #inventory.items > 6 then
                    if bt.main.item.sel == 5 then
                        bt.main.item.sel = 7
                    elseif bt.main.item.sel == 6 then
                        if #inventory.items > 7 then
                            bt.main.item.sel = 8
                        end
                    elseif bt.main.item.sel == 7 then
                        bt.main.item.sel = 5
                    elseif bt.main.item.sel == 8 then
                        bt.main.item.sel = 6
                    end
                end
            end

            if Plus.keyPress == 'left' then
                if bt.main.item.sel == 1 then
                    if #inventory.items > 4 then
                        bt.main.item.sel = 6
                    else
                        bt.main.item.sel = 2
                    end
                elseif bt.main.item.sel == 2 then
                    bt.main.item.sel = 1
                elseif bt.main.item.sel == 3 then
                    if #inventory.items > 6 then
                        bt.main.item.sel = 8
                    else
                        bt.main.item.sel = 4
                    end
                elseif bt.main.item.sel == 4 then
                    bt.main.item.sel = 3

                elseif bt.main.item.sel == 5 then
                    bt.main.item.sel = 2
                elseif bt.main.item.sel == 6 then
                    bt.main.item.sel = 5
                elseif bt.main.item.sel == 7 then
                    bt.main.item.sel = 4
                elseif bt.main.item.sel == 8 then
                    bt.main.item.sel = 7
                end
            end

            if Plus.keyPress == 'right' then
                if bt.main.item.sel == 1 then
                    bt.main.item.sel = 2
                elseif bt.main.item.sel == 2 then
                    if #inventory.items > 4 then
                        bt.main.item.sel = 5
                    else
                        bt.main.item.sel = 1
                    end
                elseif bt.main.item.sel == 3 then
                    bt.main.item.sel = 4
                elseif bt.main.item.sel == 4 then
                    if #inventory.items < 7 then
                        bt.main.item.sel = 3
                    else
                        bt.main.item.sel = 7
                    end

                elseif bt.main.item.sel == 5 then
                    bt.main.item.sel = 6
                elseif bt.main.item.sel == 6 then
                    bt.main.item.sel = 1
                elseif bt.main.item.sel == 7 then
                    if #inventory.items < 8 then
                        bt.main.item.sel = 3
                    else
                        bt.main.item.sel = 8
                    end
                elseif bt.main.item.sel == 8 then
                    bt.main.item.sel = 3
                end
            end
            
            bt.main.item.sel = math.max(bt.main.item.sel, 1)
            bt.main.item.sel = math.min(bt.main.item.sel, #inventory.items)

        else
            if Plus.keyPress == 'x' then
                bt.ft_pos = #bt.main.item.text
            end

            if Plus.keyPress == 'z' then
                if bt.ft_pos >= #bt.main.item.text then
                    bt.ft_pos = 0
                    bt:start_waves()
                end
            end
        end

    elseif bt.main.mercy.active == true then
        
        if Plus.keyPress == 'x' then
            bt.main.mercy.active = false
        end

        if Plus.keyPress == 'z' then
            if bt.main.mercy.options[bt.main.mercy.sel] == "* Spare" then
                local play_sound = false
                local spares = {}
                local e_off = 0
                for e = 1, #bt.enemy do
                    if bt.enemy[e].spare == true then
                        play_sound = true
                        bt.enemy[e].been_spared = true
                        for w = 0, bt.enemy[e].sprite:getWidth() -1 do
                            bt.enemy[e].pixel_data[w] = {}
                            for h = 0, bt.enemy[e].sprite:getHeight() -1 do
                        
                                bt.enemy[e].pixel_data[w][h] = {col = bt.enemy[e].sprite_data:getPixel(w, h), x = w, y = h, a = 0.5}
                                
                            end
                        end
                        local my_off = e_off
                        table.insert(spares, function ()
                            table.insert(bt.spared_enemy, bt.enemy[e +my_off])
                            table.remove(bt.enemy, e +my_off)
                        end)
                        e_off = e_off -1
                    end
                    if play_sound == true then
                        love.audio.newSource('assets/sounds/snd_vaporized.wav', "static"):play()
                    end
                end
                for s, func in ipairs(spares) do
                    func()
                end
                if bt:checkVictory() == false then
                    bt:start_waves()
                end
            end
        end

        if Plus.keyPress == 'down' then
            bt.main.mercy.sel = bt.main.mercy.sel +1
        end

        if Plus.keyPress == 'up' then
            bt.main.mercy.sel = bt.main.mercy.sel -1
        end

        
        bt.main.mercy.sel = math.max(bt.main.mercy.sel, 1)
        bt.main.mercy.sel = math.min(bt.main.mercy.sel, #bt.main.mercy.options)
    
    elseif bt.enemy_turn == true then
        if bt.player_dead == false then
            local soul_script = require(bt.soul.script)
            soul_script:update(bt.soul)
            bt.turn_timer = bt.turn_timer +1
            for e = 1, #bt.enemy do
                if bt.enemy_turn == true then
                    for b = 1, #bt.enemy[e].bullets do
                    if bt.enemy[e].bullets[b].destroyed == false then
                            bt.enemy[e].bullets[b]:update(dt)
                            if bt.enemy[e].bullets[b] ~= nil then
                                bt.enemy[e].bullets[b]:check_hit()
                            end
                        end
                    end
                end
                bt.enemy[e].wave:update(dt)
            end
            if bt.turn_timer >= bt.turn_time * 60 then
                for e = 1, #bt.enemy do
                    bt.enemy[e].bullets = {}
                end
                bt.enemy_turn = false
                bt.turn_timer = 0
                bt:set_box(575, 140)
                bt.soul.x = 40
                bt.soul.y = 446
                bt.main_sel = 1
                bt.turn = bt.turn +1
            end
        end
    end
    
    if bt.box.cur_width < bt.box.width then
        bt.box.cur_width = bt.box.cur_width +((bt.box.width- bt.box.cur_width) /2);
    end
    if bt.box.cur_width > bt.box.width then
        bt.box.cur_width = bt.box.cur_width -((bt.box.cur_width- bt.box.width) /2);
    end

    if bt.box.cur_height < bt.box.height then
        bt.box.cur_height = bt.box.cur_height +((bt.box.height- bt.box.cur_height) /2);
    end
    if bt.box.cur_height > bt.box.height then
        bt.box.cur_height = bt.box.cur_height -((bt.box.cur_height- bt.box.height) /2);
    end

    if bt.player_dead == false then
        for e = 1, #bt.enemy do
            bt.enemy[e]:update(dt)
        end
    end

    if player.hp <= 0 then
        bt.player_dead = true
    end

end

function bt.draw()

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

    draw_box(320 -(bt.box.cur_width/2), 320 -(bt.box.cur_height/2), bt.box.cur_width, bt.box.cur_height, bt.box.border)

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

        if bt.main_sel == i then
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

    if bt.ismain == true then
        for i = 1, #button do
            if bt.main_sel == i then
                sprite = love.graphics.newImage(bt.soul.sprite)
                love.graphics.draw(sprite, bt.soul.x, bt.soul.y)
            end
        end

        bt:displayMsg(bt.ftext)
    end

    if bt.main.fight.active == true then
        for e = 1, #bt.enemy do
            if bt.enemy[e].spare == true then love.graphics.setColor(255, 255, 0, 1) end
            font:draw("* "..bt.enemy[e].name, 52 +48, 270 +((e -1) *32))
            love.graphics.setColor(255, 255, 255, 1)
            if bt.main.fight.sel == e then
                sprite = love.graphics.newImage(bt.soul.sprite)
                love.graphics.draw(sprite, 52 +24-9, 277 +((e -1) *32))
            end
        end
    elseif bt.main.act.active == true then
        if bt.main.act.selecting_act == false then
            for e = 1, #bt.enemy do
                if bt.enemy[e].spare == true then love.graphics.setColor(255, 255, 0, 1) end
                font:draw("* "..bt.enemy[e].name, 52 +48, 270 +((e -1) *32))
                love.graphics.setColor(255, 255, 255, 1)
                if bt.main.act.sel == e then
                    sprite = love.graphics.newImage(bt.soul.sprite)
                    love.graphics.draw(sprite, 52 +24-9, 277 +((e -1) *32))
                end
            end
        elseif bt.main.act.acting == false then
            for a = 1, #bt.enemy[bt.main.act.sel].acts do
                --[[
                font:draw("* "..bt.enemy[bt.main.act.sel].acts[a], 52 +48, 270 +((a -1) *32))
                if bt.main.act.act_sel == a then
                    sprite = love.graphics.newImage(bt.soul.sprite)
                    love.graphics.draw(sprite, 52 +24-9, 277 +((a -1) *32))
                end
                ]]
                local y = a
                local offset = 0
                y = math.ceil(a/2)
                if a == 2 or a == 4 then
                    offset = 280
                end
                font:draw("* "..bt.enemy[bt.main.act.sel].acts[a], 52 +48 +offset, 270 +((y -1) *32))
                if bt.main.act.act_sel == a then
                    sprite = love.graphics.newImage(bt.soul.sprite)
                    love.graphics.draw(sprite, 52 +24-9 +offset, 277 +((y -1) *32))
                end
            end
        else
            bt.enemy[bt.main.act.sel]:act(bt.enemy[bt.main.act.sel].acts[bt.main.act.act_sel])
        end
    elseif bt.main.item.active == true then
        if bt.main.item.using == false then
            if bt.main.item.sel < 5 then
                for i = 1, math.min(4, #inventory.items) do
                    local y = i
                    local offset = 0
                    y = math.ceil(i/2)
                    if i == 2 or i == 4 then
                        offset = 280
                    end
                    font:draw(inventory.items[i].btname, 52 +48 +offset, 270 +((y -1) *32))
                    if bt.main.item.sel == i then
                        sprite = love.graphics.newImage(bt.soul.sprite)
                        love.graphics.draw(sprite, 52 +24-9 +offset, 277 +((y -1) *32))
                    end
                end
            else
                for i = 1, math.min(4, #inventory.items -4) do
                    i = i +4
                    local y = i -4
                    local offset = 0
                    y = math.ceil((i -4)/2)
                    if i == 6 or i == 8 then
                        offset = 280
                    end
                    font:draw(inventory.items[i].btname, 52 +48 +offset, 270 +((y -1) *32))
                    if bt.main.item.sel == i then
                        sprite = love.graphics.newImage(bt.soul.sprite)
                        love.graphics.draw(sprite, 52 +24-9 +offset, 277 +((y -1) *32))
                    end
                end
            end
        else
            bt:displayMsg(bt.main.item.text)
        end
    elseif bt.main.mercy.active == true then
        for m = 1, #bt.main.mercy.options do
            if bt.main.mercy.options[m] == "* Spare" then
                for e = 1, #bt.enemy do
                    if bt.enemy[e].spare == true then love.graphics.setColor(255, 255, 0, 1) end
                end
            end
            font:draw(bt.main.mercy.options[m], 52 +48, 270 +((m -1) *32))
            love.graphics.setColor(255, 255, 255, 1)
            if bt.main.mercy.sel == m then
                sprite = love.graphics.newImage(bt.soul.sprite)
                love.graphics.draw(sprite, 52 +24-9, 277 +((m -1) *32))
            end
        end
    end

    for e = 1, #bt.enemy do
        bt.enemy[e]:draw()
        if bt.enemy_turn == true then
            for b = 1, #bt.enemy[e].bullets do
                if bt.enemy[e].bullets[b] ~= nil then
                    bt.enemy[e].bullets[b]:draw()
                end
            end
        end
        --[[
        font:draw(bt.enemy[e].name ..' HP: ' ..bt.enemy[e].stats.hp ..' AT: ' ..bt.enemy[e].stats.at 
        ..' DF: ' ..bt.enemy[e].stats.df  ..' XP: ' ..bt.enemy[e].stats.xp  ..' Gold: ' ..bt.enemy[e].stats.gold
        , 10, 380 +(32 *(e -1)))
        ]]
    end
    for e = 1, #bt.spared_enemy do
        bt.spared_enemy[e]:draw()
    end

    if bt.player_dead == true then
        local soul_script = require(bt.soul.script)
        soul_script:death(bt.soul)
    end

    if bt.enemy_turn == true then
        love.graphics.draw(love.graphics.newImage(bt.soul.sprite), bt.soul.x, bt.soul.y)
    end

    if love.window.getFullscreen() == true then

        local width, height = love.window.getDesktopDimensions()
        local scale = math.min(width/320, height/240)
        local offset = (width -(320 *scale))/2
        love.graphics.translate(-offset, 0)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 0, 0, offset +1, height)
        love.graphics.rectangle("fill", (offset -1) +(320 *scale)/(scale/2), 0, offset +1, height)
        love.graphics.setColor(1, 1, 1, 1)

    end

end

function bt:displayMsg(msg)
    if Plus.keyPress == 'x' then
        bt.ft_pos = #msg
    end

    if bt.ismain == false and Plus.keyPress == 'z' then
        if bt.ft_pos >= #msg then
            if bt.main.act.active == true and bt.main.act.selecting_act == true then
                bt.main.act.page = bt.main.act.page +1
            end
            bt.ft_pos = 0
        end
    end
    writer:create(msg, 52, 270, 535, bt.ft_pos)
    bt.ft_pos = bt.ft_pos +0.5
    if bt.ft_pos > #msg then
        bt.ft_pos = #msg
    end
end

function bt:set_box(width, height)
    width = defaultValue(width, bt.box.width)
    height = defaultValue(height, bt.box.height)
    bt.box.width = width
    bt.box.height = height
end

function bt:start_waves()
    bt.enemy_turn = true
    bt.main_sel = -1

    bt.main.fight.active = false
    bt.main.fight.sel = 0

    bt.main.act.active = false
    bt.main.act.sel = 1
    bt.main.act.selecting_act = false
    bt.main.act.act_sel = 1
    bt.main.act.acting = false
    bt.main.act.page = 1

    bt.main.item.active = false
    bt.main.item.sel = 1
    bt.main.item.using = false
    bt.main.item.text = ""

    bt.main.mercy.active = false
    bt.main.mercy.sel = 1

    bt:set_box(140, 140)
    bt.soul.x = 311
    bt.soul.y = 311        
    for e = 1, #bt.enemy do
        bt.enemy[e]:attacks()
        bt.enemy[e].wave:create()
    end

end

function bt:checkVictory()

    if #bt.enemy == 0 then
        bt.victory = true
        bt.main_sel = -1

        bt.main.fight.active = false
        bt.main.fight.sel = 0

        bt.main.act.active = false
        bt.main.act.sel = 1
        bt.main.act.selecting_act = false
        bt.main.act.act_sel = 1
        bt.main.act.acting = false
        bt.main.act.page = 1

        bt.main.item.active = false
        bt.main.item.sel = 1
        bt.main.item.using = false
        bt.main.item.text = ""

        bt.main.mercy.active = false
        bt.main.mercy.sel = 1

        bt:set_box(575, 140)
        bt.ft_pos = 1

        local exp = 0
        local gold = 0
        for e, enemy in ipairs(bt.spared_enemy) do
            gold = gold +enemy.stats.gold
        end
        
        for e, enemy in ipairs(bt.dead_enemy) do
            gold = gold +enemy.stats.gold
            exp = exp +enemy.stats.xp
        end

        player.gold = player.gold +gold
        player.exp = player.exp +exp
        bt.ftext = '* YOU WON!^* You earned '.. exp ..' EXP and '.. gold ..' gold.'
        return true
    else
        return false
    end

end

function bt:turn_length(time)
    if bt.turn_time < time then
        bt.turn_time = time
    end
end

bt.excluded_vars = {'enemy', 'spared_enemy', 'dead_enemy', 'main', 'main_sel', 'ismain', 'ftext'}
return bt