# Resource-2: Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name = "myvnet-1"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tags = {
    "CreatedBy" = "terraform"
    "Name" = "myvnet-1"
    "Environment" = "Dev"
  }

}

# Resource-3: Create Subnet
resource "azurerm_subnet" "mysubnet" {
  name = "mysubnet-1"
  resource_group_name = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes = ["10.0.2.0/24"]
}


# Resource-4: Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  # Add Explicit Dependency to have this resource created only after Virtual Network and Subnet Resources are created. 
  depends_on = [
    azurerm_virtual_network.myvnet,
    azurerm_subnet.mysubnet
  ]

  name = "mypublicip-1"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method = "Static"
  domain_name_label = "app1-vm-${random_string.myrandom.id}"
  tags = {
    "environment" = "Dev"
  }
  
}


# Resource-5: Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  name = "vmnic1"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mypublicip.id

  }
 
}



