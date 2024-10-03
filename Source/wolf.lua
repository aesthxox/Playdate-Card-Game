import "card"
local pd <const> = playdate
local gfx <const> = pd.graphics

class('WolfCard').extends(gfx.sprite)

-- Define a WolfCard subclass inheriting from Card
WolfCard = setmetatable({}, { __index = Card })

function WolfCard:new()
    return Card.new(self, "Wolf", 3, 2, 1)
end
