local input = {}
input.keys = {}
function input:keypress(keyp, onpress)

    --input.keys[1] = {key = keyp, onpress = onpress}
    table.insert(input.keys, {key = keyp, onpress = onpress})

    function love.keypressed(key) 
        
        for i, keys in pairs(input.keys) do
            if key == input.keys[i].key then
                input.keys[i].onpress()
            end
        end

    end

end

function input:removekey()

    table.remove(input.keys)

end

return input