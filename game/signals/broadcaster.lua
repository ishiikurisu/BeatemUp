local broadcaster = { }
broadcaster.__index = broadcaster

function broadcaster:new()
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
        entity:receive(message)
    end
end

return broadcaster
