function GUI{
#################################
#          GUI Design           #
#                               #
#################################

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#Sets the inital size of the program frame
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '1200,685'
$Form.text                       = "TORHat"
$Form.TopMost                    = $True
$Form.Location                   = '100,200'

#################################
#    Active Directory Module    #
#                               #
#################################

#Check if Active Directory Module is installed
Import-Module ActiveDirectory -ErrorAction SilentlyContinue
#$ADModule = Get-Module -Name ActiveDirectory

#If Active Directory Module is not installed, produce error and close program
#if ($ADModule -eq $null) {
#    Add-Type -AssemblyName PresentationCore,PresentationFramework
#    $OkCancelButtonType = [System.Windows.MessageBoxButton]::OkCancel
#    $ADErrorTitle = “Missing Active Directory Module”
#    $ADErrorMessage = “Install the Active Directory Module before using this program.”
#    $ErrorIcon = ([System.Windows.MessageBoxImage]::Error)
#    [System.Windows.MessageBox]::Show($ADErrorMessage,$ADErrorTitle,$OkCancelButtonType,$ErrorIcon)
    #exit
#}

#################################
#          Target Host          #
#                               #
#################################

#Creates the "Target Host:" label
$TargetHostLabel                          = New-Object system.Windows.Forms.Label
$TargetHostLabel.text                     = "Target Host:"
$TargetHostLabel.AutoSize                 = $true
$TargetHostLabel.width                    = 25
$TargetHostLabel.height                   = 10
$TargetHostLabel.location                 = New-Object System.Drawing.Point(10,19)
$TargetHostLabel.Font                     = 'Microsoft Sans Serif,16'

#Creates the text box for entering the target host IP Address
$HostIPTextBox                        = New-Object system.Windows.Forms.TextBox
$HostIPTextBox.multiline              = $false
$HostIPTextBox.width                  = 139
$HostIPTextBox.height                 = 20
$HostIPTextBox.location               = New-Object System.Drawing.Point(7,41)
$HostIPTextBox.Font                   = 'Microsoft Sans Serif,10'

#Creates the "Test Connection" button
$TestConnection                  = New-Object system.Windows.Forms.Button
$TestConnection.text             = "Test Connection"
$TestConnection.width            = 140
$TestConnection.height           = 30
$TestConnection.location         = New-Object System.Drawing.Point(7,65)
$TestConnection.Font             = 'Microsoft Sans Serif,12'

#Adds a function to the "Test Connection" button once clicked
$TestConnection.Add_Click($ClickTesting)

#################################
#          Scan Type            #
#                               #
#################################

#Creates the "Scan Type:" label
$ScanTypeLabel                   = New-Object system.Windows.Forms.Label
$ScanTypeLabel.text              = "Scan Type:"
$ScanTypeLabel.AutoSize          = $true
$ScanTypeLabel.width             = 25
$ScanTypeLabel.height            = 10
$ScanTypeLabel.location          = New-Object System.Drawing.Point(14,110)
$ScanTypeLabel.Font              = 'Microsoft Sans Serif,16'

#Creates the "Application Logs" Check box
$Application                     = New-Object system.Windows.Forms.CheckBox
$Application.text                = "Application Logs"
$Application.AutoSize            = $false
$Application.width               = 150
$Application.height              = 18
$Application.location            = New-Object System.Drawing.Point(20,184)
$Application.Font                = 'Microsoft Sans Serif,10'
#Creates the "Security Logs" Check box
$Security                        = New-Object system.Windows.Forms.CheckBox
$Security.text                   = "Security Logs"
$Security.AutoSize               = $false
$Security.width                  = 150
$Security.height                 = 18
$Security.location               = New-Object System.Drawing.Point(20,144)
$Security.Font                   = 'Microsoft Sans Serif,10'

#Creates the "System Logs" Check box
$System                          = New-Object system.Windows.Forms.CheckBox
$System.text                     = "System Logs "
$System.AutoSize                 = $false
$System.width                    = 150
$System.height                   = 18
$System.location                 = New-Object System.Drawing.Point(20,164)
$System.Font                     = 'Microsoft Sans Serif,10'

#Creates the "IIS Logs" Check box
#$IIS                             = New-Object system.Windows.Forms.CheckBox
#$IIS.text                        = "IIS Logs"
#$IIS.AutoSize                    = $false
#$IIS.width                       = 150
#$IIS.height                      = 18
#$IIS.location                    = New-Object System.Drawing.Point(20,204)
#$IIS.Font                        = 'Microsoft Sans Serif,10'

#Creates the "Process" Check box
$Process                         = New-Object system.Windows.Forms.CheckBox
$Process.text                    = "Process"
$Process.AutoSize                = $false
$Process.width                   = 150
$Process.height                  = 18
$Process.location                = New-Object System.Drawing.Point(20,204)
$Process.Font                    = 'Microsoft Sans Serif,10'

#Creates the "Services" Check box
$Services                        = New-Object system.Windows.Forms.CheckBox
$Services.text                   = "Services"
$Services.AutoSize               = $false
$Services.width                  = 150
$Services.height                 = 18
$Services.location               = New-Object System.Drawing.Point(20,224)
$Services.Font                   = 'Microsoft Sans Serif,10'

#Creates the "Connections" Check box
$Connections                     = New-Object system.Windows.Forms.CheckBox
$Connections.text                = "Connections"
$Connections.AutoSize            = $false
$Connections.width               = 150
$Connections.height              = 18
$Connections.location            = New-Object System.Drawing.Point(20,244)
$Connections.Font                = 'Microsoft Sans Serif,10'

#Creates the "Registry" Check box
$Registry                        = New-Object system.Windows.Forms.CheckBox
$Registry.text                   = "Registry"
$Registry.AutoSize               = $false
$Registry.width                  = 150
$Registry.height                 = 18
$Registry.location               = New-Object System.Drawing.Point(20,264)
$Registry.Font                   = 'Microsoft Sans Serif,10'

#Creates the "AD Users" Check box
$ADUsers                         = New-Object system.Windows.Forms.CheckBox
$ADUsers.text                    = "AD Users"
$ADUsers.AutoSize                = $false
$ADUsers.width                   = 150
$ADUsers.height                  = 18
$ADUsers.location                = New-Object System.Drawing.Point(20,284)
$ADUsers.Font                    = 'Microsoft Sans Serif,10'

#Creates the "Scheduled Task" Check box
$Scheduled                       = New-Object system.Windows.Forms.CheckBox
$Scheduled.text                  = "Scheduled Task"
$Scheduled.AutoSize              = $false
$Scheduled.width                 = 150
$Scheduled.height                = 18
$Scheduled.location              = New-Object System.Drawing.Point(20,304)
$Scheduled.Font                  = 'Microsoft Sans Serif,10'

#Creates the "Files" Check box
$Files                           = New-Object system.Windows.Forms.CheckBox
$Files.text                      = "Files"
$Files.AutoSize                  = $false
$Files.width                     = 150
$Files.height                    = 18
$Files.location                  = New-Object System.Drawing.Point(20,324)
$Files.Font                      = 'Microsoft Sans Serif,10'

#################################
#          Output Type          #
#                               #
#################################

#Creates the "Output Type:" label
$OutputTypeLabel                 = New-Object system.Windows.Forms.Label
$OutputTypeLabel.text            = "Output Type:"
$OutputTypeLabel.AutoSize        = $true
$OutputTypeLabel.width           = 25
$OutputTypeLabel.height          = 10
$OutputTypeLabel.location        = New-Object System.Drawing.Point(12,369)
$OutputTypeLabel.Font            = 'Microsoft Sans Serif,14'

#Creates the "Display" Check box
$Display                         = New-Object system.Windows.Forms.CheckBox
$Display.text                    = "Display"
$Display.AutoSize                = $false
$Display.width                   = 150
$Display.height                  = 18
$Display.location                = New-Object System.Drawing.Point(20,403)
$Display.Font                    = 'Microsoft Sans Serif,10'

#Creates the ".Txt" Check box
$Txt                             = New-Object system.Windows.Forms.CheckBox
$Txt.text                        = ".Txt"
$Txt.AutoSize                    = $false
$Txt.width                       = 150
$Txt.height                      = 18
$Txt.location                    = New-Object System.Drawing.Point(20,423)
$Txt.Font                        = 'Microsoft Sans Serif,10'

#Creates the ".Json" Check box
#$Json                            = New-Object system.Windows.Forms.CheckBox
#$Json.text                       = ".Json"
#$Json.AutoSize                   = $false
#$Json.width                      = 95
#$Json.height                     = 18
#$Json.location                   = New-Object System.Drawing.Point(20,457)
#$Json.Font                       = 'Microsoft Sans Serif,10'

#Creates the ".pdf" Check box
$Analysis                             = New-Object system.Windows.Forms.CheckBox
$Analysis.text                        = "Grid view Analysis"
$Analysis.AutoSize                    = $false
$Analysis.width                       = 150
$Analysis.height                      = 18
$Analysis.location                    = New-Object System.Drawing.Point(20,443)
$Analysis.Font                        = 'Microsoft Sans Serif,10'

#################################
#         Scan/Progress         #
#                               #
#################################

#Creates the "Scan Host" button
$ScanHost                        = New-Object system.Windows.Forms.Button
$ScanHost.text                   = "Scan Host"
$ScanHost.width                  = 125
$ScanHost.height                 = 30
$ScanHost.location               = New-Object System.Drawing.Point(12,520)
$ScanHost.Font                   = 'Microsoft Sans Serif,14'

#Temporary Progress Bar
$ProgressBar             = New-Object system.Windows.Forms.ProgressBar
$ProgressBar.width        = 140
$ProgressBar.height       = 20
$ProgressBar.location     = New-Object System.Drawing.Point(8,560)
$progressbar.Maximum = $files.Count
$progressbar.Step = 1
$progressbar.Value = 0
#Creates the progress bar with text overlay
#$ProgressBarOverlay              = New-Object system.Windows.Forms.ProgressBar
#$ProgressBarOverlay.width        = 138
#$ProgressBarOverlay.height       = 15
#$ProgressBarOverlay.location     = New-Object System.Drawing.Point(8,560)
#For reference on intended use
#https://www.sapien.com/blog/2019/03/20/progress-bar-series-part-3-handling-progress-status-information-in-a-gui-application/
#Will need to increase the size of the box to fit text

#################################
#              TABS             #
#                               #
#################################

#Creates Tab System with tab pages
[System.Windows.Forms.TabControl]$tabMainDisplay = $null
[System.Windows.Forms.TabPage]$tabPageSecurity = $null
[System.Windows.Forms.DataGridView]$gridSecurity = $null
[System.Windows.Forms.TabPage]$tabPageSystem = $null
[System.Windows.Forms.DataGridView]$gridSystem = $null
[System.Windows.Forms.TabPage]$tabPageApplication = $null
[System.Windows.Forms.DataGridView]$gridApplication = $null
[System.Windows.Forms.TabPage]$tabPageIIS = $null
#[System.Windows.Forms.DataGridView]$gridIIS = $null
[System.Windows.Forms.TabPage]$tabPageProcesses = $null
[System.Windows.Forms.DataGridView]$gridProcesses = $null
[System.Windows.Forms.TabPage]$tabPageServices = $null
[System.Windows.Forms.DataGridView]$gridServices = $null
[System.Windows.Forms.TabPage]$tabPageConnections = $null
[System.Windows.Forms.DataGridView]$gridConnections = $null
[System.Windows.Forms.TabPage]$tabPageRegistry = $null
[System.Windows.Forms.DataGridView]$gridRegistry = $null
[System.Windows.Forms.TabPage]$tabPageActiveD = $null
[System.Windows.Forms.DataGridView]$gridActiveD = $null
[System.Windows.Forms.TabPage]$tabPageSchTasks = $null
[System.Windows.Forms.DataGridView]$gridSchTasks = $null
[System.Windows.Forms.TabPage]$tabPageFiles = $null
[System.Windows.Forms.DataGridView]$gridFiles = $null
[System.Windows.Forms.ToolTip]$tipTargetHere = $null

$tabMainDisplay = (New-Object -TypeName System.Windows.Forms.TabControl)
$tabPageSecurity = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageSystem = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageApplication = (New-Object -TypeName System.Windows.Forms.TabPage)
#$tabPageIIS = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageProcesses = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageServices = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageConnections = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageRegistry = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageActiveD = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageSchTasks = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabPageFiles = (New-Object -TypeName System.Windows.Forms.TabPage)
$gridSecurity = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridSystem = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridApplication = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridIIS = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridProcesses = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridServices = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridConnections = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridRegistry = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridActiveD = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridSchTasks = (New-Object -TypeName System.Windows.Forms.DataGridView)
$gridFiles = (New-Object -TypeName System.Windows.Forms.DataGridView)
#$tipTargetHere = (New-Object -TypeName System.Windows.Forms.ToolTip -ArgumentList @($components) )

$tabMainDisplay.SuspendLayout()
$tabPageSecurity.SuspendLayout()
$tabPageSystem.SuspendLayout()
$tabPageApplication.SuspendLayout()
#$tabPageIIS.SuspendLayout()
$tabPageProcesses.SuspendLayout()
$tabPageServices.SuspendLayout()
$tabPageConnections.SuspendLayout()
$tabPageRegistry.SuspendLayout()
$tabPageActiveD.SuspendLayout()
$tabPageSchTasks.SuspendLayout()
$tabPageFiles.SuspendLayout()

([System.ComponentModel.ISupportInitialize]$gridSecurity).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridSystem).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridApplication).BeginInit()
#([System.ComponentModel.ISupportInitialize]$gridIIS).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridProcesses).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridServices).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridConnections).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridRegistry).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridActiveD).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridSchTasks).BeginInit()
([System.ComponentModel.ISupportInitialize]$gridFiles).BeginInit()

