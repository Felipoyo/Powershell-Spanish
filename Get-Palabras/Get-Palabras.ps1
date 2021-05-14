

function Get-Palabras {
<#
.SYNOPSIS
  Cuenta palabras dentro de un fichero
.DESCRIPTION
  Se obtendra el la cantidad de palabras que contiene un texto
.PARAMETER Fichero
    Rutal del archivo a analizar
.PARAMETER Repetido
    Para uso futuro
.INPUTS
  Archivo en texto plano
.OUTPUTS
  Integer numero de palabras
.NOTES
  Version:        1.0
  Author:         Felipoyo
  Creation Date:  13/05/2021
  Purpose/Change: Initial script development
  
.EXAMPLE
  Get-Palabras -Fichero "C:\Users\XXXXX\Desktop\palabras.txt"



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
    $resultado 
    Write-Host "Contando palabras del archivo $($Fichero)"
    $contenido = Get-Content -LiteralPath $Fichero
    $contenido| foreach{
    $linea = $_
     $resultado  = $resultado +  $linea.replace(".","").replace(";","").replace(",","").Split(" ").Split("`t").Count
    }

    Return [int]$resultado
}

Get-Palabras -Fichero "C:\Users\XXXXX\Desktop\demowords.txt"