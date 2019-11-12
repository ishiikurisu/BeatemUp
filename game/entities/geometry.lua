local geometry = { }
geometry.__index = geometry

function geometry:new(model)
    local o = { }
    setmetatable(o, geometry)
    o.position = {
        x = model.x,
        y = model.y
    }
    o.dimensions = {
        w = model.w,
        h = model.h
    }
    -- TODO load sprite from file
    o.sprite = nil
    return o
end

function geometry:receive(message, broadcaster)

end

function geometry:update(dt, broadcaster)

end

return geometry