#Configures controls for tab system, enables individual tabs to be added to window
#
#tabMainDisplay
#
$tabMainDisplay.Controls.Add($tabPageSecurity)
$tabMainDisplay.Controls.Add($tabPageSystem)
$tabMainDisplay.Controls.Add($tabPageApplication)
#$tabMainDisplay.Controls.Add($tabPageIIS)
$tabMainDisplay.Controls.Add($tabPageProcesses)
$tabMainDisplay.Controls.Add($tabPageServices)
$tabMainDisplay.Controls.Add($tabPageConnections)
$tabMainDisplay.Controls.Add($tabPageRegistry)
$tabMainDisplay.Controls.Add($tabPageActiveD)
$tabMainDisplay.Controls.Add($tabPageSchTasks)
$tabMainDisplay.Controls.Add($tabPageFiles)
$tabMainDisplay.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]248,[System.Int32]12))
$tabMainDisplay.Name = [System.String]'tabMainDisplay'
$tabMainDisplay.SelectedIndex = [System.Int32]0
$tabMainDisplay.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]889,[System.Int32]649))
$tabMainDisplay.TabIndex = [System.Int32]0
#
#tabPageSecurity
#
$tabPageSecurity.Controls.Add($gridSecurity)
$tabPageSecurity.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageSecurity.Name = [System.String]'tabPageSecurity'
$tabPageSecurity.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$tabPageSecurity.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageSecurity.TabIndex = [System.Int32]0
$tabPageSecurity.Text = [System.String]'Security Logs'
$tabPageSecurity.UseVisualStyleBackColor = $true
#
#tabPageSystem
#
$tabPageSystem.Controls.Add($gridSystem)
$tabPageSystem.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageSystem.Name = [System.String]'tabPageSystem'
$tabPageSystem.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$tabPageSystem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageSystem.TabIndex = [System.Int32]1
$tabPageSystem.Text = [System.String]'System Logs'
$tabPageSystem.UseVisualStyleBackColor = $true
#
#tabPageApplication
#
$tabPageApplication.Controls.Add($gridApplication)
$tabPageApplication.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageApplication.Name = [System.String]'tabPageApplication'
$tabPageApplication.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageApplication.TabIndex = [System.Int32]2
$tabPageApplication.Text = [System.String]'Application Logs'
$tabPageApplication.UseVisualStyleBackColor = $true
$tabPageApplication.Visible = $false
#
#tabPageIIS
#
#$tabPageIIS.Controls.Add($gridIIS)
#$tabPageIIS.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
#$tabPageIIS.Name = [System.String]'tabPageIIS'
#$tabPageIIS.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
#$tabPageIIS.TabIndex = [System.Int32]3
#$tabPageIIS.Text = [System.String]'IIS Logs'
#$tabPageIIS.UseVisualStyleBackColor = $true
#$tabPageIIS.Visible = $false
#
#tabPageProcesses
#
$tabPageProcesses.Controls.Add($gridProcesses)
$tabPageProcesses.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageProcesses.Name = [System.String]'tabPageProcesses'
$tabPageProcesses.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageProcesses.TabIndex = [System.Int32]4
$tabPageProcesses.Text = [System.String]'Processes'
$tabPageProcesses.UseVisualStyleBackColor = $true
$tabPageProcesses.Visible = $false
#
#tabPageServices
#
$tabPageServices.Controls.Add($gridServices)
$tabPageServices.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageServices.Name = [System.String]'tabPageServices'
$tabPageServices.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageServices.TabIndex = [System.Int32]5
$tabPageServices.Text = [System.String]'Services'
$tabPageServices.UseVisualStyleBackColor = $true
$tabPageServices.Visible = $false
#
#tabPageConnections
#
$tabPageConnections.Controls.Add($gridConnections)
$tabPageConnections.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageConnections.Name = [System.String]'tabPageConnections'
$tabPageConnections.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageConnections.TabIndex = [System.Int32]6
$tabPageConnections.Text = [System.String]'Connections'
$tabPageConnections.UseVisualStyleBackColor = $true
$tabPageConnections.Visible = $false
#
#tabPageRegistry
#
$tabPageRegistry.Controls.Add($gridRegistry)
$tabPageRegistry.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageRegistry.Name = [System.String]'tabPageRegistry'
$tabPageRegistry.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageRegistry.TabIndex = [System.Int32]7
$tabPageRegistry.Text = [System.String]'Registry'
$tabPageRegistry.UseVisualStyleBackColor = $true
$tabPageRegistry.Visible = $false
#
#tabPageActiveD
#
$tabPageActiveD.Controls.Add($gridActiveD)
$tabPageActiveD.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageActiveD.Name = [System.String]'tabPageActiveD'
$tabPageActiveD.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageActiveD.TabIndex = [System.Int32]8
$tabPageActiveD.Text = [System.String]'AD Users'
$tabPageActiveD.UseVisualStyleBackColor = $true
$tabPageActiveD.Visible = $false
#
#tabPageSchTasks
#
$tabPageSchTasks.Controls.Add($gridSchTasks)
$tabPageSchTasks.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageSchTasks.Name = [System.String]'tabPageSchTasks'
$tabPageSchTasks.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageSchTasks.TabIndex = [System.Int32]9
$tabPageSchTasks.Text = [System.String]'Scheduled Tasks'
$tabPageSchTasks.UseVisualStyleBackColor = $true
$tabPageSchTasks.Visible = $false
#
#tabPageFiles
#
$tabPageFiles.Controls.Add($gridFiles)
$tabPageFiles.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabPageFiles.Name = [System.String]'tabPageFiles'
$tabPageFiles.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]881,[System.Int32]623))
$tabPageFiles.TabIndex = [System.Int32]10
$tabPageFiles.Text = [System.String]'Files'
$tabPageFiles.UseVisualStyleBackColor = $true
$tabPageFiles.Visible = $false
#
#gridSecurity
#
$gridSecurity.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridSecurity.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridSecurity.Name = [System.String]'gridSecurity'
$gridSecurity.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridSecurity.TabIndex = [System.Int32]0
#
#gridSystem
#
$gridSystem.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridSystem.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridSystem.Name = [System.String]'gridSystem'
$gridSystem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridSystem.TabIndex = [System.Int32]0
#
#gridApplication
#
$gridApplication.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridApplication.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridApplication.Name = [System.String]'gridApplication'
$gridApplication.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridApplication.TabIndex = [System.Int32]0
#
#gridIIS
#
#$gridIIS.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
#$gridIIS.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
#$gridIIS.Name = [System.String]'gridIIS'
#$gridIIS.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
#$gridIIS.TabIndex = [System.Int32]0
#
#gridProcesses
#
$gridProcesses.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridProcesses.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridProcesses.Name = [System.String]'gridProcesses'
$gridProcesses.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridProcesses.TabIndex = [System.Int32]0
#
#gridServices
#
$gridServices.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridServices.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridServices.Name = [System.String]'gridServices'
$gridServices.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridServices.TabIndex = [System.Int32]0
#
#gridConnections
#
$gridConnections.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridConnections.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridConnections.Name = [System.String]'gridConnections'
$gridConnections.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridConnections.TabIndex = [System.Int32]0
#
#gridRegistry
#
$gridRegistry.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridRegistry.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridRegistry.Name = [System.String]'gridRegistry'
$gridRegistry.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridRegistry.TabIndex = [System.Int32]0
#
#gridActiveD
#
$gridActiveD.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridActiveD.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridActiveD.Name = [System.String]'gridActiveD'
$gridActiveD.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridActiveD.TabIndex = [System.Int32]0
#
#gridSchTasks
#
$gridSchTasks.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridSchTasks.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridSchTasks.Name = [System.String]'gridSchTasks'
$gridSchTasks.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridSchTasks.TabIndex = [System.Int32]0
$gridSchTasks.add_CellContentClick($DataGridView5_CellContentClick)
#
#gridFiles
#
$gridFiles.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$gridFiles.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gridFiles.Name = [System.String]'gridFiles'
$gridFiles.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]875,[System.Int32]617))
$gridFiles.TabIndex = [System.Int32]0
$gridFiles.add_CellContentClick($DataGridView6_CellContentClick)
#
#tipTargetHere
#
#$tipTargetHere.ToolTipTitle = [System.String]'Enter an IP Address' 

