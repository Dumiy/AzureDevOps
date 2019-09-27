Using module .\ReleaseDefinitionClass.psm1

Import-Module $PSScriptRoot\Library.psm

##############################################################################
##################### Token & Organization & Project #########################
##############################################################################
Set-AuthenticationHeader -Token "2rbnnuyzoz7jlitujxbadxt6otz2ccm6ll5qnockya46a2rqovca"
Set-Organization -Organization "CristianPreda" 
Set-Project -Project "DevOps_WinProject"
Set-ApiVersion -ApiVersion: "5.1"
##############################################################################

