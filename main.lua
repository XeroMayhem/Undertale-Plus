local json = require 'engine.libraries.json'
local open = io.open
local file = open("config.json", "rb")
if not file then return nil end
local jsonString = file:read "*a"
file:close()

local data = json.decode(jsonString)

if data.mod_hub == false then
    require ('game')
else
    require ('mod_loader')
end