function Generate-SimplePassword() {

#Funtion to genereate simple password, does not use "Hard" Chars (1, I, i, j, l, 0, O, o, !)
#Takes interger for Password Length


    Param(
        [int]$Password_Length,
        [switch]$SecureString)

    #Char Arrays and empty password string

    $Uppers = ("A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z")
    $Lowers = ("a","b","c","d","e","f","g","h","k","m","n","q","r","s","t","u","v","w","x","y","z")
    $Numbers = ("2","3","4","5","6","7","8","9")
    $Symbols = ("?","@","#","$","%","&","*")

    Do {
    
        $Script:NewPassword = ''

         while ($NewPassword.Length -le $Password_Length) {

        
            #Random Seed to pick which char array a random item will be pulled from.

            $char_type_seed = Get-Random -Maximum 61

            switch ( $char_type_seed ) {


                #61 Total Characters so ranges have been updated to make sure someone doesn't get a password of all majority Symbols.


                {0..23 -contains $char_type_seed} {$char_type = $Uppers}
    
                {24..44 -contains $char_type_seed} {$char_type = $Lowers}

                {45..52 -contains $char_type_seed} {$char_type = $Numbers}

                {53..60 -contains $char_type_seed} {$char_type = $Symbols}


                }

                #"Pops" single character into Password string

                $Script:NewPassword += Get-Random -InputObject $char_type


            }
    

    } 
    
    #Checks that $Script:NewPassword Contains at least one character from each array,or regenerates until it does.

    Until(($null -ne ($Uppers | ? { $Script:NewPassword -cmatch $_ }))`
     -and ($null -ne ($Lowers | ? { $Script:NewPassword -cmatch $_ }))`
     -and ($null -ne ($Numbers | ? { $Script:NewPassword -cmatch $_ }))`
     -and ($null -ne ($Symbols | ? { $Script:NewPassword -cmatch [Regex]::Escape($_) })) )


    #SecureString Switch, nothing crazy I just got sick of converting these elsewhere in other scripts. 
    if ($SecureString) {

        $Script:NewPassword = $Script:NewPassword | ConvertTo-SecureString -AsPlainText -Force

        Return $Script:NewPassword
    }

    else {

        Return $Script:NewPassword

    }

}



Generate-SimplePassword -Password_Length 7

