local broadcaster = { }
broadcaster.__index = broadcaster

function broadcaster:new()
    -- IDEA replace me by love.event
    local o = { }
    setmetatable(o, broadcaster)
    o.entities = { }
    return o
end

function broadcaster:subscribe(entity)
    table.insert(self.entities, entity)
end

function broadcaster:broadcast(message)
    for _, entity in pairs(self.entities) do
        entity:receive(message, self)
    end
end

return broadcaster