#################################
#       BuildingStructure       #
#                               #
#################################

#Adds Tab System and formats controls to window
$Form.Controls.Add($tabMainDisplay)
$tabMainDisplay.ResumeLayout($false)
$tabPageSecurity.ResumeLayout($false)
$tabPageSystem.ResumeLayout($false)
$tabPageApplication.ResumeLayout($false)
#$tabPageIIS.ResumeLayout($false)
$tabPageProcesses.ResumeLayout($false)
$tabPageServices.ResumeLayout($false)
$tabPageConnections.ResumeLayout($false)
$tabPageRegistry.ResumeLayout($false)
$tabPageActiveD.ResumeLayout($false)
$tabPageSchTasks.ResumeLayout($false)
$tabPageFiles.ResumeLayout($false)

([System.ComponentModel.ISupportInitialize]$gridSecurity).EndInit()
([System.ComponentModel.ISupportInitialize]$gridSystem).EndInit()
([System.ComponentModel.ISupportInitialize]$gridApplication).EndInit()
#([System.ComponentModel.ISupportInitialize]$gridIIS).EndInit()
([System.ComponentModel.ISupportInitialize]$gridProcesses).EndInit()
([System.ComponentModel.ISupportInitialize]$gridServices).EndInit()
([System.ComponentModel.ISupportInitialize]$gridConnections).EndInit()
([System.ComponentModel.ISupportInitialize]$gridRegistry).EndInit()
([System.ComponentModel.ISupportInitialize]$gridActiveD).EndInit()
([System.ComponentModel.ISupportInitialize]$gridSchTasks).EndInit()
([System.ComponentModel.ISupportInitialize]$gridFiles).EndInit()

