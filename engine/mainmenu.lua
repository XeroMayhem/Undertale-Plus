local input = require 'engine/scripts/input'
local font = require 'engine/scripts/font'

local menu = {}
menu.part = 1
menu.sel = 1

menu.name = ""
menu.charmap = {}
menu.xmap = {}
menu.ymap = {}
menu.rows = 8
menu.cols = 7
menu.sel_row = 1
menu.sel_col = 1
menu.choose_name = 1
menu.fade = 0

local utf8 = require("utf8")
for i = 1, menu.cols do
    menu.xmap[i] = (60 + (i * 64))
end
for i = 1, menu.rows / 2 do
    menu.charmap[i] = {}
    menu.charmap[i +(menu.rows/2)] = {}

    menu.ymap[i] = 150 + (i * 24)
    menu.ymap[i +(menu.rows / 2)] = 270 + (i * 24)
    for j = 1, menu.cols do

        local index = (i * 7) + j
        if index < 34 then
            menu.charmap[i][j] = utf8.char(57 + index)
            menu.charmap[i +(menu.rows/2)][j] = utf8.char(89 + index)
        else
            menu.charmap[i][j] = ""
            menu.charmap[i +(menu.rows/2)][j] = ""
        end

    end
end

menu.song = love.audio.newSource('assets/sounds/mus_menu0.ogg', "stream")
local intronoise = love.audio.newSource('assets/sounds/mus_intronoise.ogg', "static")

local timer = 0
local q = 0
love.window.setTitle(mod_data.name)

function menu.update(dt)

end

