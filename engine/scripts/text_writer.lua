local dialogue = {}

function dialogue:create(text, x, y, length, pos)
    
    dialogue.text = text
    dialogue.x = x
    dialogue.y = y
    dialogue.pos = defaultValue(pos, #dialogue.text)

    dialogue.lineWidth = length
    dialogue.linebreak = {}
    dialogue.char = {}
    dialogue.sep = 16 *gameScale

    --Setup
    dialogue.setup = true
    dialogue.text_length = #dialogue.text

    local col = {255, 255, 255}
    local line = 0
    local xtxt = ""
    for c = 1, dialogue.text_length, 1 do
            if dialogue.text:sub(c, c) == "~" then
                
                if string.sub(dialogue.text, c +1, c +1) == "W" then
                    col = {255, 255, 255}
                elseif string.sub(dialogue.text, c +1, c +1) == "R" then
                    col = {255, 0, 0}
                elseif string.sub(dialogue.text, c +1, c +1) == "O" then
                    col = {255, 191, 0}
                elseif string.sub(dialogue.text, c +1, c +1)  == "Y" then
                    col = {255, 255, 0}
                elseif string.sub(dialogue.text, c +1, c +1)  == "G" then
                    col = {0, 255, 0}
                elseif string.sub(dialogue.text, c +1, c +1)  == "A" then
                    col = {0, 255, 255}
                elseif string.sub(dialogue.text, c +1, c +1)  == "B" then
                    col = {0, 0, 255}
                elseif string.sub(dialogue.text, c +1, c +1)  == "P" then
                    col = {255, 0, 255}
                end

                local txt = string.sub(dialogue.text, 1, c -2)
                local txt2 = string.sub(dialogue.text, c +1, dialogue.text_length)
                dialogue.text = txt ..txt2
            
            end

            if dialogue.text:sub(c, c) == "^" then
                
                local txt = string.sub(dialogue.text, 1, c -1)
                local txt2 = string.sub(dialogue.text, c +1, dialogue.text_length)
                dialogue.text = txt ..txt2
                dialogue.linebreak = c
                line = line +1
                xtxt = ""
            end

            if dialogue.text:sub(c -1, (c -1)) == " " then
                local txt = xtxt .." "
                local cpos = (c -1) +1
                local txttrue = nil
                for i = 1, #string.sub(dialogue.text, (c -1) +1, dialogue.text_length) do
                    cpos = cpos +1
                    txt = txt .." "
                    if dialogue.text:sub(cpos, cpos) == " " and txttrue == nil then
                        txttrue = txt
                    elseif cpos == #dialogue.text and txttrue == nil then
                        txttrue = txt
                    end
                end
                txttrue = defaultValue(txttrue, xtxt)
                if #txttrue * 16 > dialogue.lineWidth then
                    if dialogue.text:sub(1, 1) == "*" then
                        xtxt = "  "
                    else
                        xtxt = ""
                    end
                    line = line +1
                end
            end

            table.insert(dialogue.char, {char = dialogue.text:sub(c, c), x = 0, y = 0, col = {255, 255, 255}})
            dialogue.char[c].col = col
            
            xtxt =  xtxt .. " "

            dialogue.char[c].x = #xtxt * 16
            dialogue.char[c].y = line * dialogue.sep

    end

    font:setFont("main.ttf", 16)
    for c = 1, dialogue.pos, 1 do
        font:draw({dialogue.char[c].col, dialogue.char[c].char}, dialogue.x +dialogue.char[c].x, dialogue.y +dialogue.char[c].y)
    end

end

return dialogue