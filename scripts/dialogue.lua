local dialogue = {}

function dialogue:init()
    dialogue.isActive = false
    dialogue.boxWidth = 289
    dialogue.boxHeight = 76
    dialogue.border = 12 *gameScale
    dialogue.sep = 16 *gameScale
    dialogue.lineWidth = (dialogue.boxWidth *gameScale) - (dialogue.border *2)
    dialogue.draw_char = 0
    dialogue.text_spd = 0.5
    --Chageable
    dialogue.page = 1
    dialogue.pageNum = 1
    dialogue.text =  {"* You aint supposed to see this"}
    dialogue.text_length =  {dialogue.page}
    --functions
    input:keypress('x', function()
        if dialogue.isActive then
            dialogue.draw_char = dialogue.text_length[dialogue.page]
        end
    end)
    input:keypress('z', function()
        if dialogue.isActive then
            if dialogue.draw_char >= dialogue.text_length[dialogue.page] then
                if dialogue.page +1 < dialogue.pageNum +1 then        
                    dialogue.page = dialogue.page +1
                    dialogue.draw_char = 0
                else
                    dialogue.page = dialogue.page +1
                    dialogue.draw_char = 0
                    dialogue:destroy()
                end
            end
        end
    end)

end

function dialogue:create()
    playerFree = false
    dialogue.isActive = true
    dialogue.text = {}--{"* This is the 1st page!", "* This is the 2nd page!", "* This is the 3rd page!^* LINE BREAK LETS GO!!!!!!!"}
    dialogue.pos = {}
    dialogue.portrait = {}
    dialogue.sound = {}
    dialogue.soundCount = 0
    dialogue.soundOffset = 5
    dialogue.page = 1
    dialogue.pageNum = 0
    dialogue.boxX = camx +(16 *gameScale)
    dialogue.boxY = camy +(5 *gameScale)
    dialogue.offY = 0
    dialogue.offX = 0
    dialogue.setup = false
    dialogue.char = {}
end

function dialogue:pageParams(text, sound, portrait, pos)
   table.insert(dialogue.text, text)

   if sound == nil then
        sound = 'snd_text.wav'
    end
   table.insert(dialogue.sound, sound)
   
   table.insert(dialogue.portrait, portrait)
   
   if pos == nil then
        pos = 0
        if player.y -camy < 160 *gameScale then
            pos = 1
        end
   end
   table.insert(dialogue.pos, pos)

   dialogue.pageNum = dialogue.pageNum +1
end

