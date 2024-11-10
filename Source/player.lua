local pd <const> = playdate
local gfx <const> = pd.graphics

-- Function to select a card from hand to play
function playCard(card, slot)
    if blood >= card.cost then
        selectedCard = card

        playerHand[slot].sprite:remove()
        playerHand[slot] = nil
        displayMessage(selectedCard.name .. " is selected", 15)
    else
        displayMessage("Not enough sacrifices!", 15)
    end
end

-- Function to place the selected card on the board
function placeCard(card, slot)
    playBoard[slot - 3] = selectedCard
    blood = blood - card.cost
    selectedCard = nil

end

-- Function to sacrifice a card
function sacrificeCard(slot)
    if playBoard[slot - 3] then
        blood = blood + 1
        if playBoard[slot - 3].sprite then
            setShakeAmount(5)
            playBoard[slot - 3].sprite:remove()
        end
        playBoard[slot - 3] = nil
    end
end

--deselecting card
function deselectCard(card, slot)
    if selectedCard ~= nil then
        playerHand[slot] = selectedCard
        selectedCard = nil
    else
        displayMessage("Ending Turn!", 15)
        endTurn()
    end
end

--Ending turn
function endTurn()
    for i = 1, 3 do
        if opponentBoard[i] and playBoard[i] ~= nil then 
            opponentBoard[i].health =- playBoard[i].attack
            setShakeAmount(5)
            if opponentBoard[i].health <= 0 then
                opponentBoard[i] = nil
            else
                displayOpponent(opponentBoard[i].health)
                displayMessage("Opponent Died!", 15)
                setShakeAmount(10)
            end
        end
    end
end

function buttons()
        -- Gives the ability to select cards for play
    if pd.buttonJustPressed(pd.kButtonA) then
        if selectedCard == nil then  -- If no card is selected
            if slot <= 3 and playerHand[slot] then  -- Play cards in hand
                playCard(playerHand[slot], slot)
            else
                if slot > 3 and playBoard[slot - 3] ~= nil then  -- Sacrifice cards in play
                    sacrificeCard(slot)
                else
                    displayMessage("There is no card to play!", 15)
                end
            end
        elseif selectedCard ~= nil then  -- If card is selected
            if slot <= 3 then
                displayMessage("Card is already selected!", 15)
            elseif playBoard[slot - 3] == nil then
                placeCard(selectedCard, slot)
            else
                displayMessage("There is already a card there!", 15)
            end
        end
    end

    -- Sacrifice the card in the selected slot if B is pressed
    if pd.buttonJustPressed(pd.kButtonB) then
        deselectCard(selectedCard, slot)
    end

    -- Move selection between slots using the D-pad
    if pd.buttonJustPressed(pd.kButtonLeft) then
        slot = math.max(1, slot - 1)
    elseif pd.buttonJustPressed(pd.kButtonRight) then
        slot = math.min(6, slot + 1)
    end
end