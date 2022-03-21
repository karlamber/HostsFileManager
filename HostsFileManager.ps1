<#
    Author: by Karl Amber
    Created: May 22, 2014
    Last Updated: March 20, 2022 - Made miscellaneous UI updates & improvements.

    Synopsis:
        Executed from a shared network location - this script will present a dialog box displaying:
            Currently Active hosts entries on the local computer.
            A list of managed hosts entry groups that can be added and removed.
            A discrete edit button that will open the local hosts file in notepad.
        Groups are loaded from <groupname>.hosts files in the following locations:
                1 - location script was executed from
                2 - subdirectories in the location script was executed from (good for limiting access to specific groups)
                3 - the local computer's c:\windows\system32\drivers\etc\ folder
        Remove button only removes all entries with the word "Managed" in the comment.

    Note:  Hosts entries MUST be created with the word "Managed" in the comment in order to be removed with the Hosts Manager.
#>

# Display information to Console Window (If not hidden by shortcut switch)
Write-Output "Running Hosts Management GUI......"
Write-Output "This window will close when the GUI is closed"

$appTitle = "Hosts File Manager"
Try {[io.file]::OpenWrite("c:\windows\system32\drivers\etc\hosts").close()} Catch {$perms = "readonly";$appTitle = $appTitle + ' (Read Only)'}

# Define Window Characteristics
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="$appTitle" WindowStartupLocation = "CenterScreen"
    SizeToContent = "WidthAndHeight" ShowInTaskbar = "True" Background = "lightgray" ResizeMode = "NoResize"> 
    <StackPanel Orientation = 'Horizontal' >  
        <StackPanel x:Name = "leftPanel" Margin = "5" Background = 'lightgray' >
            <TextBox Text = "Actions:" Height = '30' Padding = '5' Background = "lightgray" FontSize = '15' BorderThickness = '0' HorizontalAlignment = "Left"/>
            <Button x:Name = "removeButton" Height = "35" Width = "215" Margin = "5" FontSize = '15' Content = 'Remove All Managed Entries'> 
                <Button.Style>
                    <Style TargetType="{x:Type Button}">
                        <Setter Property="Background" Value="slategray"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="{x:Type Button}">
                                    <Border Background="{TemplateBinding Background}">
                                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                        <Style.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="firebrick"/>
                            </Trigger>
                        </Style.Triggers>
                    </Style>
                </Button.Style>
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="5"/>
                    </Style>
                </Button.Resources>
            </Button>
            <Button x:Name = "editButton" Height = "35" Width = "215" Margin = "5" FontSize = '15' Content = 'Edit Hosts File'> 
                <Button.Style>
                    <Style TargetType="{x:Type Button}">
                        <Setter Property="Background" Value="slategray"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="{x:Type Button}">
                                    <Border Background="{TemplateBinding Background}">
                                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                        <Style.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="gold"/>
                            </Trigger>
                        </Style.Triggers>
                    </Style>
                </Button.Style>
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="5"/>
                    </Style>
                </Button.Resources>
            </Button>
            <Button x:Name = "addButton" Height = "35" Width = "215" Margin = "5" FontSize = '15' Content = 'Add Selected Entries'>
                <Button.Style>
                    <Style TargetType="{x:Type Button}">
                        <Setter Property="Background" Value="slategray"/>
                        <Setter Property="Template">
                            <Setter.Value>
                                <ControlTemplate TargetType="{x:Type Button}">
                                    <Border Background="{TemplateBinding Background}">
                                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                    </Border>
                                </ControlTemplate>
                            </Setter.Value>
                        </Setter>
                        <Style.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="darkseagreen"/>
                            </Trigger>
                        </Style.Triggers>
                    </Style>
                    </Button.Style>
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="5"/>
                    </Style>
                </Button.Resources>
            </Button>
            <TextBox Text = "Available Host Groups:" Height = '30' Padding = '5' Background = "lightgray" FontSize = '15' BorderThickness = '0' HorizontalAlignment = "Left"/>
            <ListBox x:Name = "fileList" Height = "290" />
        </StackPanel>
        <StackPanel x:Name = "rightPanel" Margin = "5" Background = 'lightgray' >
            <TextBox Text="Currently Active Hosts Entries:">
                <TextBox.Style>
                    <Style TargetType="TextBox">
                        <Setter Property="IsReadOnly" Value="True" />
                        <Setter Property="BorderThickness" Value="0" />
                        <Setter Property="Background" Value="lightgray" />
                        <Setter Property="FontSize" Value="15" />
                        <Setter Property="Width" Value="475" />
                        <Setter Property="Height" Value="30" />
                        <Setter Property="Padding" Value="5" />
                        </Style>
                </TextBox.Style>
            </TextBox>
            <TextBox Height="450" Margin="5" ScrollViewer.VerticalScrollBarVisibility="Visible" Name='currentHosts' />
        </StackPanel>
    </StackPanel>
