function Global:Get-Palabras {#Espublico
<#
.SYNOPSIS
  Cuenta palabras dentro de un fichero ejemplo de funcion privada y funcion global
.DESCRIPTION
  Se obtendra el la cantidad de palabras que contiene un texto
.PARAMETER Fichero
    Rutal del archivo a analizar
.PARAMETER Repetido
   Por defecto no se contaran palabras repetidas
   Si desea obtener el total de palabras asigne  $false
.INPUTS
  Archivo en texto plano
.OUTPUTS
  Integer numero de palabras
.NOTES
  Version:        1.1
  Author:         Felipoyo
  Creation Date:  13/05/2021
  Purpose/Change: Se agrega funcionalidad de palabras repetidas.
  
.EXAMPLE
  Get-Palabras -Fichero "C:\Users\XXXXX\Desktop\palabras.txt"  
  Get-Palabras -Fichero "C:\Users\XXXXX\Desktop\demowords.txt"  -Repetido:$false
#>
    Param(
        # Parametro: Fichero : Obligatorio, String
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [string]
        $Fichero,
        #Parametro: Repetido : Opcional, Boolean = $true
        [bool]
        $Repetido = $true #valur por default
    )
        function  Private:Find-Contenido{#Es privada
         Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [string]
        $Ruta
 
        )
    $contenido = Get-Content -LiteralPath $Ruta
    $contenido| foreach{
    $linea = $_
    $palabrasdelinea = $linea.replace(".;,`r`n`0","").Split(" ").Split("`t")
    $palabras += $palabrasdelinea
    Return  $palabras
}
}
    $palabras = @()
    Write-debug "Contando palabras del archivo $($Fichero)"
   
    $palabras = Find-Contenido -Ruta $Fichero
 
    if($Repetido -eq $false){
      
      $resultado  =  $($palabras | Where-Object { $_ -ne "" }).count
    
     }else{
     $resultado  =   $($palabras | Where-Object { $_ -ne "" } | select  -Unique).count
     
     }
    Return [int]$resultado

}
