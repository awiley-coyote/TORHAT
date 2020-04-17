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
    while($true) {
        Write-Host "1. Launch GUI"
        Write-Host "2. Continue in console"
        Write-Host "0. Exit"
        $choice = Read-Host "How would you like to proceed?"
        if($choice -eq 0) {
            break
        }
        elseif($choice -eq 1) {
            Write-Output "This feature is not currently supported"
        }
        elseif($choice -eq 2) {
            $app = [ConsoleApp]::new()
            $app.ad_module_exists = $ad_module_exists
            $app.console_main()
        }
        else {
            Write-Host "Invalid Choice"
        }
    }
}
class ConsoleApp {
    [string]$global_path = "$env:HomePath\Desktop\Analysis"
    [bool] $ad_module_exists = $false
    [String] $ipaddr = $(Test-Connection -ComputerName $env:ComputerName -Count 1  | Select IPV4Address)
    [bool] $remote = $false
    [void] console_main () {
        $test = 0
        $hostnames = @()
        #goes through and gets the IP information, will loop until valid ips are given or three times, whichever comes first
        while($true) {
            $hostnames = $this.get_hostnames()
            if($hostnames -eq $null -or $hostnames.length -eq 0) {
                Write-Host "There was an error with your input"
            }
            else {
                break
            }
            if($test -eq 2) {
                return
            }
            $test += 1
        }
        Clear-Host
        $data = ""
        while($true) {
            Write-host "1. System Logs"
            Write-host "2. Security Logs"
            Write-host "3. Application Logs"
            Write-Host "4. Processes"
            Write-Host "5. Services"
            Write-Host "6. Connections"
            Write-Host "7. Registry"
            Write-Host "8. Active Directory"
            Write-Host "9. Scheduled Tasks"
            Write-Host "10. Files"
            Write-host "0. Exit"
            $choice = Read-Host "What would you like to scan? (if you would like to do multiple scans seperate with commas, use a - to input a range)"
            #multiple scans need to be done
            if($choice -match "," -or $choice -match "-") {
                $arr_choice = [System.Collections.ArrayList]@()
                $choice.Split(",") | %{$arr_choice.add($_)}
                #deal with ranges first 
                $temp = @()
                $temp += $arr_choice
                foreach($choice in $temp) {
                    if($choice -match "-") {
                        $range_nums = $choice.split("-")
                        $arr_choice.remove($choice)
                        $begin = $range_nums[0]
                        $end = $range_nums[1]
                        try {
                            $begin = [int] $begin.trim()
                            $end = [int] $end.trim()
                        }
                        catch [System.Management.Automation.PSInvalidCastException] {
                            Write-Host "There was an error with the range $choice"
                            continue
                        }
                        $begin..$end | %{$arr_choice.add($_)}
                    }
                }
                #make sure that $arr_choice does not have any duplicates
                $arr_choice = $($arr_choice | Sort -Unique)
                $data = [System.Collections.ArrayList]@()
                foreach($choice in $arr_choice) {
                    #if $choice is a string, need to attempt to convert to an int
                    if($choice -is [string]) {
                        try {
                           $choice = [int]$choice.trim()
                        }
                        #will catch if they enter a non numerical value
                        catch [System.Management.Automation.PSInvalidCastException]{
                            Write-Host "There was an error with the input $choice"
                        }
                    }
                    $scan_data = $this.get_choice($choice, $hostnames)
                    #if this is null, then there was an error getting the data
                    if($scan_data -ne $null) {
                        $data.add($scan_data)
                    }
                }
                #if $data.length is 0, then the user failed to enter any valid choices
                if($data.length -eq 0) {
                    Write-Host "No data was found with the given scan input. Please try again"
                    Start-Sleep 2
                    Clear-Host
                }
                else {
                    break
                }
            }
            #only one scan
            else {
                try {
                    $choice = [int]$choice
                }
                #will catch if they enter a non numerical value
                catch [System.Management.Automation.PSInvalidCastException]{
                    Write-Host "$choice is not valid. Please try again"
                    Start-Sleep 2
                    Clear-Host
                    return
                }
                #if $choice is 0, break
                if($choice -eq 0) {
                    return
                }
                #otherwise, get the array of data from the choice function
                else {
                    $data = $this.get_choice($choice, $hostnames)
                    if($data -ne $null) {
                        break
                    }
                    else {
                        Clear-Host
                        Write-Host "No data was found with the given scan input. Please try again"
                        Start-Sleep 2
                    }
                }
            }
        }
        Clear-Host
        #check how they would like to output the data
        while($true) {
            Write-Host "1. Display"
            Write-Host "2. Text"
            Write-Host "3. Both"
            Write-Host "0. Exit" 
            $choice = Read-Host "How would you like your data to be output?"  #NEED TO ADD FUNCTIONALITY FOR MULTIPLE OUTPUTS
            #multiple outputs 
            if($choice -match ",") {
                Write-Host "Multiple Outputs is not currently supported"
                break
            }
            #only one OUTPUT
            else {
                try {
                $choice = [int]$choice
                }
                #will catch if they enter a non numerical value
                catch [System.Management.Automation.PSInvalidCastException]{
                    Write-Host "$choice is not valid. Please try again"
                    Start-Sleep 2
                    Clear-Host
                    continue
                }
                #if $choice is 0, break
                if($choice -eq 0) {
                    break
                }
                elseif($choice -eq 1) {
                    $this.out_display($data)
                    break
                }
                elseif($choice -eq 2) {
                    $path = $this.out_text($data)
                    Write-Host "Saving to $path"
                    Start-Sleep 2
                    break
                }
                elseif($choice -eq 3) {
                    $path = $this.out_text($data)
                    Write-Host "Saving to $path"
                    Start-Sleep 2
                    $this.out_display($data)
                    break
                }
            }
        }

    }
    #gets ips and validates them, then converts them to hostnames. Will return null if an error occurs
    [array] get_hostnames() {
        #used to add file functionality in the future
        $file = Read-Host "Would you like to upload a file of ips?(Y/N)"
        $ips = [System.Collections.ArrayList]@()
        if($file -match "y") {
            $PathVariable = Read-Host "Please enter the full path to file"
            Get-Content $PathVariable | %{if($this.valid_ip($_) -and $(Test-Connection $_ -Quiet)) {$ips.add($_)}}
        } 
        else {
            $ip = Read-Host "Enter IP(s) to scan. For multple ips, please seperate with a comma or use cidr notation"
            #multple ips/network ids with cidrs was entered
            if($ip -match ",") {
                $split = $ip.split(",")
                foreach($s in $split) {
                    $s = $s.trim()
                    if($s -match "/") {
                         $network_and_cidr = $s.split("/")
                         $network = $network_and_cidr[0]
                         $cidr = $network_and_cidr[1]
                         $subnet = $this.get_subnet($network, $cidr)
                         foreach($n in $subnet) {
                            $valid = $this.valid_ip($n)
                            if($valid) {
                                if(Test-Connection $n -Quiet) {
                                    if($n -ne $this.ipaddr) {
                                        $this.remote = $true
                                    }
                                    $ips.add($n)
                                }
                                
                            }
                         }
                    }
                    else {
                      $valid = $this.valid_ip($s)
                      if($valid) {
                          if(Test-Connection $s -Quiet) {
                                if($s -ne $this.ipaddr) {
                                    $this.remote = $true
                                }
                                $ips.add($s)
                          }
                      }  
                    }
                } 
            }
            #one network with cidr was entered
            elseif($ip -match "/") {
                $network_and_cidr = $ip.split("/")
                $network = $network_and_cidr[0]
                $cidr = $network_and_cidr[1]
                $ips = $this.get_subnet($network, $cidr)
            }
            #only one ip was entered
            else {
                $valid = $this.valid_ip($ip)
                if($valid) {
                    if(Test-Connection $ip -Quiet) {
                        if($ip -ne $this.ipaddr) {
                            $this.remote = $true
                        }
                        $ips.add($ip)
                    }
                }
            }
              
        }
        #means all ips that were entered were invalid in some way
        if($ips.length -eq 0) {
            return $null
        }
        $hostnames = [System.Collections.ArrayList]@() 
        foreach($ip in $ips) {
            try {
                 $hostname = [System.Net.DNS]::GetHostByAddress($ip).Hostname
            }
            #invalid ip slipped through the cracks
            catch [System.Management.Automation.MethodInvocationException] {
                continue
            }
            $hostnames.add($hostname)
        }
        return $hostnames 

    }
    #calls the appropriate function for the given choice. Will return $null if it encounters an error.
    [array] get_choice ([int] $choice, [array] $hostnames) {
        $data = [System.Collections.ArrayList]@()
        foreach($hostname in $hostnames) {
            if($choice -eq 1) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_syslogs()}
                }
                else {
                    $scan_data = $this.get_syslogs()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 2) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_seclogs()}
                }
                else {
                    $scan_data = $this.get_seclogs()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 3) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_applogs()}
                }
                else {
                    $scan_data = $this.get_applogs()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 4) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_processes()}
                }
                else {
                    $scan_data = $this.get_processes()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 5) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_services()}
                }
                else {
                    $scan_data = $this.get_services()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 6) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_connections()}
                }
                else {
                    $scan_data = $this.get_connections()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 7) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_registry()}
                }
                else {
                    $scan_data = $this.get_registry()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 8) {
                if($this.ad_module_exists) {
                    $scan_data = $this.get_adUsers($hostname)
                    if($scan_data -ne $null) {
                        $data.add($scan_data)
                    }
                }
                else {
                    return $null
                }
            }
            elseif($choice -eq 9) {
               if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_schtasks()}
                }
                else {
                    $scan_data = $this.get_schtasks()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            elseif($choice -eq 10) {
                if($this.remote -and $hostname -ne $env:ComputerName) {
                    $scan_data = Invoke-Command -ComputerName $hostname -ScriptBlock {$this.get_files()}
                }
                else {
                    $scan_data = $this.get_files()
                }
                if($scan_data -ne $null) {
                    $data.add($scan_data)
                }
            }
            #this means the choice is invalid
            else {
                return $null
            }

        }
        return $data

    }
    #checks if an ip is valid. Doesn't check class (yet) just that all octets are less that 255 and that there aren't any extra characters
    [bool] valid_ip($ip) {
        $octets = $ip.split(".")
        #check that there are 4 and only 4 octets
        if($octets.length -ne 4) {
            return $false
        }
        #check that each octet is a number less than 255
        foreach($octet in $octets) {
            try {
                $octet = [int] $octet
            }
            #will catch if there was an issue converting to integer
            catch [System.Management.Automation.PSInvalidCastException] {
                return $false
            }
            if($octet -lt 0 -or $octet -ge 255) {
                return $false
            }
        }
        return $true
    }

    #gets all the ips in a subnet, not including the broadcast ip. Returns null if there is an error
    [array] get_subnet($network, $cidr) {
       #check that the cidr is valid
       try {
            $cidr = [int] $cidr
       }
       catch [System.Management.Automation.PSInvalidCastException]{
            return $null
       }
       if($cidr -ge 32 -or $cidr -lt 8) {
            return $null
       }
       $begin = 0
       $ips = [System.Collections.ArrayList]@()
       $hosts = [math]::pow(2, (32 - $cidr))
       $hosts -= 2
       $network_id = ""
       $octet_number = 0
       #figure out how many octets the cidr covers
       switch ($cidr) {
            #operating in second octet (program won't accept a cidr less than 8)
            {$_ -le 16} {
                $begin = $network.split(".")[1] +1
                $network_id = $network.split(".")[0]
                $octet_number = 2
                break
            }
            #operating in the third octet
            {$_ -lt 24} {
                $begin = $network.split(".")[2] +1
                $network_id = $network.split(".")[0..1].join(".")
                $octet_number = 3
                break
            }
            #operating in the last octet
            {$_ -lt 32} {
                $begin = $network.split(".")[3] +1
                $network_id = $network.split(".")[0..2] -join "."
                $octet_number = 4
            }
       }
       $end = [int]$begin + [int]$hosts
       #working in the last octet
       if($octet_number -eq 4) {
            $begin..$end | Foreach-Object {$ips.add("$network_id.$_")} > $null
       }
       #working in the 3rd octet
       elseif($octet_number -eq 3) {
            $begin..$end | ForEach-Object {$network_id = "$network_id.$_"; 0..254 | ForEach-Object {$ips.add("$network_id.$_")}} > $null
       } 
       #working in the 2nd octet.
       else {
            $begin..$end | ForEach-Object {$octet_two = "$network_id.$_"; 0..254 | ForEach-Object {$octet_three = "$octet_two.$_"; 0..254 | ForEach-Object{$ips.add("$octet_three.$_")}}}  >> $null
       }
       return $ips
       
    }
    

    #Gets all Security logs on specified system from last 24 hours
    [string] get_secLogs() {
        #get logs for last 24 hours
        $events =  Get-EventLog -LogName "Security" -InstanceID 4688,4624,5140,5156,7045,4663 -After (Get-Date).AddDays(-7) | Format-list | Out-String
        return $events
    }


    #Gets all System logs on specified system from last 24 hours
    [string]get_sysLogs() {
        #get logs for last 24 hours
        $events = Get-EventLog -LogName "System" -After (Get-Date).AddHours(-24) | Format-list | Out-String
        return $events
    }

    #Gets all Application logs on specified system from last 24 hours
    [string]get_appLogs() {
        #get logs for last 24 hours
        $events = Get-EventLog -LogName "Security" -After (Get-Date).AddHours(-24) | Format-list | Out-String
        return $events
    }
    #Gets a list of processes on the specified system
    [string]get_processes() {
            return Get-Process  |  Out-String
    }

    #gets the services on the specified system
    [string]get_services() {
        return Get-Service | ?{$_.Status -match "Running"} |  Out-String
    }

    #Gets the TCP COnnections on the specified system
    [string]get_connections() {
        $data = Get-NetTCPConnection | Out-String
        return $data
     }

    #Gets the registry information on the specified system
    [array]get_registry() {
        $keys = @(
                    ‘HKCU:\Software\Microsoft\Windows\CurrentVersion\Run’,
                    ‘HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce’,
                    ‘HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run’,
                    ‘HKLM:\SYSTEM\ControlSet002\Control\Session Manager’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot’,
                    ‘HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders’,
                    ‘HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders’,
                    ‘HKLM:\SYSTEM\CurrentControlSet\services’,
                    ‘HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce’,
                    ‘HKLM:\Software\Microsoft\Windows\CurrentVersion\RunServices’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects’,
                    ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs’,
                    ‘HKLM:\Software\Classes\’,
                    ‘HKCR:\‘,
                    ‘HKCR:\textfile\shell\open\command’,
                    ‘HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs’ 

                )
        #HKLM and HKCU are mounted by default. HKCR is not, so we have to check if it exists
        if((Test-Path HKCR:\) -eq $false) {
            #this is mount HKCR. Since we don't have the -persistant, the drive will only last for this powershell session
            New-PSDrive -Name HKCR -PSProvider Registry -Root registry::HKEY_CLASSES_ROOT
        }
        $data = [System.Collections.ArrayList]@()
        foreach ($key in $keys) {
             $d = Get-ChildItem $key | Out-String
             $data.add($d)
        }
        return $data
    
    }

    #gets the AD Users on the specified system
    [string]get_adUsers() {
       return Get-AdUser -Filter 'Enabled -eq $false' | out-String
    }

    #gets the scheduled tasks on the specified system
    [array]get_schTasks() {
        return get-scheduledtask | Where-Object {$_.state -match "Ready"} | Out-String
    }

    #gets the .exe and .ps1 files on the specified system
    [array]get_files() {
        return Get-ChildItem -Path "C:\" -Include *.ps1,*.exe -Recurse -File | Out-String
    }


    #writes data to the screen
    [void]out_display($data) {
        Write-Host $data
    }
    #writes the data to a file
    [string]out_text($data) {
        if(-not $(Test-Path $this.global_path)) {
            New-Item -type Directory -Path $this.global_path
        }
        $file = "Scans_" + $(Get-Date -Format yyyyMMMMdd-HHmm)
        $file_path = $this.global_path + "\$file"
        $data | Out-File $file_path
        return $file_path
    }


}
main_menu