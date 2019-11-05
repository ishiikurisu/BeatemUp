local world_view = require "/views/world_view"
local world_controller = { }
world_controller.__index = world_controller

function world_controller:new(world)
    local o = { }
    setmetatable(o, world_controller)
    o.actions = { }
    o.view = world_view:new(self)
    -- TODO define world, as it should contain entities, geometry, and whatever else is needed to run the game
    return o
end

function world_controller:push(action)
    -- TODO convert action into something meaningful depending on controller scheme
end

function world_controller:update(dt)
    local controller = self

    -- TODO implement signal broadcaster
    -- TODO loop through all actions and send the required signals

    return controller
end

function world_controller:draw()
    self.view:draw(self)
end

return world_controller
