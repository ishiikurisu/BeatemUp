start = require "/controllers/world_controller"

function love.load()
    current_controller = start:new()
end

function love.keypressed(key, scancode, isrepeat)
    current_controller:push({
        key => key,
        edge => "rise"
    })
end

function love.keyreleased(key)
   if key == "escape" then
      love.event.quit()
   end
   current_controller:push({
       key => key,
       edge => "fall"
   })
end

function love.update(dt)
    current_controller = current_controller:update(dt)
end

function love.draw()
    current_controller:draw()
end
