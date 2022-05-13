resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                = "my-vmss"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  sku                 = "Standard_F2"
  instances           = 2
  admin_password      = "P@55w0rd1234!"
  admin_username      = "adminuser"

  source_image_id = "/subscriptions/de7365e2-8329-48fc-8273-4ab1574e6b4b/resourceGroups/akm-rg/providers/Microsoft.Compute/images/winser-image-custom"
  #source_image_id = "/subscriptions/de7365e2-8329-48fc-8273-4ab1574e6b4b/resourcegroups/akm-rg/providers/Microsoft.Compute/images/dotnetapp-customimage"

  /* source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core"
    version   = "latest"
  } */

  os_disk { 
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = module.subnet.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bep.id]
      
    }
  }
}

resource "azurerm_monitor_autoscale_setting" "vmscale" {
  name                = "autoscalesetting"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  target_resource_id  = azurerm_windows_virtual_machine_scale_set.vmss.id

  profile {
    name = "scaleprofile"

    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_windows_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_windows_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  depends_on = [
    azurerm_windows_virtual_machine_scale_set.vmss
  ]
}