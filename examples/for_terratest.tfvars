environment         = "test"
resource_group_name = "RG-TEST-APIM"
apim_name           = "spnl-test-apim"
subnet_details = {
  name             = "SN-TEST-APIM"
  rg_name          = "RG-TEST-CORE-01"
  vnet             = "VN-TEST-INT-01"
  address_prefixes = ["10.0.0.1/29"]
}