</Window>
"@
Add-Type -AssemblyName presentationframework
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load( $reader )

# Connect Variables to  Controls
$editButton = $Window.FindName("editButton")
$removeButton = $Window.FindName("removeButton")
$addButton = $Window.FindName("addButton")
$currentHosts = $Window.FindName("currentHosts")
$fileList = $Window.FindName("fileList")

# Identify .hosts files where script located
$Scriptroot = Split-Path -Path $MyInvocation.MyCommand.path
$hostsFiles = (Get-ChildItem -Recurse $ScriptRoot\*.hosts | Sort-Object BaseName)

# Identify .hosts files in the local C:\Windows\System32\Drivers\Etc location
$hostsFiles += (Get-ChildItem C:\Windows\System32\Drivers\Etc\*.hosts | Sort-Object BaseName)

# Create List of Hosts Entries Available
Foreach ($H in $hostsFiles.BaseName){$fileList.Items.Add($H)| Out-Null}

# Display current hosts entries
If (!(Test-path "C:\Windows\System32\drivers\etc\hosts.original")) {Copy-Item 'C:\Windows\System32\drivers\etc\hosts' "C:\Windows\System32\drivers\etc\hosts.original";Add-Content -Encoding UTF8 -Value "`n`n" -Path C:\Windows\System32\drivers\etc\hosts}
$data = Get-Content "c:\Windows\System32\drivers\etc\hosts" | Where-Object {($_ -notmatch "^$") -AND ($_ -notlike "#*")}
$currentHosts.Text = $Data | Out-String

$editButton.Add_Click({
    Start-Process -Verb Runas notepad.exe "C:\Windows\System32\drivers\etc\hosts" -wait
    $data = Get-Content "c:\Windows\System32\drivers\etc\hosts" | Where-Object {($_ -notmatch "^$") -AND ($_ -notlike "#*")}
    $currentHosts.Text = $Data | Out-String
})

$removeButton.Add_Click({
    If ($perms -ne "readonly"){
        $PreHosts = Get-Content C:\Windows\System32\drivers\etc\hosts | Where-Object {$_ -notlike "*Managed*"}
        $PreHosts | Out-File C:\Windows\System32\drivers\etc\hosts -Encoding utf8
        $data = Get-Content "c:\Windows\System32\drivers\etc\hosts" | Where-Object {($_ -notmatch "^$") -AND ($_ -notlike "#*")}
        $currentHosts.Text = $Data | Out-String
    }
})

$addButton.Add_Click({
    If ($perms -ne "readonly"){
        If ($fileList.SelectedValue -ne $null){
            Add-Content -ErrorAction Stop -Encoding UTF8 -Value (Get-Content ($hostsFiles | Where-Object {$_.basename -match $fileList.SelectedValue} | Select-Object -ExpandProperty FullName)) -Path C:\Windows\System32\drivers\etc\hosts
        }
        $data = Get-Content "c:\Windows\System32\drivers\etc\hosts" | Where-Object {($_ -notmatch "^$") -AND ($_ -notlike "#*")}
        $currentHosts.Text = $Data | Out-String
    }
})

$Window.ShowDialog() | Out-Null