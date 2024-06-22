local world = {}
world.vines = false

function world:update()
    if room == "Ruins01" then
        if flag[1] == 2 then
            gameMap.layers["Vines"].visible = false
            for i, obj in pairs(overworld.objects) do
                if obj.name == "npc_vines" and world.vines == false then
                    world.vines = true
                    overworld.objects[i]:destroy()
                end
            end
        end
        print("Ruins01 is working!")
    else
        world.vines = false
    end
end

return world