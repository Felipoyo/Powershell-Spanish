<#
Unate a https://t.me/PowershellSpanish en Telegram
#>
$criterios = @()
$criterios | Add-Member -NotePropertyName criterio -NotePropertyValue $null
$criterios | Add-Member -NotePropertyName destino -NotePropertyValue $null
$criterioObj = [PSCustomObject]@{
    Office     = 'Oficina1'
    OU = 'OU=Destino1,OU=Usuarios,DC=Dominio,DC=MX'  
}
$criterioObj2 = [PSCustomObject]@{
    Office     = 'Oficina2'
    OU = 'OU=Destino2,OU=Usuarios,DC=Dominio,DC=MX'   
}
$criterios += $CriterioObj
$criterios += $CriterioObj2

$usuarios = get-aduser -filter * -properties PhysicalDeliveryOfficeName 
$usuarios |ForEach-Object{
try{
     $usuario = $_
     $criterios | ForEach-Object{
     $criterio = $_
        if($usuario.PhysicalDeliveryOfficeName -eq $Criterio.Office){            
            Write-host "el ususario  $($usuario.samaccountname) se movera a la OU $($criterio.ou) "
            Move-ADObject  -Identity $usuario.DistinguishedName  -TargetPath  $($criterio.OU)   
        }
     }  

   }catch{
    $_
    }
}