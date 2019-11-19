local world_view = require "/views/world_view"
local player_entity = require "/entities/player"
local enemy_entity = require "/entities/enemy"
local joystick_view = require "/views/joystick"
local broadcaster = require "/signals/broadcaster"
local level_model = require "/models/level"
local brick_entity = require "/entities/brick"
local finish_line_entity = require "/entities/finish_line"
local level_entity = require "/entities/level"

function WorldController(world)
    local self = { }

    self.actions = { }
    love.physics.setMeter(2)
    self.world = love.physics.newWorld(0, 0, true)
    self.broadcaster = broadcaster:new()
    self.entities = { }
    local kinds = {
        player = player_entity,
        enemy = enemy_entity,
        brick = brick_entity,
        finish_line = finish_line_entity,
        level = level_entity,
    }

    for _, data in pairs(level_model:load_level(world)) do
        local model = kinds[data.entity]

        if model then
            local entity = model(self.world, data)
            table.insert(self.entities, entity)
            self.broadcaster:subscribe(entity)
            if data.entity == 'player' then
                self.player = entity
            end
            if data.entity == 'level' then
                self.level = entity
            end
        end
    end

    -- TODO define tangible components
    self.joystick = joystick_view:new(self)
    self.view = world_view()

    function self:push(user_action)
        local action = self.joystick:translate(user_action)
        table.insert(self.actions, action)
    end

    function self:update(dt)
        local controller = self

        self.world:update(dt)
        for _, action in pairs(self.actions) do
            self.broadcaster:broadcast(action, self)
        end
        self.actions = { }

        for _, it in pairs(self.entities) do
            it:update(dt, self)
        end

        return controller
    end

    function self:draw()
        self.view:draw(self)
    end

    return self
end

return WorldController
