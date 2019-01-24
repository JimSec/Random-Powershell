function Generate-SimplePassword() {

#Funtion to genereate simple password, does not use "Hard" Chars (1, I, i, j, l, 0, O, o, !). This was developed because I got sick of generating random temp passwords and users not being able to read them. 
#Takes interger for Password Length


    Param([int]$Password_Length)

    #Char Arrays and empty password string

    $Uppers = ("A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z")
    $Lowers = ("a","b","c","d","e","f","g","h","k","m","n","q","r","s","t","u","v","w","x","y","z")
    $Numbers = ("2","3","4","5","6","7","8","9")
    $Symbols = ("?","@","#","$","%","&","*")

    $Script:NewPassword = ""

    while ($NewPassword.Length -lt $Password_Length) {

        
        #Random Seed to pick which char array a random item will be pulled from.
        #The char_type_seed used to have a maximum of 4, but due to passwords that were mostly symbols and numbers I changed it to a proportional pool, but left in the switch case because I like switch cases.


        $char_type_seed = Get-Random -Maximum 61

        switch ( $char_type_seed ) {


            {0..23 -contains $char_type_seed} {$char_type = $Uppers}
    
            {24..44 -contains $char_type_seed} {$char_type = $Lowers}

            {45..52 -contains $char_type_seed} {$char_type = $Numbers}

            {53..60 -contains $char_type_seed} {$char_type = $Symbols}


        }


        #"Pops" single character into Password string

        $Script:NewPassword += Get-Random -InputObject $char_type


    }


    Return $Script:NewPassword

}



Generate-SimplePassword -Password_Length 7

