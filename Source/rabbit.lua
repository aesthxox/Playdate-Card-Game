import "card"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('RabbitCard').extends(gfx.sprite)

-- Define a RabbitCard subclass inheriting from Card
RabbitCard = setmetatable({}, { __index = Card })

function RabbitCard:new()
    return Card.new(self, "Rabbit", 0, 1, 0)
end
