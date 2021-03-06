function New-rVIHeader
{
    <#
	.DESCRIPTION
		Gather Credentials to to add to Connection headers.
	.EXAMPLE
        New-rViHeaders
	.EXAMPLE
        New-rViHeader -Credential $Credentials
    .EXAMPLE
        $script:header = New-rViHeaders
    .PARAMETER Credential
        A valid Credential set is required.
	.NOTES
		No notes at this time.
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    [OutputType([Hashtable])]
    [OutputType([boolean])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]$Credential
    )    
    begin 
    {
        # No pre-task
    }
    process
    {
        if ($pscmdlet.ShouldProcess("Creating Headers."))
        { 
            $auth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Credential.UserName + ':' + $Credential.GetNetworkCredential().Password))
            $script:headers = @{
                'Authorization' = "Basic $auth"
            }
            return $script:headers
        } 
        else
        {
            # -WhatIf was used.
            return $false
        }
    }    
}