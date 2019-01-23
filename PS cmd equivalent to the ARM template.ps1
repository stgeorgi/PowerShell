#code used to copy Win10 vhd to storage account and create image for WVD testing
#create resourcegroup 
$rgname="Win10WDS"
New-AzResourceGroup -Name $rgname -Location eastus2 
$rg = Get-AzResourceGroup -Name $rgname

# Set the name of the storage account and the SKU name. 
$storageAccountName = "win10image01"
$skuName = "Standard_LRS"

# Create the storage account.
New-AzStorageAccount -ResourceGroupName $rg.ResourceGroupName `
  -Name $StorageAccountName `
  -Location $rg.Location `
  -SkuName $skuName `
  -Kind StorageV2

#create contaioner
Set-AzCurrentStorageAccount -ResourceGroupName $rg.ResourceGroupName -Name $StorageAccountName
New-AzStorageContainer -Name "images" -Permission Off

#Copy Image to storage account
$dstkey = Get-AzStorageAccountKey -StorageAccountName $storageAccountName -ResourceGroupName $rg.ResourceGroupName
$dstcontext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $dstkey.Value[0]
$copyblob = Start-AzStorageBlobCopy -AbsoluteUri "https://rdmipreview.blob.core.windows.net/vhds/17763.17.Windows10.Enterprise.For.Virtual.Desktops-en-us_vl.vhd?sp=r&st=2019-01-05T00:43:37Z&se=2019-02-01T08:43:37Z&spr=https&sv=2018-03-28&sig=ynbBTrPNRKoYc9Ss%2FhhOGboY4HAcX3%2FH5RVeRqhDqDg%3D&sr=b" -DestContext $dstcontext -DestContainer "images" -DestBlob Win10wvdJan14.vhd
$copyblob | Get-AzStorageBlobCopyState -WaitForComplete

#create Image 
#Note: Make sure to update the osVhdUri to yours
$imageName ="win10jan14image"
$osVhdUri ="https://win10image01.blob.core.windows.net/images/Win10wvdJan14.vhd"
$imageConfig = New-AzImageConfig -Location $rg.Location
$imageConfig = Set-AzImageOsDisk -Image $imageConfig -OsType Windows -OsState Generalized -BlobUri $osVhdUri
New-AzImage -ImageName $imageName -ResourceGroupName $rg.ResourceGroupName -Image $imageConfig

#Create Win10 Virtual machine to test image
$vmName = 'Win10Jan14VM2'
New-AzVm `
    -ResourceGroupName $rg.ResourceGroupName `
    -Name $vmName `
    -ImageName $imageName `
    -Location $rg.Location `
    -VirtualNetworkName "win10VNET" `
    -SubnetName "Subnet1" `
    -SecurityGroupName "Win10NSG" `
    -PublicIpAddressName "Win10Jan14PIP2" `
    -OpenPorts 3389
