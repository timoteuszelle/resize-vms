<#
Author: Tim Zelle
--
#> 
$path1 = "c:\temp\vcenter\small.txt"
$path2 = "c:\temp\vcenter\medium.txt"
$path3 = "c:\temp\vcenter\large.txt"
$path4 = "c:\temp\vcenter\onoff.txt"
$vcenterserver = ""
$user = ""
Get-Module -ListAvailable *vmware* | Import-Module
asnp vmware*
Connect-VIServer -Server $vcenterserver -User $user

        $list = (Get-Content -path $path4) 
        Foreach ($vm in $list){
        get-vm -name $vm | stop-vm -Confirm $false -RunAsync
        } #this loop stops the vms

        $list = (Get-Content -path $path1) 
        Foreach ($vm in $list){
        get-vm -name $vm |Set-VM -NumCpu 2 -CoresPerSocket 2 -MemoryGB 4 -confirm:$false
        } #this loop sets vms 1*2 and 4gb mem
       
        $list = (Get-Content -path $path2) 
        Foreach ($vm in $list){
        get-vm -name $vm |Set-VM -NumCpu 8 -CoresPerSocket 4 -confirm:$false
        } #this loop sets vms 2*4

        $list = (Get-Content -path $path3) 
        Foreach ($vm in $list){
        get-vm -name $vm |Set-VM -NumCpu 16 -CoresPerSocket 8 -confirm:$false
        } #this loop sets vms cpu 2*8

        $list = (Get-Content -path $path4)
        Foreach ($vm in $list){
        Get-VM $vm| Start-VM -RunAsync
        } #this loop starts the vms