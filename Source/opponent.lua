import "person"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Opponent's round one play
opponentBoard = {nil, RabbitCard:new(), nil}

Opponent = setmetatable({}, { __index = Person})

function Opponent:new()
    return Person.new(self, "Harold", 10)
end

--Displaying th opponent board
function displayOpponent(health)
    for i = 0, 2 do
        if opponentBoard[i + 1] ~= nil then
            gfx.drawText(opponentBoard[i + 1]:describe(health), 50 + (i * 100), 80)  -- Display played card
        else
            gfx.drawText("Empty", 50 + (i * 100), 80)  -- Display "Empty" slot
        end
    end 
end