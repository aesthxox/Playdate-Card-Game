Person = {}
Person.__index = Card

local pd <const> = playdate
local gfx <const> = pd.graphics

-- giving people names and health
function Person:new(name, health)
    self.name = name
    self.health = health
    return self
end

--Check health each round to determine weather or not the game should be over
function checkHealth()

end