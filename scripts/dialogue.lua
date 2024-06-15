local dialogue = {}

function dialogue:init()
    dialogue.isActive = false
    dialogue.boxWidth = 296
    dialogue.boxHeight = 83
    dialogue.border = 12 *gameScale
    dialogue.sep = 16 *gameScale
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

function dialogue:create(text)
    playerFree = false
    dialogue.isActive = true
    dialogue.text = text--{"* This is the 1st page!", "* This is the 2nd page!", "* This is the 3rd page!\n* LINE BREAK LETS GO!!!!!!!"}
    dialogue.page = 1
    dialogue.pageNum = #dialogue.text
    dialogue.boxX = camx +((320 -dialogue.boxWidth)/2) *gameScale
    dialogue.boxY = camy +148 *gameScale

    for p = 1, dialogue.pageNum do
        dialogue.text_length[p] = string.len(dialogue.text[p])
    end
end

function dialogue:update()
    dialogue.draw_char = dialogue.draw_char +dialogue.text_spd
end

function dialogue:draw()
    
    love.graphics.rectangle("fill", dialogue.boxX, dialogue.boxY, dialogue.boxWidth *gameScale, dialogue.boxHeight *gameScale)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", dialogue.boxX +(3 *gameScale), dialogue.boxY +(3 *gameScale), (dialogue.boxWidth -6) *gameScale, (dialogue.boxHeight -6) *gameScale)
    love.graphics.setColor(255, 255, 255)

    font:setFont("main.ttf", 16)
    font:draw(string.sub(dialogue.text[dialogue.page], 1, dialogue.draw_char), dialogue.boxX +dialogue.border, dialogue.boxY +dialogue.border)

end

function dialogue:destroy()
    dialogue.isActive = false
    playerFree = true
end

return dialogue