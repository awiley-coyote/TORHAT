Import-Module "$PSScriptRoot\ConsoleApp.psm1"
Import-Module "$PSScriptRoot\GUIApp.psm1"
function main_menu() {
    Write-Output "'########::'#######::'########::'##::::'##::::'###::::'########:
... ##..::'##.... ##: ##.... ##: ##:::: ##:::'## ##:::... ##..::
::: ##:::: ##:::: ##: ##:::: ##: ##:::: ##::'##:. ##::::: ##::::
::: ##:::: ##:::: ##: ########:: #########:'##:::. ##:::: ##::::
::: ##:::: ##:::: ##: ##.. ##::: ##.... ##: #########:::: ##::::
::: ##:::: ##:::: ##: ##::. ##:: ##:::: ##: ##.... ##:::: ##::::
::: ##::::. #######:: ##:::. ##: ##:::: ##: ##:::: ##:::: ##::::
:::..::::::.......:::..:::::..::..:::::..::..:::::..:::::..:::::"
    #check if the activedirectory module is installed
    $ad_module_exists = $false
    #try to import the module
    try {
        Import-Module ActiveDirectory -ErrorAction Stop
        $ADModule = Get-Module -Name ActiveDirectory
	    if ($ADmodule -ne $null){
		    $ad_module_exists = $true
        }
        else{
		    write-host "The ActiveDirectory Module for Powershell is not installed. Without this module, you will not be able to do Active Directory scanning. If you wish to do Active Directory scanning, please install the module and restart this program"
        } 
    }
    catch [System.io.filenotfoundexception] {
       write-host "The ActiveDirectory Module for Powershell is not installed. Without this module, you will not be able to do Active Directory scanning. If you wish to do Active Directory scanning, please install the module and restart this program"
    }
    Start-Sleep 1
    #menu for the user to select console or gui
    while($true) {
        Write-Host "1. Launch GUI"
        Write-Host "2. Continue in console"
        Write-Host "0. Exit"
        $choice = Read-Host "How would you like to proceed?"
        #if $choice is 0, exit the program
        if($choice -eq 0) {
            break
        }
        #if $choice is 1, launch the gui
        elseif($choice -eq 1) {
            Gui
        }
        #if $choice is 2, launch the console app
        elseif($choice -eq 2) {
            $app = [ConsoleApp]::new()
            $app.ad_module_exists = $ad_module_exists
            $app.console_main()
        }
        else {
            Write-Host "$choice is invalid"
        }
    }
}
main_menu