function menu.draw()
    
    if menu.part == 1 then

        if timer == 0 then
            intronoise:play()
        end

        local title = love.graphics.newImage('assets/sprites/misc/title.png')
        if love.filesystem.getInfo(mod_loaded ..'assets/sprites/misc/title.png') then
            title = love.graphics.newImage(mod_loaded ..'assets/sprites/misc/title.png')
        end
        love.graphics.draw(title, 0, 0)
        timer = timer +1
        if timer > 200 then
            timer = 0
            menu.part = 1.5
        end

        if Plus.keyPress == 'z' and timer > 1 then
            intronoise:stop()
            menu.song:setLooping(true)
            menu.song:play()
            if love.filesystem.getInfo("saves/" ..Plus.loaded_mod ..".json") then
                menu.part = 6
            else
                menu.part = 2
            end
        end

    elseif menu.part == 1.5 then
        local title = love.graphics.newImage('assets/sprites/misc/title.png')
        if love.filesystem.getInfo(mod_loaded ..'assets/sprites/misc/title.png') then
            title = love.graphics.newImage(mod_loaded ..'assets/sprites/misc/title.png')
        end
        love.graphics.draw(title, 0, 0)

        font:setFont('small.ttf', 6)
        font:draw_centred({{255, 255, 255, 0.5}, '[PRESS Z OR ENTER]'}, 320, 360)

        if Plus.keyPress == 'z' then
            menu.song:setLooping(true)
            menu.song:play()
            if love.filesystem.getInfo("saves/" ..Plus.loaded_mod ..".json") then
                menu.part = 6
            else
                menu.part = 2
            end
        end

    elseif menu.part == 2 then

        love.graphics.setColor(255, 255, 255, 0.75)

        font:setFont('main.ttf', 16)
        font:draw(" --- Instruction ---", 170, 40)
        font:draw("[Z or ENTER] Confirm", 170, 100)
        font:draw("[X or SHIFT] Cancel", 170, 140)
        font:draw("[C or CTRL] Menu (In-game)", 170, 180)
        font:draw("[F4] Fullscreen", 170, 220)
        font:draw("[Hold ESC] Quit", 170, 260)
        font:draw("When HP is 0, you lose.", 170, 300)
        
        font:setFont('small.ttf', 6)
        font:draw_centred({{255, 255, 255, 0.5}, mod_data.creator_tag}, 320, 464)

        love.graphics.setColor(255, 255, 255, 1)

        if Plus.keyPress == 'z' then
            menu.part = 3
        end
    
    elseif menu.part == 3 then

        if Plus.keyPress == 'down' then
            menu.sel_row = menu.sel_row +1
            if menu.sel_row > menu.rows +1 then
                menu.sel_row = 1
            end
        end

        if Plus.keyPress == 'up' then
            menu.sel_row = menu.sel_row -1
            if menu.sel_row < 1 then
                menu.sel_row = menu.rows +1
            end
        end

        if Plus.keyPress == 'right' then
            if menu.sel_row < menu.rows +1 then
                menu.sel_col = menu.sel_col +1
                if menu.sel_col > menu.cols or menu.charmap[menu.sel_row][menu.sel_col] == "" then
                    menu.sel_col = 1
                    menu.sel_row = menu.sel_row +1
                end
            else
                if menu.sel_col < 3 then
                    menu.sel_col = 3
                elseif menu.sel_col < 6 then
                    menu.sel_col = 6
                elseif menu.sel_col < 8 then 
                    menu.sel_col = 1
                end
            end
        end

        if Plus.keyPress == 'left' then
            if menu.sel_row < menu.rows +1 then
                menu.sel_col = menu.sel_col -1
                if menu.sel_col < 1 and menu.sel_row == 1 then
                    menu.sel_col = 1
                end
                if menu.sel_col < 1 then
                    menu.sel_col = menu.cols
                    menu.sel_row = menu.sel_row -1
                end
            else
                if menu.sel_col < 3 then
                    menu.sel_col = 6
                elseif menu.sel_col < 6 then
                    menu.sel_col = 2
                elseif menu.sel_col < 8 then 
                    menu.sel_col = 3
                end
            end
        end

        if Plus.keyPress == 'z' then
            if menu.sel_row < menu.rows +1 then
                if #menu.name < 6 then
                    menu.name = menu.name ..menu.charmap[menu.sel_row][menu.sel_col]
                else
                    menu.name = menu.name:sub(1, #menu.name -1)
                    menu.name = menu.name ..menu.charmap[menu.sel_row][menu.sel_col]
                end
            else
                if menu.sel_col < 3 then
                    menu.part = 2
                elseif menu.sel_col < 6 then
                    menu.name = menu.name:sub(1, #menu.name -1)
                elseif menu.sel_col < 8 and menu.name ~= "" then
                    menu.part = 4
                end
            end
        end

        if Plus.keyPress == 'x' then
            menu.name = menu.name:sub(1, #menu.name -1)
        end

        font:setFont('main.ttf', 16)
        --font:draw_centred("Be Right Back", 320, 240)
        font:draw_centred("Name the fallen human.", 320, 60)
        font:draw(menu.name, 280, 110)
        for row = 1, menu.rows do
            local yy = menu.ymap[row]
            for col = 1, menu.cols do
                local xx = menu.xmap[col] +math.random()

                if menu.sel_row == row and menu.sel_col == col then love.graphics.setColor(255, 255, 0, 1) end
                font:draw(menu.charmap[row][col], xx, (yy + math.random()))
                love.graphics.setColor(255, 255, 255, 1)
            end
        end

        font:draw("Quit", 120, 400)
        font:draw("Backspace", 240, 400)
        font:draw("Done", 440, 400)
        if menu.sel_row == menu.rows +1 then
            if menu.sel_col < 3 then love.graphics.setColor(255, 255, 0, 1)
                font:draw("Quit", 120, 400)
            elseif menu.sel_col < 6 then love.graphics.setColor(255, 255, 0, 1)
                font:draw("Backspace", 240, 400)
            elseif menu.sel_col < 8 then love.graphics.setColor(255, 255, 0, 1)
                font:draw("Done", 440, 400)
            end
            love.graphics.setColor(255, 255, 255, 1)
        end
    elseif menu.part == 4 then

        font:setFont('main.ttf', 16)
        --font:draw_centred("Be Right Back", 320, 240)
        font:draw_centred("Is this name correct?", 320, 60)
        --font:draw(menu.name, 280, 110)

        if Plus.keyPress == 'right' then
            menu.choose_name = menu.choose_name +1
            if menu.choose_name > 2 then
                menu.choose_name = 1
            end
        end

        if Plus.keyPress == 'left' then
            menu.choose_name = menu.choose_name -1
            if menu.choose_name < 1 then
                menu.choose_name = 2
            end
        end

        if Plus.keyPress == 'z' then
            if menu.choose_name == 1 then
                menu.part = 3
                q = 0
            elseif menu.choose_name == 2 then
                charname = menu.name
                menu.song:stop()
                love.audio.newSource('assets/sounds/mus_cymbal.ogg', "static"):play()
                menu.part = 5
            end
        end
        
        if q < 240 then
            q = q +1
        end
        local xx = (280 - (q / 2))
        love.graphics.print(menu.name, (xx +math.random()), (((q / 2) + 110) + math.random()), math.rad(math.random(((-0.01) * q) / 60, (0.5 * q) / 60)), (1 + (q / 50))/1.5, (1 + (q / 50))/1.5)
        
        if menu.choose_name == 1 then love.graphics.setColor(255, 255, 0, 1) end
        font:draw_centred("No", 160, 400)
        love.graphics.setColor(255, 255, 255, 1)

        if menu.choose_name == 2 then love.graphics.setColor(255, 255, 0, 1) end
        font:draw_centred("Yes", 480, 400)
        love.graphics.setColor(255, 255, 255, 1)
    
    elseif menu.part == 5 then

        if q < 240 then
            q = q +1
        end
        local xx = (280 - (q / 2))
        love.graphics.print(menu.name, (xx +math.random()), (((q / 2) + 110) + math.random()), math.rad(math.random(((-0.01) * q) / 60, (0.5 * q) / 60)), (1 + (q / 50))/1.5, (1 + (q / 50))/1.5)

        menu.fade = menu.fade +0.003

        love.graphics.setColor(255, 255, 255, menu.fade)
        love.graphics.rectangle("fill", 0, 0, 640, 480)

        if menu.fade >= 1 then
            Plus:loadState('game')
        end

    elseif menu.part == 6 then

        local menu_bg = love.graphics.newImage('assets/sprites/misc/main_menu.png')
        if love.filesystem.getInfo(mod_loaded ..'assets/sprites/misc/main_menu.png') then
            menu_bg = love.graphics.newImage(mod_loaded ..'assets/sprites/misc/main_menu.png')
        end
        love.graphics.draw(menu_bg, 0, 0, 0, 2, 2)
        
        font:setFont('small.ttf', 5)
        font:draw_centred({{255, 255, 255, 0.5}, mod_data.creator_tag}, 320, 464)

        
        font:setFont('main.ttf', 16)
        
        local json = require 'engine.libraries.json'
        local save_data = json.decode(love.filesystem.read("saves/" ..Plus.loaded_mod ..".json"))

        font:draw(save_data.name, 140, 124)
        font:draw_centred("LV " ..save_data.love, 320, 124)

        local minutes = math.floor(save_data.time / 1800)
        local seconds = math.floor(((save_data.time / 1800) - minutes) * 60)
        if seconds == 60 then
            seconds = 0
        end
        local time = minutes ..':'.. seconds
        if seconds < 10  then
            time = minutes ..':0'.. seconds
        end
        font:draw(time, 500-love.graphics.getFont():getWidth(time), 124)

        local room_name = require (mod_loaded ..'scripts/world/rooms')
        font:draw(room_name:getName(save_data.room), 140, 160)--"Waterfall - Trash Zone"

        if menu.sel == 1 then love.graphics.setColor(255, 255, 0, 1) end
        font:draw("Continue", 140, 210)
        love.graphics.setColor(255, 255, 255, 1)

        if menu.sel == 2 then love.graphics.setColor(255, 255, 0, 1) end
        font:draw("Reset", 390, 210)
        love.graphics.setColor(255, 255, 255, 1)

        if menu.sel == 3 then love.graphics.setColor(255, 255, 0, 1) end
        font:draw_centred("Settings", 320, 250)
        love.graphics.setColor(255, 255, 255, 1)

        if menu.sel < 3 then
            if Plus.keyPress == 'right' or Plus.keyPress == 'left' then
                if menu.sel == 2 then
                    menu.sel = 1
                else
                    menu.sel = 2
                end
            elseif Plus.keyPress == 'down' then
                menu.sel = 3
            end
        end
        
        if menu.sel == 3 then
            if Plus.keyPress == 'up' then
                menu.sel = 1
            end
        end

        if Plus.keyPress == 'z' then
            if menu.sel == 1 then
                menu.song:stop()
                Plus:loadState('game')
            end
        end

    end

end

menu.excluded_vars = {"part", "name"}
return menu