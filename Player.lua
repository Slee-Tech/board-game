-- this may be used as a base class for types of players to inherit from
Player = Class{}

function Player:init(x, y, color, name)
    self.x = x
    self.y = y
    self.name = name
    self.spacesTravelled = 0
    self.isTurn = false
    -- will intially be moving right
    self.direction = {
        ['left'] = false,
        ['right'] = true,
        ['down'] = false,
        ['up'] = false,
    }
    self.color = color
    self.image = nil
    self.hasRolled = false
    self.currentRoll = 0
    self.currentRollMovement = 0
    self.isMoving = false
    self.evenRoll = false
    self.turned = false
    self.turnNum = 0
end

function Player:update(dt, currentRoll, isTwo)

    -- can add spaces travelled logic here and ensure they stay lined up with board
    if self.isTurn then
        
        if self.currentRollMovement == currentRoll then
            
            self.isMoving = false
            -- stop moving when roll movement equals the current player's roll
            return
        else
            self.isMoving = true
            self.turned = false
            
            -- if player rolls a two, they should reverse direction
            if isTwo then
                if self.direction['right'] then

                    self.x = self.x - 8
    
                    if self.x <= 0 then 
                        self.direction['right'] = false
                        self.direction['up'] = true
                        self.spacesTravelled = self.spacesTravelled +1
                        
                    end
                    -- checks for spaces moved
                    if self.x % 128 == 0  then
                        self.currentRollMovement = self.currentRollMovement + 1
                        self.spacesTravelled = self.spacesTravelled - 1
                        -- should prevent moving slightly around corners
                        if self.currentRollMovement == currentRoll then
                            return
                        end
                    end
                    
                end
            
                if self.direction['down'] then
    
                    self.y = self.y - 9

                    if self.y <= 0 then
                        self.direction['down'] = false
                        self.direction['right'] = true
                    end
                    -- checks for spaces moved
                    if self.y % 90 == 0 then
                        self.currentRollMovement = self.currentRollMovement + 1
                        self.spacesTravelled = self.spacesTravelled - 1
                        
                        if self.currentRollMovement == currentRoll then
                            return
                        end
                    end
                end
                
                if self.direction['left'] then
    
                    self.x = self.x + 8

                    if self.x >= WINDOW_WIDTH -128  then
                        self.direction['left'] = false
                        self.direction['down'] = true
                    end
                    -- checks for spaces moved
                    if self.x % 128 == 0 then
                        self.currentRollMovement = self.currentRollMovement + 1
                        self.spacesTravelled = self.spacesTravelled -1 
                        
                        if self.currentRollMovement == currentRoll then
                            return
                        end
                    end
                    
                end
                
                if self.direction['up'] then
    
                    self.y = self.y + 9

                    if self.y >= WINDOW_HEIGHT-90  then
                        self.direction['up'] = false
                        self.direction['left'] = true
                        --self.spacesTravelled = self.spacesTravelled - 1
                    end
                    -- checks for spaces moved
                    if self.y % 90 == 0 then
                        self.currentRollMovement = self.currentRollMovement + 1
                        self.spacesTravelled = self.spacesTravelled - 1
                        
                        if self.currentRollMovement == currentRoll then
                            return
                        end
                    end
                end

                
            else -- this handles normal direction movement
                if self.direction['right'] then
                
                self.x = self.x + 8

                if self.x >= WINDOW_WIDTH - 128 then 
                    self.direction['right'] = false
                    self.direction['down'] = true
                end
                -- checks for spaces moved
                if self.x % 128 == 0 then
                    self.currentRollMovement = self.currentRollMovement + 1
                    self.spacesTravelled = self.spacesTravelled + 1
                    -- might prevent moving slightly around corners
                    if self.currentRollMovement == currentRoll then
                        return
                    end
                end
            end
        
            if self.direction['down'] then

                self.y = self.y + 9

                if self.y >= WINDOW_HEIGHT-90 then
                    self.direction['down'] = false
                    self.direction['left'] = true
                end
                -- checks for spaces moved
                if self.y % 90 == 0 then
                    self.currentRollMovement = self.currentRollMovement + 1
                    self.spacesTravelled = self.spacesTravelled + 1
                
                    if self.currentRollMovement == currentRoll then
                        return
                    end
                end
            end
            
            if self.direction['left'] then

                self.x = self.x - 8

                if self.x <= 0 then
                    self.direction['left'] = false
                    self.direction['up'] = true
                end
                -- checks for spaces moved
                if self.x % 128 == 0 then
                    self.currentRollMovement = self.currentRollMovement + 1
                    self.spacesTravelled = self.spacesTravelled + 1
                    
                    if self.currentRollMovement == currentRoll then
                        return
                    end
                end
                
            end
            
            if self.direction['up'] then

                self.y = self.y - 9

                if self.y <= 0 then
                    self.direction['up'] = false
                    self.direction['right'] = true
                    self.spacesTravelled = self.spacesTravelled - 1
                end
                -- checks for spaces moved
                if self.y % 90 == 0 then
                    self.currentRollMovement = self.currentRollMovement + 1
                    self.spacesTravelled = self.spacesTravelled + 1
                    
                    if self.currentRollMovement == currentRoll then
                        return
                    end
                end
            end
        end -- ends reverse direction if else
        end
    end
end

function Player:render()
    -- may also contain a color or image later
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle('fill', self.x, self.y, 128, 90)
end