Add-Member -InputObject $Form -Name tabMainDisplay -Value $tabMainDisplay -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageSecurity -Value $tabPageSecurity -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridSecurity -Value $gridSecurity -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageSystem -Value $tabPageSystem -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridSystem -Value $gridSystem -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageApplication -Value $tabPageApplication -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridApplication -Value $gridApplication -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageIIS -Value $tabPageIIS -MemberType NoteProperty
#Add-Member -InputObject $Form -Name gridIIS -Value $gridIIS -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageProcesses -Value $tabPageProcesses -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridProcesses -Value $gridProcesses -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageServices -Value $tabPageServices -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridServices -Value $gridServices -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageConnections -Value $tabPageConnections -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridConnections -Value $gridConnections -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageRegistry -Value $tabPageRegistry -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridRegistry -Value $gridRegistry -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageActiveD -Value $tabPageActiveD -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridActiveD -Value $gridActiveD -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageSchTasks -Value $tabPageSchTasks -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridSchTasks -Value $gridSchTasks -MemberType NoteProperty
Add-Member -InputObject $Form -Name tabPageFiles -Value $tabPageFiles -MemberType NoteProperty
Add-Member -InputObject $Form -Name gridFiles -Value $gridFiles -MemberType NoteProperty
Add-Member -InputObject $Form -Name tipTargetHere -Value $tipTargetHere -MemberType NoteProperty

