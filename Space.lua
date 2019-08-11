Space = Class {}

function Space:init(x, y)
    self.width = 128 
    self.height = 90
    self.x = x
    self.y = y
    self.top = 10
    self.bottom = 10
    self.left = 8
    self.right = 8
    self.color = {} 
end

function Space:render()
    love.graphics.setColor(love.math.random(0,255), love.math.random(0,255), love.math.random(0,255))
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

