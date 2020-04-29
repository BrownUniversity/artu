param ($vs_hostname, $vs_name, $vs_password, $vs_template, $newname)

Connect-VIServer -Server $vs_hostname -User $vs_name -Password $vs_password | Out-Null

Set-Template -Template $vs_template -Name $newname
