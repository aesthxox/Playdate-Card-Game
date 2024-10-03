import "card"

local pd <const> = playdate
local gfx <const> = pd.graphics

opponentBoard = {nil, RabbitCard:new(), nil}

function displayOpponent(health)
    for i = 1, 3 do
        if opponentBoard[i] ~= nil then
            gfx.drawText(opponentBoard[i]:describe(health), 20 + (i * 80), 80)  -- Display played card
        else
            gfx.drawText("Empty", 20 + (i * 80), 80)  -- Display "Empty" slot
        end
    end
end