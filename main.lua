local screenWidth = 800
local screenHeight = 450

local leftPaddle = {x = 30, y = 185, width = 15, height = 80, speed = 300}
local rightPaddle = {x = 755, y = 185, width = 15, height = 80, speed = 300}

function love.load()
    love.window.setMode(screenWidth, screenHeight)
    love.window.setTitle("Pong Game")
    love.graphics.setBackgroundColor(0.08, 0.08, 0.12)
end

function love.update(dt)
    -- Move the left paddle.
    if love.keyboard.isDown("w") then
        leftPaddle.y = leftPaddle.y - leftPaddle.speed * dt
    end
    if love.keyboard.isDown("s") then
        leftPaddle.y = leftPaddle.y + leftPaddle.speed * dt
    end

    -- Move the right paddle.
    if love.keyboard.isDown("up") then
        rightPaddle.y = rightPaddle.y - rightPaddle.speed * dt
    end
    if love.keyboard.isDown("down") then
        rightPaddle.y = rightPaddle.y + rightPaddle.speed * dt
    end

    -- Keep both paddles inside the window.
    leftPaddle.y = math.max(0, math.min(leftPaddle.y, screenHeight - leftPaddle.height))
    rightPaddle.y = math.max(0, math.min(rightPaddle.y, screenHeight - rightPaddle.height))
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", leftPaddle.x, leftPaddle.y, leftPaddle.width, leftPaddle.height)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, rightPaddle.width, rightPaddle.height)
end