#Loads all form information into the form variable
$Form.controls.AddRange(@($Application,$Security,$System,$IIS,$Process,$Services,$Connections,$Registry,$ADUsers,$Scheduled,$Files,$Display,$Txt,$Json,$Analysis,$TestConnection,$ScanHost,$ProgressBar,$ProgressBarOverlay,$ProgressTextBox,$HostIPTextBox,$TargetHostLabel,$ScanTypeLabel,$DataGridView1,$OutputTypeLabel))


#Adds a functionality for Target Host text box once changed
$HostIPTextBox.Add_TextChanged({  })

#To test for IP Address/Hostname Resolution
$ScanHost.add_MouseClick($mclickScanHost)

#Adds a click function to the "Scan Host" button
$ScanHost.Add_Click({
$folder="$env:USERPROFILE\Desktop\Analysis" ; if(!([System.IO.directory]::Exists($folder))){ mkdir $env:USERPROFILE\Desktop\Analysis}
$mclickScanHost
#################################
#          Output Type          #
#                               #
#################################

if ($Display.Checked -eq $true) { $TOutdisplay = "1"}
if ($txt.Checked -eq $true) { $TOuttext = "1" }
if ($Analysis.Checked -eq $true) { $TOutAnalysis = "1"}
if ($IPAddr){$Pass = "1"}
####################################
#               Scans              #
####################################

if ($Application.Checked -eq $true) { APP{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass )}}
if ($Security.Checked -eq $true) { Sec{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass)}}
if ($System.Checked -eq $true) { Sys{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass)}}
if ($Process.Checked -eq $true) { Proc{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass)}}
if ($Services.Checked -eq $true) { service($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass){}}
if ($connections.Checked -eq $true) { conn{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass)}}
if ($ADUsers.Checked -eq $true) { ADUsers{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass )}}
#if ($IIS.Checked -eq $true) { IIS{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass )}}
if ($Scheduled.Checked -eq $true) { sch{($TOutdisplay,$TOuttext, $IPAddr,$TOutAnalysis,$Pass )}}
if ($Registry.Checked -eq $true) { reg{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass )}}
#if ($Files.Checked -eq $true) { file{($TOutdisplay,$TOuttext,$IPAddr,$TOutAnalysis,$Pass )}}

})

