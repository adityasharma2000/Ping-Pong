--[[
    Fires only once
]]
push = require 'push'

WINDOW_WIDTH = 512
WINDOW_HEIGHT = 512
dt = 0.01

function love.load()
    math.randomseed(os.time())

    paddlespeed = 200

    player1score = 0
    player2score = 0

    ballx = WINDOW_WIDTH/2 - 2
    bally = WINDOW_HEIGHT/2 -2

    if math.random(2)==1 then
        ballvx = 100;
    else
        ballvx = -100
    end 
    ballvy = love.math.random( -100, 100)

    player1Y = 30
    player2Y = WINDOW_HEIGHT-50

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    Statemachine = "Start"

end

--[[
    Called after Update
    The draw function
]]

function love.draw()
    -- love.graphics.clear(40, 45, 52, 255)

    love.graphics.printf(
        'Ping Pong',  --Text
        0, --Starting x
        6,
        WINDOW_WIDTH,
        'center'
    )
    love.graphics.print(tostring(player1score),WINDOW_WIDTH/2-50,WINDOW_HEIGHT/3)
    love.graphics.print(tostring(player2score),WINDOW_WIDTH/2+40,WINDOW_HEIGHT/3)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    love.graphics.rectangle('fill', WINDOW_WIDTH - 10, player2Y, 5, 20)
    love.graphics.rectangle('fill', ballx, bally, 4, 4)

end


function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if Statemachine == 'Start' then
            Statemachine = 'Play'
        elseif Statemachine == 'Play' then
            Statemachine = 'Start'

            player1score = 0
            player2score = 0

            ballx = WINDOW_WIDTH/2 - 2
            bally = WINDOW_HEIGHT/2 -2

            if math.random(2)==1 then
                ballvx = 100;
            else
                ballvx = -100
            end 
            ballvy = love.math.random( -100, 100)
        
            player1Y = 30
            player2Y = WINDOW_HEIGHT-50


        end
    end
end


function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y + -paddlespeed*dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(player1Y + paddlespeed*dt, WINDOW_HEIGHT-20)
    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -paddlespeed*dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(player2Y + paddlespeed*dt, WINDOW_HEIGHT-20)
    end

    if Statemachine == 'Play' then
        ballx = ballx + dt*ballvx
        bally = bally + dt*ballvy
    end
end