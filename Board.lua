require 'Space'
Board = Class{}

function Board:init()
    self.spaces = {}
    self.rows = 8
    self.columns = 10
    self.currentPlayer = nil
    self.playerMoving = false
    self.players = {
        ['p1'] = 0,
        ['p2'] = 0
    }
    self:makeBoard()
    self.currentRoll = 0
end

-- draws board, row by row
function Board:makeBoard()
    startingY = 0
    for col = 0, self.rows, 1 do
        startingX = 0
        for rows = 0, self.columns, 1 do
            -- initialize spaces, then set x and y values
            if (col == 0 or col == self.rows-1 or rows == 0 or rows == self.columns-1) then 
                table.insert(self.spaces, Space(startingX, startingY))
            end
            startingX = startingX + 128 -- space width
        end
        startingY = startingY + 90 -- space height
    end

end

function Board:getPlayersSpace(testPlayer, testPlayer2)
    self.players['p1'] = testPlayer.spacesTravelled
    self.players['p1Name'] = testPlayer.name
    self.players['p2'] = testPlayer2.spacesTravelled
    self.players['p2Name'] = testPlayer2.name
end

function Board:render()
    
    for i, space in pairs(self.spaces) do
        space:render()
    end

    if self.players['p1'] >= 32 then
        love.graphics.print(self.players['p1Name'] .. 'Wins', (WINDOW_WIDTH/2+100), (WINDOW_HEIGHT/2)-8-300)
    elseif self.players['p2'] >= 32 then 
        love.graphics.print(self.players['p2Name'] .. 'Wins', (WINDOW_WIDTH/2+100), (WINDOW_HEIGHT/2)-8-300)
    end
end