function dialogue:update()
    --Setup
    if dialogue.setup == false then
        dialogue.setup = true
        for p = 1, dialogue.pageNum do

            table.insert(dialogue.char,  {})
            dialogue.text_length[p] = string.len(dialogue.text[p])

            local col = {255, 255, 255}
            local line = 0
            local xtxt = ""
            for c = 1, dialogue.text_length[p], 1 do
                if dialogue.text[p]:sub(c, c) == "~" then
                    
                    if string.sub(dialogue.text[p], c +1, c +1) == "W" then
                        col = {255, 255, 2555}
                    elseif string.sub(dialogue.text[p], c +1, c +1) == "R" then
                        col = {255, 0, 0}
                    elseif string.sub(dialogue.text[p], c +1, c +1) == "O" then
                        col = {255, 191, 0}
                    elseif string.sub(dialogue.text[p], c +1, c +1)  == "Y" then
                        col = {255, 255, 0}
                    elseif string.sub(dialogue.text[p], c +1, c +1)  == "G" then
                        col = {0, 255, 0}
                    elseif string.sub(dialogue.text[p], c +1, c +1)  == "A" then
                        col = {0, 255, 255}
                    elseif string.sub(dialogue.text[p], c +1, c +1)  == "B" then
                        col = {0, 0, 255}
                    elseif string.sub(dialogue.text[p], c +1, c +1)  == "P" then
                        col = {255, 0, 255}
                    end

                    local txt = string.sub(dialogue.text[p], 1, c -2)
                    local txt2 = string.sub(dialogue.text[p], c +1, dialogue.text_length[p])
                    dialogue.text[p] = txt ..txt2
                
                end

                if dialogue.text[p]:sub(c, c) == "^" then
                    
                    local txt = string.sub(dialogue.text[p], 1, c -1)
                    local txt2 = string.sub(dialogue.text[p], c +1, dialogue.text_length[p])
                    dialogue.text[p] = txt ..txt2
                    line = line +1
                    xtxt = ""
                
                end

                if dialogue.text[p]:sub(c -1, (c -1)) == " " then
                    local txt = xtxt .." "
                    local cpos = (c -1) +1
                    local txttrue = nil
                    for i = 1, #string.sub(dialogue.text[p], (c -1) +1, dialogue.text_length[p]) do
                        cpos = cpos +1
                        txt = txt .." "
                        if dialogue.text[p]:sub(cpos, cpos) == " " and txttrue == nil then
                            txttrue = txt
                        elseif cpos == #dialogue.text[p] and txttrue == nil then
                            txttrue = txt
                        end
                    end
                    if txttrue == nil then
                        txttrue = xtxt
                    end
                    if #txttrue * 16 > dialogue.lineWidth then
                        if dialogue.text[p]:sub(1, 1) == "*" then
                            xtxt = "  "
                        else
                            xtxt = ""
                        end
                        line = line +1
                    end
                end

                table.insert(dialogue.char[p], {char = dialogue.text[p]:sub(c, c), x = 0, y = 0, col = {255, 255, 255}})
                dialogue.char[p][c].col = col
                
                xtxt =  xtxt .. " "

                dialogue.char[p][c].x = #xtxt * 16
                dialogue.char[p][c].y = line * dialogue.sep

            end

        end

    end

    --Sound
    if dialogue.draw_char < dialogue.text_length[dialogue.page]then
        dialogue.soundCount = dialogue.soundCount +1
        if dialogue.soundCount >= dialogue.soundOffset then
            dialogue.soundCount = 0
            love.audio.newSource('assets/sounds/'.. dialogue.sound[dialogue.page], "static"):play()
        end
    end

    --Portraits
    if dialogue.portrait[dialogue.page] ~= nil then
        
    else
        dialogue.offx = 0
    end

    dialogue.offY = dialogue.pos[dialogue.page] *(155 * gameScale)
    dialogue.draw_char = dialogue.draw_char +dialogue.text_spd
    dialogue.draw_char = math.min(dialogue.draw_char, dialogue.text_length[dialogue.page])
end

function dialogue:draw()
    --[[
    love.graphics.rectangle("fill", dialogue.boxX, (dialogue.boxY +dialogue.offY), dialogue.boxWidth *gameScale, dialogue.boxHeight *gameScale)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", dialogue.boxX +(3 *gameScale), (dialogue.boxY +dialogue.offY) +(3 *gameScale), (dialogue.boxWidth -6) *gameScale, (dialogue.boxHeight -6) *gameScale)
    love.graphics.setColor(255, 255, 255)
    ]]
    draw_box(dialogue.boxX, (dialogue.boxY +dialogue.offY), dialogue.boxWidth *gameScale, dialogue.boxHeight *gameScale)

    font:setFont("main.ttf", 16)
    for c = 1, dialogue.draw_char do
        font:draw({dialogue.char[dialogue.page][c].col, dialogue.char[dialogue.page][c].char}, 
            dialogue.boxX +dialogue.border +dialogue.offX +dialogue.char[dialogue.page][c].x, 
            (dialogue.boxY +dialogue.offY) +dialogue.border +dialogue.char[dialogue.page][c].y)
    end

end

function dialogue:destroy()
    dialogue.isActive = false
    dialogue.setup = false
    playerFree = true
end

return dialogue