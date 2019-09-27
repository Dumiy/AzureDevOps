function Get-VstsReleaseDefinition {
    param (
        [Parameter(Mandatory = $false)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $Uri = "https://vsrm.dev.azure.com/"  
    $Uri += Get-OrganizationAndProjectForURI
    $Uri += "/_apis/release/definitions/"

    if ($null -ne $DefinitionID) {
        $DefinitionID = [uint64] $DefinitionID
        $Uri += "/" + $DefinitionID
    }

    $Uri += "?"

    if ($null -eq $DefinitionID) {
        $Uri += "propertyFilters=all&"
    }

    $Uri += "api-version="
    if ($null -ne $ApiVersion) {
        $ApiVersion = [string] $ApiVersion
        $Uri += $ApiVersion
    }
    else {
        $Uri += Get-ApiVersion
    }

    $ReleaseDefinition = Invoke-RestMethod -Method Get -Uri $Uri -Headers (Get-AuthenticationHeader)
    return $ReleaseDefinition
}

function Get-VstsReleaseDefinitionStage {
    param (
        [Parameter(Mandatory = $true)] $DefinitionID, # Uint64
        [Parameter(Mandatory = $true)] $StageName, # String
        [Parameter(Mandatory = $false)] $ApiVersion # String
    )

    $ReleaseDefinition = Get-VstsReleaseDefinition -DefinitionID $DefinitionID -ApiVersion $ApiVersion

    $StageReturned = $null
    foreach ($Stage in $ReleaseDefinition.environments) {
        if ($Stage.name -eq $StageName) {
            $StageReturned = $Stage
            break
        }
    }

    return $StageReturned
}