#Displays the base frame of the GUI Based on Above Paramaters
$Form.ShowDialog()
}
$clickTesting = {
      $global:address=$null
      $global:address=$HostIPTextBox.Text
      $pattern = "^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$"
      if ($global:address -match $pattern){
          $IPAddr = $global:address
         $HostIPTextBox.BackColor = "#23AB11"
          #Future connection test code here
      }
     if ($global:address -notmatch $pattern){
           Error{}
          #error handling here
          
      }
}
$mclickScanHost = {
      #for whatever reason just calling the function above always returns true, even with the false var
      $global:address=$null
      $global:address=$HostIPTextBox.Text
      $pattern = "^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$"
      if ($global:address -match $pattern){
          #put actual scan code here
          $IPAddr = $global:address
      }
      else{
      Error{}
          #handle error here, ip was not right
          
      }
}
function APP {
     $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
      $app = Get-WmiObject -class win32_ntlogevent -Filter "logfile='Application'" | select -Property sourcename, Eventcode, Logfile,message
      $Files=$app
       $progressbar.Maximum = $files.Count 
      foreach ($file in $Files){$progressbar.PerformStep()}
      if($Pass -eq "1"){ $app = Get-EventLog -LogName "Application" -ComputerName $IPAddr -After (Get-Date).AddHours(-24)  }

      if($TOutdisplay -eq "1"){$array.AddRange($app) ;$gridapplication.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $app > "$env:USERPROFILE\Desktop\Analysis\Application.txt" }
      if($TOutgridAnalysis -eq "1"){ $app| Out-GridView}
}
function sec {
      $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
      $sec = Get-WmiObject -class win32_ntlogevent -Filter "logfile='security'" | select -Property sourcename, Eventcode, Logfile,message
      $Files=$sec
      $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()}
       if($Pass -eq "1"){ $app = Get-EventLog -LogName "security" -ComputerName $IPAddr -After (Get-Date).AddHours(-24)  }
      if($TOutdisplay -eq "1"){$array.AddRange($Sec) ;$gridsecurity.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $ser > "$env:USERPROFILE\Desktop\Analysis\Security.txt" }
      if($TOutgridAnalysis -eq "1"){ $Sec| Out-GridView}}
