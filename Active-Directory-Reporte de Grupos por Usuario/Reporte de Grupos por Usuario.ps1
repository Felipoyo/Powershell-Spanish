<#
-----users.csv--------
SamAccountName
SamAccountName1
SamAccountName2
SamAccountName3

-----end------
#>
#desde csv
  $usuarios = import-csv "C:\Temp\users.csv" 
  #por consulta
$usuarios = Get-ADUser -Filter * -SearchBase "OU=Usuarios,DC=DOMAIN,DC=MX" 
$object =  New-Object -TypeName PSCustomObject
$object | Add-Member -Name SamAccountName  -MemberType NoteProperty -Value $null
$object | Add-Member -Name GroupName -MemberType NoteProperty -Value $null
$object | Add-Member -Name GroupdistinguishedName -MemberType NoteProperty -Value $null

$reporte1 = @()
$usuarios.SamAccountName | ForEach-Object{
$user = $_ 
$grupos = Get-ADPrincipalGroupMembership  $user 
$grupos | ForEach-Object{
$grupo = $_
$object.SamAccountName = $user
$object.GroupName = "$($grupo.name)"
$object.GroupdistinguishedName = "$($grupo.distinguishedName)"
$reporte1 += $object | select *
}
}
$object1 =  New-Object -TypeName PSCustomObject
$object1 | Add-Member -Name SamAccountName  -MemberType NoteProperty -Value $null
$object1 | Add-Member -Name Grupos -MemberType NoteProperty -Value $null

$reporte2 = @()

$reportee | Group-Object SamAccountName | ForEach-Object{
$linea = $_ 
[string]$losgrupos=   $linea.group.GroupName -join ','
 $object1.Grupos = $losgrupos.Substring(0,$losgrupos.Length-1)
 $object1.SamAccountName = $linea.Name
 $reporte2 +=  $object1 | select *
}
$reporte1 | export-csv reporte1.csv -NoTypeInformation -Delimiter ";"
$reporte2  | export-csv reporte2.csv -NoTypeInformation -Delimiter ";"