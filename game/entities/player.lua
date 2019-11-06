local player = { }
player.__index = player

function player:new(model)
    local o = { }
    setmetatable(o, player)
    o.position = {
        x = model.x,
        y = model.y
    }
    -- TODO allow multiple states (so I can move diagonally)
    o.state = "idle"
    -- TODO load that from file
    -- TODO use actual sprite instead of fixed colors
    -- TODO use actual images instead of colors
    o.color = {
        255, -- red
        0,   -- green
        0    -- blue
    }
    return o
end

function player:receive(message)
    -- TODO separate the message reception and player update
    if message.action == "start moving up" then
        self.state = "moving up"
    elseif message.action == "stop moving up" then
        self.state = "idle"
    elseif message.action == "start moving left" then
        self.state = "moving left"
    elseif message.action == "stop moving left" then
        self.state = "idle"
    elseif message.action == "start moving down" then
        self.state = "moving down"
    elseif message.action == "stop moving down" then
        self.state = "idle"
    elseif message.action == "start moving right" then
        self.state = "moving right"
    elseif message.action == "stop moving right" then
        self.state = "idle"
    end
end

function player:update(dt)
    if self.state == "moving up" then
        self.position.y = self.position.y - 1
    elseif self.state == "moving down" then
        self.position.y = self.position.y + 1
    elseif self.state == "moving left" then
        self.position.x = self.position.x - 1
    elseif self.state == "moving right" then
        self.position.x = self.position.x + 1
    end
end

return player