function Sys {
       $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
       $sys = Get-WmiObject -class win32_ntlogevent -Filter "logfile='system'" | select -Property sourcename, Eventcode, Logfile,message
       $Files=$sys
       $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()}
      if($Pass -eq "1"){ $app = Get-EventLog -LogName "System" -ComputerName $IPAddr -After (Get-Date).AddHours(-24)  }
    if($TOutdisplay -eq "1"){$array.AddRange($sys) ;$gridsystem.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $sys > "$env:USERPROFILE\Desktop\Analysis\System.txt" }
      if($TOutgridAnalysis -eq "1"){ $sys| Out-GridView}}
function Proc {
       $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
      $pro = Get-WmiObject -class win32_process  | select -Property processName, Processid, parentProcessid, KernelModeTime 
      $Files=$pro
      $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()}
      if($TOutdisplay -eq "1"){$array.AddRange($pro) ;$gridProcesses.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $pro > "$env:USERPROFILE\Desktop\Analysis\Process.txt" }
      if($TOutgridAnalysis -eq "1"){ $pro| Out-GridView}}
function Service {
        $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
       $ser = Get-WmiObject -class win32_service  | select -Property Name, state, startmode,servicetype, Processid,pathname 
        $Files=$ser
        $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()} 
    if($TOutdisplay -eq "1"){$array.AddRange($Ser) ;$gridServices.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $ser > "$env:USERPROFILE\Desktop\Analysis\Service.txt" }
      if($TOutgridAnalysis -eq "1"){ $ser| Out-GridView}}
