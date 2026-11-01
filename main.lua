local screenWidth = 800
local screenHeight = 450

local leftPaddle = {x = 30, y = 185, width = 15, height = 80, speed = 300}
local rightPaddle = {x = 755, y = 185, width = 15, height = 80, speed = 300}
local ball = {x = 393, y = 218, width = 14, height = 14, dx = 250, dy = 60}

-- Return true when two rectangles overlap.
local function isColliding(a, b)
    return a.x < b.x + b.width and
           a.x + a.width > b.x and
           a.y < b.y + b.height and
           a.y + a.height > b.y
end

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

    -- Move the ball using delta time.
    ball.x = ball.x + ball.dx * dt
    ball.y = ball.y + ball.dy * dt

    -- Bounce from the top and bottom walls.
    if ball.y < 0 then
        ball.y = 0
        ball.dy = -ball.dy
    elseif ball.y + ball.height > screenHeight then
        ball.y = screenHeight - ball.height
        ball.dy = -ball.dy
    end

    -- Move the ball outside a paddle after each hit.
    if ball.dx < 0 and isColliding(ball, leftPaddle) then
        ball.x = leftPaddle.x + leftPaddle.width
        ball.dx = -ball.dx
    elseif ball.dx > 0 and isColliding(ball, rightPaddle) then
        ball.x = rightPaddle.x - ball.width
        ball.dx = -ball.dx
    end
end

function love.draw()
    love.graphics.setColor(0.2, 0.5, 1)
    love.graphics.rectangle("fill", leftPaddle.x, leftPaddle.y, leftPaddle.width, leftPaddle.height)
    love.graphics.setColor(1, 0.25, 0.25)
    love.graphics.rectangle("fill", rightPaddle.x, rightPaddle.y, rightPaddle.width, rightPaddle.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end
