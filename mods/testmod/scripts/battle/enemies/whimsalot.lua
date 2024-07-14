local whimsalot = enemy_scripts:create('Whimsalot', 'spr_whimsalot_head', (640/3 *1), 'spr_whimsalot_head_hurt')
whimsalot.rig_only = true
whimsalot.xscale = 2
whimsalot.yscale = 2
whimsalot.acts = {'Check', 'Mock'}
whimsalot.waves = {'basic_1', 'basic_2', 'whim'}
whimsalot.waves_random = false
whimsalot.y = 40

local rwing = whimsalot:add_rig(60, 40, 'spr_whimsalot_wing_r', 1)
rwing.yoffset = 14
local lwing = whimsalot:add_rig(14, 40, 'spr_whimsalot_wing_r', 1)
lwing.xscale = -2
lwing.yoffset = 14
local body = whimsalot:add_rig(0, 50, 'spr_whimsalot_body', 0)
local head = whimsalot:add_rig(6, 0, 'spr_whimsalot_head', 4)

local siner = 0

function whimsalot:update(dt)
    
    siner = siner +1
    local goof = math.sin(siner/5)
    lwing.y = 40 - (goof * 2)
    rwing.y = 40 - (goof * 2)
    rwing.rot = ((math.sin((siner / 5)) * 30) - 15)
    lwing.rot = (((-(math.sin((siner / 5)))) * 30) + 15)
    body.y = 50 +(goof * 6)
    head.y = (goof * 8)
    
end

function whimsalot:act(name)
    
    if name == 'Check' then
        enemy_scripts:act_text(whimsalot, '* Whimaslot 4AT 5DF^* The bravest of warriors!')
    end

    if name == 'Mock' then
        enemy_scripts:act_text(whimsalot, {'* You put on a fake accent.', "* Whimsalot didn't seem too pleased."})
    end
    
end

return whimsalot