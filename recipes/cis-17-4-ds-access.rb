# Cookbook:: cb_cis_windows_2016
# Recipe:: cis-17-4-ds-access
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# 17.4.1 (L1) Ensure 'Audit Directory Service Access' is set to 'Success and Failure' (DC only)
execute 'Directory Service Access' do
  command 'auditpol /set /subcategory:"Directory Service Access" /success:enable /failure:enable'
  action :run
  only_if { node.default['cb_cis_windows_2016']['cis_level_1'] = true }
end

# 17.4.2 (L1) Ensure 'Audit Directory Service Changes' is set to 'Success and Failure' (DC only)
execute 'Directory Service Changes' do
  command 'auditpol /set /subcategory:"Directory Service Changes" /success:enable /failure:enable'
  action :run
  only_if { node.default['cb_cis_windows_2016']['cis_level_1'] = true }
end
