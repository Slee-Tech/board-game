Class = require 'class'
require 'Space'
require 'Board'
require 'Player'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local testMovement = { ['x'] = 0, ['y'] = 0 }
-- will start moving right initially
local direction = {
    ['left'] = false,
    ['right'] = true,
    ['down'] = false,
    ['up'] = false,
}

currentDirection = 'right'

-- test of board and player class
local gameBoard = Board()
local testPlayer = Player(0, 0, {255,0,0}, 'P1')
testPlayer.isTurn = false
local testPlayer2 = Player(0, 0, {0,0,255}, 'P2') --WINDOW_WIDTH - 256
testPlayer2.isTurn = true
local timer = 0
local currentTurn = testPlayer2
local diceFont = love.graphics.newFont(40)
local currentRoll = 0
local currentRoleMovement = 0
local isTwo = nil

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        resizable = false,
        --fullscreen = false
    })
    love.window.setTitle('Board Game')
    love.keyboard.keyPressed = {}
end

function love.keypressed(key)
    love.keyboard.keyPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

-- allows keypress to be used outside of main
function love.keyboard.wasPressed(key)
    if love.keyboard.keyPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    timer = timer + dt
    
        if love.keyboard.wasPressed('space') and not currentTurn.isMoving then
            currentRoll = love.math.random(1,6)
            -- reverse direction on rolls of 2
            if currentRoll == 2 then --% 2 == 0 then
                isTwo = true
            else
                
                isTwo = false
            end 
            
            if currentTurn == testPlayer2 then
               
                testPlayer.isTurn = not testPlayer.isTurn
                testPlayer2.isTurn = not testPlayer2.isTurn
                currentTurn = testPlayer
                currentTurn.turnNum = currentTurn.turnNum+1 
                currentTurn.currentRoleMovement = 0
            else 
            
            testPlayer2.isTurn = not testPlayer2.isTurn
            testPlayer.isTurn = not testPlayer.isTurn
            currentTurn = testPlayer2
            currentTurn.turnNum = currentTurn.turnNum+1 
            --  YOU SPELLED 'ROLL' WRONG ASSHOLE, THIS LED TO MANY MISTAKES
            currentTurn.currentRoleMovement = 0
            end
        end
        
    testPlayer:update(dt, currentRoll, isTwo)
    testPlayer2:update(dt, currentRoll, isTwo)
    gameBoard:getPlayersSpace(testPlayer, testPlayer2)
    
    love.keyboard.keyPressed = {}
end

function love.draw()
    gameBoard:render()
    testPlayer:render()
    testPlayer2:render()
    --love.graphics.rectangle('line', (WINDOW_WIDTH/2)-64, (WINDOW_HEIGHT/2)-45 ,128, 90)
    love.graphics.setFont(diceFont)
    love.graphics.print(math.floor(timer), (WINDOW_WIDTH/2-8), (WINDOW_HEIGHT/2)-20)
    love.graphics.print(currentTurn.name .. ' ROLLED: ' .. currentTurn.currentRoleMovement, (WINDOW_WIDTH/2-8-480), (WINDOW_HEIGHT/2)-8+200)
    love.graphics.print('CURRENT TURN: ' .. currentTurn.name, (WINDOW_WIDTH/2+100), (WINDOW_HEIGHT/2)-8+200)
    love.graphics.print('PRESS SPACE TO ROLL', (WINDOW_WIDTH/2-8-200), (WINDOW_HEIGHT/2)-250)
end