Add-Type -AssemblyName PresentationFramework

function Create-CustomMessageBox($message, $x, $y) {
    $window = New-Object Windows.Window
    $window.Title = "Tilpasset Alertbox"
    $window.Width = 300
    $window.Height = 100
    $window.Left = $x
    $window.Top = $y
    $window.WindowStartupLocation = [Windows.WindowStartupLocation]::Manual
    
    $label = New-Object Windows.Controls.Label
    $label.Content = $message
    $label.HorizontalAlignment = 'Center'
    $label.VerticalAlignment = 'Center'
    
    $window.Content = $label
    $window.Add_Closed({
        $script:activeWindows--
    })
    $window.Show()
    $script:activeWindows++
}

$random = New-Object System.Random
$numberOfBoxes = $random.Next(50, 300)
$script:activeWindows = 0

for ($i = 0; $i -lt $numberOfBoxes; $i++) {
    $x = $random.Next(0, [System.Windows.SystemParameters]::PrimaryScreenWidth - 300)
    $y = $random.Next(0, [System.Windows.SystemParameters]::PrimaryScreenHeight - 100)
    Create-CustomMessageBox -message "YOU GOT HACKET BY JST0X" -x $x -y $y
}

while ($script:activeWindows -gt 0) {
    Start-Sleep -Milliseconds 500
}
