local Entity = require "/entities/base/entity"
local Hitbox = require "/entities/hitbox"
local signals_directions = require "/signals/directions"

local function Pawn(world, model)
    local self = Entity(world, model)
    self.kind = "dummy"
    self.color = {
        0,  -- red
        0,  -- green
        0   -- blue
    }
    self.status = {
        up = false,
        down = false,
        left = false,
        right = false
    }
    self.face = 1  -- positive for left, negative for right

    self.body = love.physics.newBody(world, model.x, model.y, "dynamic")
    self.shape = love.physics.newRectangleShape(model.w, model.h)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.body:setAngularDamping(10000)
    self.friction = 0.3
    self.velocity = 200

    self.health = model.health
    self.totalHealth = model.health
    self.strength = model.strength
    self.stamina = 0
    self.gracePeriod = 0

    function self:processMovementMessages(message, controller)
        if message.agent == self then
            if message.name == "move" then
                self.status[message.direction] = true
            elseif message.name == "stop" then
                self.status[message.direction] = false
            end
        end
    end

    function self:move(dt, controller)
        local vx = 0
        local vy = 0

        for key, value in pairs(self.status) do
            if value == true then
                local direction = signals_directions.get_direction(key)
                vx = vx + self.velocity * direction.x
                vy = vy + self.velocity * direction.y
            end
        end
        self.body:setLinearVelocity(vx, vy)
        self:apply_friction(dt)

        if vx > 0 then
            self.face = 1
        elseif vx < 0 then
            self.face = -1
        end
    end

    function self:apply_friction(dt)
        local vx, vy = self.body:getLinearVelocity()
        vx = vx * (1 - self.friction)
        vy = vy * (1 - self.friction)
        self.body:setLinearVelocity(vx, vy)
    end

    function self:getDistance(pawn)
        local ax = self.body:getX()
        local ay = self.body:getY()
        local bx = pawn.body:getX()
        local by = pawn.body:getY()
        return ((ax - bx) ^ 2 + (ay - by) ^ 2) ^ 0.5
    end

    function self:hit()
        return Hitbox(world, {
            x = self.body:getX() + (5 + model.w) * self.face,
            y = self.body:getY(),
            w = 20,
            h = model.h * 0.9,
            lifespan = 0.2,
            agent = self,
        })
    end

    function self:processHits(message, controller)
        if message.name == "hurt" then
            local agent = message.agent
            local target = message.target
            if agent ~= target and target.gracePeriod >= 0 then
                target.health = target.health - agent.strength
                target.gracePeriod = -1
                if target.health <= 0 then
                    controller:destroy(target)
                end
            end
        end
    end

    function self:applyBodyFunctions(dt, controller)
        if self.stamina < 0 then
            self.stamina = self.stamina + dt
        end
        if self.gracePeriod < 0 then
            self.gracePeriod = self.gracePeriod + dt
        end
    end

    return self
end

return Pawn