function conn {
        $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
      $con = Get-NetTCPConnection | select -Property LocalAddress, LocalPort,RemoteAddress , RemotePort,State  
      $Files=$con
      $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()} 
      if($TOutdisplay -eq "1"){$array.AddRange($con) ;$gridConnections.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $con > "$env:USERPROFILE\Desktop\Analysis\Connection.txt" }
      if($TOutgridAnalysis -eq "1"){ $con| Out-GridView}}
function sch {
        $progressbar.value = 0 
      $array = New-Object System.Collections.ArrayList
       $sch =  Get-ScheduledTask | select -Property TaskName,Description,taskname,triggers,actions,settings
          $Files=$sch
          $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()} 
      if($TOutdisplay -eq "1"){$array.AddRange($sch) ;$gridSchTasks.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $sch > "$env:USERPROFILE\Desktop\Analysis\ScheduleTask.txt" }
      if($TOutgridAnalysis -eq "1"){ $sch| Out-GridView}}
function Reg {
      $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
      $keys = @("HKCU:\Software\Microsoft\Windows\CurrentVersion\Run","HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\system.ini\boot","HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders","HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders","HKLM:\SYSTEM\CurrentControlSet\services","HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects","HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs","HKLM:\Software\Classes\","HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\KnownDLLs")
      $Target = @()
      foreach($x in $keys) {
      $Reg = Get-ItemProperty -Path $x -ErrorAction SilentlyContinue
      $Target += $Reg
      }
        Foreach ($x2 in $Target) {
            if($TOutdisplay -eq "1"){$array.Add($x2); $gridregistry.DataSource = $array ;$form.refresh()}
            if($TOuttext -eq "1"){Echo $x2 > "$env:USERPROFILE\Desktop\Analysis\ScheduleTask.txt" }
            if($TOutgridAnalysis -eq "1"){ $x2| Out-GridView}
           
      }
}
function ADUsers {
     $progressbar.value = 0
      $array = New-Object System.Collections.ArrayList
      $ADU = Get-AdUser -Filter 'Enabled -eq $false'
       $Files=$ADU
       $progressbar.Maximum = $files.Count
      foreach ($file in $Files){$progressbar.PerformStep()}   
      if($TOutdisplay -eq "1"){$array.AddRange($ADU) ;$gridActiveD.DataSource = $array ;$form.refresh()}
      if($TOuttext -eq "1"){Echo $ADU > "$env:USERPROFILE\Desktop\Analysis\AD.txt" }
      if($TOutgridAnalysis -eq "1"){ $ADU| Out-GridView}
}
#function Files {
#
#      $array = New-Object System.Collections.ArrayList
#       $Ser =  Get-ScheduledTask | select -Property TaskName,Description,taskname,triggers,actions,settings  
#    if($TOutdisplay -eq "1"){$array.AddRange($Ser) ;$gridSchTasks.DataSource = $array ;$form.refresh()}
#      if($TOuttext -eq "1"){Echo $ser > "$env:USERPROFILE\Desktop\Analysis\Files.txt" }
#}
Function Error{

$Form2                            = New-Object system.Windows.Forms.Form
$Form2.ClientSize                 = '392,145'
$Form2.text                       = "ERROR"
$Form2.BackColor                  = "#111211"
$Form2.TopMost                    = $false

$okButton1                         = New-Object system.Windows.Forms.Button
$okButton1.BackColor               = "#f20c0c"
$okButton1.text                    = "OK"
$okButton1.width                   = 138
$okButton1.height                  = 52
$okButton1.location                = New-Object System.Drawing.Point(136,70)
$okButton1.Font                    = 'Microsoft Sans Serif,10'

$okTextBox1                        = New-Object system.Windows.Forms.TextBox
$okTextBox1.multiline              = $false
$okTextBox1.text                   = "Incorrect IP Format, Please re-enter IP Address"
$okTextBox1.BackColor              = "#000000"
$okTextBox1.width                  = 310
$okTextBox1.height                 = 20
$okTextBox1.location               = New-Object System.Drawing.Point(36,36)
$okTextBox1.Font                   = 'Times New Roman,12'
$okTextBox1.ForeColor              = "#f2140c"

$Form2.controls.AddRange(@($okButton1,$okTextBox1))

$okButton1.Add_Click({ exit })
$Form2.ShowDialog()

} 
