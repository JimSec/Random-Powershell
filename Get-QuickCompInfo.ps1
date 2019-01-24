param( [string]$ip )
param( [PSCredential] $cred)

$command = {

    $username = $(Get-WMIObject -class Win32_ComputerSystem | select username).username
    $sn = $(Get-WmiObject win32_bios | select SerialNumber).SerialNumber

    $return_obj = [PSCustomObject]@{

        User  =  $username
        SerialTag = $sn
        Comp = $env:COMPUTERNAME


    }

    return $return_obj

}

if ($cred -ne $null) {

    Invoke-Command -ComputerName $ip -Credential $cred -ScriptBlock $command

}

else {

     Invoke-Command -ComputerName $ip -ScriptBlock $command

}
