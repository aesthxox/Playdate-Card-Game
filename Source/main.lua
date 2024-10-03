--Core libs
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/sprites"

-- class
import "wolf"
import "rabbit"
import "opponent"
import "screenShake"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

-- Game variables
sacrificePool = 0  -- Pool of sacrifices for playing cards
playerBoard = {nil, nil, nil}  -- three slots, hand cards
playSlot = {nil, nil, nil}  -- Three slots for playing cards
selectedCard = nil  -- Placeholder for selected cards
selectedSlot = 1  -- Currently selected slot to play or sacrifice cards
local gameState = "start"  -- game state
screenShakeSprite = ScreenShake()
local textDisplayFrames = 0

Z_INDEXES = {
    Card = 100
}

-- ScreenShake
function setShakeAmount(amount)
    screenShakeSprite:setShakeAmount(amount)
end

-- Displaying message for an amount of time
function displayMessage(text, frames)
    messageText = text
    textDisplayFrames = frames
end

-- Gives the player 3 random cards to start
local function randomCard()
    for i = 1, 3 do
        if math.random() <= 0.35 then
            playerBoard[i] = WolfCard:new()
        else
            playerBoard[i] = RabbitCard:new()
        end
    end
    gameState = "phase1"
end

-- Function to display cards on the board
local function displayBoard()
    for i = 1, 3 do
        if playerBoard[i] then
            gfx.drawText(playerBoard[i]:describe(), 20, 140 + (i * 20))  -- Display cards in hand

            -- Draw the card sprite
            playerBoard[i].sprite:moveTo(20, 120 + (i * 30))  -- Adjust the position as needed
            playerBoard[i].sprite:add()
        end
        if playSlot[i] ~= nil then
            gfx.drawText(playSlot[i]:describe(), 60 + (i * 80), 200)  -- Display played card

            -- Draw the played card sprite
            playSlot[i].sprite:moveTo(60 + (i * 80), 180)  -- Adjust the position as needed
            playSlot[i].sprite:add()
        else
            gfx.drawText("Empty", 60 + (i * 80), 200)  -- Display "Empty" slot
        end
    end
    gfx.drawText("Sacrifice Pool: " .. sacrificePool, 150, 20)
    gfx.drawText("Selected Slot: " .. selectedSlot, 150, 40)
end


-- Update game
function pd.update()
    gfx.clear()  -- Clears the screen
    gfx.sprite.update()

    if gameState == "start" then  -- Start the game
        randomCard()
    end

    -- Display the player's and opponent's board
    displayBoard()
    displayOpponent()

        -- Display the message if the frame counter is greater than 0
    if textDisplayFrames > 0 then
        gfx.drawText(messageText, 100, 100) -- Adjust position as necessary
        textDisplayFrames = textDisplayFrames - 1 -- Decrement the frame counter
    end

    --PLAYER buttons
    buttons()
end
