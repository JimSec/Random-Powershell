$suite_pool = @("Heart","Diamond","Club", "Spade")
$face_pool = @("A","2","3","4","5","6","7","8","9","10","J","Q","K")

$deck = New-Object System.Collections.ArrayList


foreach ($suite in $suite_pool) {

    foreach ($face in $face_pool) {

        #Color Setting
        if (($suite -like "Heart") -or ($suite -like "Diamond")) {
        
            $Color = "Red"

        }

        else {

            $Color = "Black"

        }

        #Card Value Setting
        if (@("J","Q","K") -contains $face) {

            $value = 10

        }

        elseif ("A" -match $face) {
    
            $value = 11
    
        }    
    
    
        else {
    
            $value = [int]$face

        }


        $prop = @{
    
            Color = $Color
            Suite = $suite
            Face =  $face
            Value = $value


        }

        $card = New-Object PSCustomObject -Property $prop

        [void]$deck.Add($card)

    }   

}


$Shuffled_Deck = $deck | Sort-Object {Get-Random}

# Grab two cards for player, two for dealer.

# Have player draw until 21, bust, or hold.

# pointer at 0, increment in each hand

function Play-Hand {


    param ([System.Collections.ArrayList]$play_deck)

    $i=0

    $player_hand = New-Object System.Collections.ArrayList
    $dealer_hand = New-Object System.Collections.ArrayList

    #Start game

    [void]$player_hand.Add($play_deck[$i])
    $i++
    [void]$player_hand.Add($play_deck[$i])
    $i++

    $player_hand_value = 0

    foreach ($card in $player_hand) {

        $player_hand_value += $card.Value    

    }

    write-host "Total Hand Value: " $player_hand_value

    write-host "Your Cards:" 
    $player_hand | Format-Table

    [void]$dealer_hand.Add($play_deck[$i])

    write-host "Dealer Cards:" 
    $dealer_hand | Format-Table

    if ($player_hand_value -le 21) {
    
        $player_choice = Read-Host "(D)raw, (S)tay? :"

        if ($player_choice -eq "D") {

            [void]$player_hand.Add($play_deck[$i])
            $i++

            $player_hand_value = 0

            foreach ($card in $player_hand) {

                $player_hand_value += $card.Value    

            }

            write-host "Total Hand Value: " $player_hand_value

            write-host "Your Cards:" 
            $player_hand | Format-Table


        }

    }

}

function Play-Blackjack {

    param ([System.Collections.ArrayList]$play_deck)

    $play_deck

}



Play-hand $Shuffled_Deck