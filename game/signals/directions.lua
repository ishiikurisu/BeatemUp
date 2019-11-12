local directions = { }

function directions.get_direction(name)
    local x = 0
    local y = 0

    if name == "up" then
        y = -1
    elseif name == "down" then
        y = 1
    elseif name == "left" then
        x = -1
    elseif name == "right" then
        x = 1
    end

    return {
        x = x,
        y = y
    }
end

return directions
