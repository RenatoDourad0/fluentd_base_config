# executar como admin psexec \\000.000.0.000 -u username -p senha powershell.exe -File "caminho\para\setup-fluentd.ps1"

# Baixar o instalador MSI
$installerUrl = "https://s3.amazonaws.com/packages.treasuredata.com/5/windows/fluent-package-5.0.0-x64.msi"
$installerPath = "C:\temp\fluentd.msi"
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Baixar o arquivo de configuração
$configUrl = "url_do_seu_bucket/config_file.conf" # bucket com arquivos de configuracao
$configPath = "C:\temp\fluentd\fluentd.conf" # caminho esperado pelo fluentd
Invoke-WebRequest -Uri $configUrl -OutFile $configPath

# Instalar o Fluentd
$installCommand = "msiexec.exe /i $installerPath /qn"
Start-Process -FilePath cmd.exe -ArgumentList "/c $installCommand" -Wait

# Instalar os plugins necessários
$pluginsFilePath = "./install_plugins.bat" # caminho script plugins
Start-Process -FilePath cmd.exe -ArgumentList "/c $pluginsFilePath" -Wait

# Copiar o arquivo de configuração
$configCommand = "copy $configPath C:\fluentd\etc\fluentd.conf"
Start-Process -FilePath cmd.exe -ArgumentList "/c $configCommand" -Wait

# Iniciar o serviço Fluentd
$startServiceCommand = "sc start fluentdwinsvc"
Start-Process -FilePath cmd.exe -ArgumentList "/c $startServiceCommand" -Wait

# Configurar reativação automática
$serviceName = "fluentdwinsvc"
$wmiObjectPath = "Win32_Service.Name='$serviceName'"
(Get-WmiObject -Query "Select * From $wmiObjectPath").ChangeStartMode("Automatic")
