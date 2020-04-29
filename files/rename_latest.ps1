param ($vs_hostname, $vs_name, $vs_password, $inventory_hostname, $newname)

Connect-VIServer -Server $vs_hostname -User $vs_name -Password $vs_password | Out-Null

Set-VM -Template $vs_template -Name $newname
