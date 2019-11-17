local level_model = { }

function level_model:load_level(world)
    local level_path = "assets/worlds/" .. world .. "/"
    local world_data_path = level_path .. "world.lua"
    local world = love.filesystem.load(world_data_path)
    return world()
end

return level_model
